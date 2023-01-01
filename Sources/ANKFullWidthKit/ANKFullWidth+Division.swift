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
        precondition(!lhs.divideReportingOverflow(by: rhs))
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        precondition(!lhs.formRemainderReportingOverflow(by: rhs))
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
        if  Self.isSigned, divisor == -1, self == Self.min {
            return PVO(self, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Self> = self.quotientAndRemainder(dividingBy: divisor)
        return PVO(qr.quotient, false)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == -1, self == Self.min {
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
        let dividendIsLessThanZero: Bool = self.isLessThanZero
        var qr: QR<Magnitude, Magnitude> = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
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
        let divisorIsLessThanZero: Bool = self.isLessThanZero
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero: Bool = dividend.isLessThanZero
        var qr: QR<Magnitude, Magnitude> = self.magnitude._dividingFullWidth(dividend.magnitude)
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

extension ANKFullWidth where Self: ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing the dividend by the divisor.
    ///
    /// It is basically long division but with large digits.
    ///
    @inlinable func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let _divisor = divisor.minWordCountReportingIsZeroOrMinusOne()
        let divisorMinLastIndex = divisor.index(before: _divisor.minWordCount)
        precondition(!_divisor.isZeroOrMinusOne, "division by zero")
        //=--------------------------------------=
        // Fast x Dividend <= Divisor
        //=--------------------------------------=
        if  self <= divisor {
            return (self == divisor) ? QR(1, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Fast x Divisor Is One Word
        //=--------------------------------------=
        if  divisorMinLastIndex.isZero {
            let qr: QR<Self, Digit> = self.quotientAndRemainder(dividingBy: divisor.first)
            return  QR(qr.quotient, Self(digit: qr.remainder))
        }
        //=--------------------------------------=
        // << To Clamp Digit Approximation Range
        //=--------------------------------------=
        let shift = divisor[unchecked: divisorMinLastIndex].leadingZeroBitCount
        var divisor = Plus1(descending:(UInt(), Magnitude(bitPattern: divisor)))
        //=--------------------------------------=
        var  remainder = Plus1(descending:(UInt(), Magnitude(bitPattern: self)))
        let _remainder = remainder.low.minWordCountReportingIsZeroOrMinusOne() // hm
        let  remainderMinLastIndex = remainder.index(before: _remainder.minWordCount)
        //=--------------------------------------=
        divisor.low._bitshiftLeft(words: Int(), bits: shift)
        remainder  ._bitshiftLeft(words: Int(), bits: shift)
        //=--------------------------------------=
        assert(  divisorMinLastIndex as Int >= 1)
        assert(remainderMinLastIndex as Int >= 1)
        assert(remainderMinLastIndex as Int >= divisorMinLastIndex)
        //=--------------------------------------=
        // The Main Loop
        //=--------------------------------------=
        var quotient = Self(); quotient.withUnsafeMutableWordsPointer { QUOTIENT in
            let divisorLast =  divisor.low[unchecked: divisorMinLastIndex]
            var remainderIndex = _remainder.minWordCount
            var  quotientIndex = _remainder.minWordCount &- divisorMinLastIndex
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                //=------------------------------=
                // Approximate Quotient Digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWordsPointer { REMAINDER in
                    let remainderLast0  = REMAINDER[remainderIndex]
                    REMAINDER.formIndex(before: &remainderIndex)
                    
                    if  remainderLast0 >= divisorLast { return UInt.max }
                    let remainderLast1  = REMAINDER[remainderIndex]
                    let remainderLastX  = HL(remainderLast0, remainderLast1)
                    return divisorLast.dividingFullWidth(remainderLastX).quotient
                }
                //=------------------------------=
                let increment = divisor._bitshiftedLeft(words: quotientIndex, bits: Int()) as Plus1
                var approximation = increment.multipliedFullWidth(by: digit).low as Plus1
                //=------------------------------=
                if  approximation > remainder {
                    brrrrrrrrrrrrrrrrrrrrrrr: do { digit &-= 1; approximation &-= increment }
                    if approximation > remainder { digit &-= 1; approximation &-= increment }
                }
                //=------------------------------=
                assert(approximation <= remainder)
                remainder &-= approximation
                QUOTIENT[quotientIndex] = digit
            }
        }
        //=--------------------------------------=
        // >> To Undo Shift From Before Main Loop
        //=--------------------------------------=
        remainder._bitshiftRight(words: Int(), bits: shift)
        return QR(quotient, Self(bitPattern: remainder.low))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func _dividingFullWidth(_ dividend: DoubleWidth) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending:(dividend.high, dividend.low))
        let divisor  = DoubleWidth(descending:(Self(), Magnitude(bitPattern: self)))
        let qr: QR<DoubleWidth, DoubleWidth> = dividend.quotientAndRemainder(dividingBy: divisor)
        return  QR(Self(bitPattern: qr.quotient.low), Self(bitPattern: qr.remainder.low))
    }
}