//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Full Width x Division
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.divideReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow)
    }
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == (-1 as Self), self == Self.min {
            return PVO(self, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Self> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.quotient, false)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(dividingBy divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == (-1 as Self), self == Self.min {
            return PVO(Self(), true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Self> = self.quotientAndRemainder(dividingBy: divisor)
        return  PVO(qr.remainder, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let dividendIsLessThanZero: Bool =    self.isLessThanZero
        let  divisorIsLessThanZero: Bool = divisor.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, Magnitude> = self.magnitude._quotientAndRemainderAsUnsigned(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            let overflow = qr.quotient._negateReportingOverflowAsSigned()
            precondition(!overflow, "quotient overflowed during division")
        }
        
        if  dividendIsLessThanZero {
            qr.remainder.formTwosComplement()
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero: Bool = dividend.isLessThanZero
        let  divisorIsLessThanZero: Bool = /**/self.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, Magnitude> = self.magnitude._dividingFullWidthAsUnsigned(dividend.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            qr.quotient.formTwosComplement()
        }
        
        if  dividendIsLessThanZero {
            qr.remainder.formTwosComplement()
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing this value by the divisor.
    ///
    /// Performs unsigned long division with `UInt` digits.
    ///
    @_specialize(where Self == ANKUInt128)
    @_specialize(where Self == ANKUInt192)
    @_specialize(where Self == ANKUInt256)
    @_specialize(where Self == ANKUInt384)
    @_specialize(where Self == ANKUInt512)
    @inlinable func _quotientAndRemainderAsUnsigned(dividingBy divisor: Self) -> QR<Self, Self> {
        let divisor_ = divisor.minLastIndexReportingIsZeroOrMinusOne()
        precondition(!divisor_.isZeroOrMinusOne, "division by zero")
        //=--------------------------------------=
        // Fast: Dividend <= Divisor
        //=--------------------------------------=
        if  self <= divisor {
            return self == divisor ? QR(1, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Fast: Divisor Is One Word
        //=--------------------------------------=
        if  divisor_.minLastIndex.isZero {
            let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor.first)
            return  QR(qr.quotient,   Self(digit: qr.remainder))
        }
        //=--------------------------------------=
        let dividend_ = self.minLastIndexReportingIsZeroOrMinusOne()
        let minLastIndexGapSize: Int = dividend_.minLastIndex &- divisor_.minLastIndex
        let shift: Int = divisor[unchecked: divisor_.minLastIndex].leadingZeroBitCount
        //=--------------------------------------=
        // Shift To Clamp Approximation
        //=--------------------------------------=
        var remainder = Plus1(descending: HL(UInt(), self))
        remainder._bitshiftLeft(words: Int(), bits:  shift)
        
        var increment = Plus1(descending: HL(UInt(), divisor))
        increment.low._bitshiftLeft(words: minLastIndexGapSize, bits: shift)
        
        let discriminant: UInt = increment.low[unchecked: dividend_.minLastIndex]
        assert(discriminant.mostSignificantBit)
        //=--------------------------------------=
        // Division
        //=--------------------------------------=
        let quotient = Self.fromUnsafeMutableWords { QUOTIENT in
            QUOTIENT.base.update(repeating: UInt(), count: QUOTIENT.count)
            //=----------------------------------=
            var  quotientIndex: Int = 1 &+ minLastIndexGapSize
            var remainderIndex: Int = 1 &+ dividend_.minLastIndex
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                //=------------------------------=
                // Approximate Quotient Digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords { REMAINDER in
                    let  remainderLast0  = REMAINDER[remainderIndex]
                    REMAINDER.formIndex(before:/*-*/&remainderIndex)
                    if   remainderLast0 >= discriminant { return UInt.max }
                    let  remainderLast1  = REMAINDER[remainderIndex]
                    return discriminant.dividingFullWidth(HL(remainderLast0, remainderLast1)).quotient
                }
                //=------------------------------=
                var approximation = Plus1(descending: increment.low.multipliedFullWidth(by: digit))
                //=------------------------------=
                // Decrement If Overestimated
                //=------------------------------=
                if  approximation > remainder {
                    brrrrrrrrrrrrrrrrrrrrrrr: do { digit &-= 1; approximation &-= increment }
                    if approximation > remainder { digit &-= 1; approximation &-= increment }
                }
                //=------------------------------=
                assert(approximation <= remainder)
                //=------------------------------=
                remainder &-= approximation
                QUOTIENT[quotientIndex] = digit
                increment.low._bitshiftRight(words: 1, bits: Int())
            }
        }
        //=--------------------------------------=
        // Undo Shift Before Division
        //=--------------------------------------=
        remainder._bitshiftRight(words: Int(), bits: shift)
        //=--------------------------------------=
        return QR(quotient, remainder.low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func _dividingFullWidthAsUnsigned(_ dividend: DoubleWidth) -> QR<Self, Self> {
        let divisor = DoubleWidth(descending: HL(Self(), self))
        let qr: QR<DoubleWidth, DoubleWidth> = dividend._quotientAndRemainderAsUnsigned(dividingBy: divisor)
        return  QR(qr.quotient.low, qr.remainder.low)
    }
}
