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
        let dividendIsLessThanZero: Bool = /**/self.isLessThanZero
        let  divisorIsLessThanZero: Bool =  divisor.isLessThanZero
        //=--------------------------------------=
        var qr: QR<Magnitude, Magnitude> = self.magnitude._quotientAndRemainderAsUnsigned(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            let quotientWasLessThanZero = qr.quotient.mostSignificantBit
            qr.quotient.formTwosComplement()
            let overflow = quotientWasLessThanZero && qr.quotient.mostSignificantBit
            precondition(!overflow, "quotient overflow during division")
        }
        
        if  dividendIsLessThanZero {
            qr.remainder.formTwosComplement() // cannot overflow: abs <= max
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
            qr.quotient .formTwosComplement() // truncates overflow scenario
        }
        
        if  dividendIsLessThanZero {
            qr.remainder.formTwosComplement() // cannot overflow: abs <= max
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where Self == Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing the dividend by the divisor.
    ///
    /// Performs long division but with word-sized digits.
    ///
    @_specialize(where Self == ANKUInt128)
    @_specialize(where Self == ANKUInt256)
    @_specialize(where Self == ANKUInt512)
    @inlinable func _quotientAndRemainderAsUnsigned(dividingBy divisor: Self) -> QR<Self, Self> {
        let divisor_ = divisor.minLastIndexReportingIsZeroOrMinusOne()
        precondition(!divisor_.isZeroOrMinusOne, "division by zero")
        //=--------------------------------------=
        if  self <= divisor {
            return self == divisor ? QR(1, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        if  divisor_.minLastIndex.isZero {
            let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor.first)
            return  QR(qr.quotient, Self(digit: qr.remainder))
        }
        //=--------------------------------------=
        // Shifting To Clamp Approximation Range
        //=--------------------------------------=
        let shift = divisor[unchecked: divisor_.minLastIndex].leadingZeroBitCount
        let divisor = divisor._bitshiftedLeft(words: Int(), bits: shift) as Self
        
        var remainder  = Plus1(descending: HL(UInt(), self))
        let remainder_ = remainder.low.minLastIndexReportingIsZeroOrMinusOne()
        remainder._bitshiftLeft(words: Int(), bits: shift)
        //=--------------------------------------=
        assert(divisor_.minLastIndex >= 1)
        assert(divisor_.minLastIndex <= remainder_.minLastIndex)
        //=--------------------------------------=
        // Division
        //=--------------------------------------=
        var quotient = Self(); quotient.withUnsafeMutableWordsPointer { QUOTIENT in
            var remainderIndex = remainder_.minLastIndex &+ 1
            var  quotientIndex = remainderIndex &-  divisor_.minLastIndex
            let   divisorLast0 = divisor[unchecked: divisor_.minLastIndex]
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                //=------------------------------=
                // Approximate Quotient Digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWordsPointer { REMAINDER in
                    let  remainderLast0  = REMAINDER[remainderIndex]
                    REMAINDER.formIndex(before:/*-*/&remainderIndex)
                    if   remainderLast0 >= divisorLast0 { return UInt.max }
                    let  remainderLast1  = REMAINDER[remainderIndex]
                    return divisorLast0.dividingFullWidth(HL(remainderLast0, remainderLast1)).quotient
                }
                //=------------------------------=
                let increment/**/ = Plus1(descending: HL(UInt(), divisor._bitshiftedLeft(words: quotientIndex, bits: Int())))
                var approximation = Plus1(descending: increment.low.multipliedFullWidth(by: digit) as HL<Digit, Magnitude>)
                //=------------------------------=
                // Correct Digit At Most Twice
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
            }
        }
        //=--------------------------------------=
        // Shifting To Undo Shift Before Division
        //=--------------------------------------=
        remainder._bitshiftRight(words: Int(), bits: shift)
        //=--------------------------------------=
        assert(remainder.high.isZero)
        //=--------------------------------------=
        return QR(quotient, remainder.low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func _dividingFullWidthAsUnsigned(_ dividend: DoubleWidth) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending: HL(dividend.high, dividend.low))
        let divisor  = DoubleWidth(descending: HL(Self(), self))
        let qr: QR<DoubleWidth, DoubleWidth> = dividend._quotientAndRemainderAsUnsigned(dividingBy: divisor)
        return  QR(qr.quotient.low, qr.remainder.low)
    }
}
