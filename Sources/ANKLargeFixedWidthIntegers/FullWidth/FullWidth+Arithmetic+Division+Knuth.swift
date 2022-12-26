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
// MARK: * ANK x Full Width x Division x Knuth
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideAsKnuth(by divisor: Self) {
        precondition(!self.divideReportingOverflowAsKnuth(by: divisor))
    }
    
    @inlinable func dividedAsKnuth(by divisor: Self) -> Self {
        let pvo: PVO<Self> = self.dividedReportingOverflowAsKnuth(by: divisor)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable mutating func formRemainderAsKnuth(dividingBy divisor: Self) {
        precondition(!self.formRemainderReportingOverflowAsKnuth(by: divisor))
    }
    
    @inlinable func remainderAsKnuth(dividingBy divisor: Self) -> Self {
        let pvo: PVO<Self> = self.remainderReportingOverflowAsKnuth(dividingBy: divisor)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflowAsKnuth(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflowAsKnuth(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func dividedReportingOverflowAsKnuth(by divisor: Self) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == -1, self == Self.min {
            return PVO(self, true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Self> = self.quotientAndRemainderAsKnuth(dividingBy: divisor)
        return PVO(qr.quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflowAsKnuth(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflowAsKnuth(dividingBy: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func remainderReportingOverflowAsKnuth(dividingBy divisor: Self) -> PVO<Self> {
        //=--------------------------------------=
        if  divisor.isZero {
            return PVO(self, true)
        }
        //=--------------------------------------=
        if  Self.isSigned, divisor == -1, self == Self.min {
            return PVO(Self(), true)
        }
        //=--------------------------------------=
        let qr: QR<Self, Self> = self.quotientAndRemainderAsKnuth(dividingBy: divisor)
        return  PVO(qr.remainder, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let dividendIsLessThanZero: Bool = self.isLessThanZero
        var qr: QR<Magnitude, Magnitude> = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            let overflow: Bool = qr.quotient.formTwosComplementReportingOverflow()
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
    
    @inlinable func dividingFullWidthAsKnuth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let divisorIsLessThanZero: Bool = self.isLessThanZero
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero: Bool = dividend.isLessThanZero
        var qr: QR<Magnitude, Magnitude> = self.magnitude.dividingFullWidthAsKnuth(dividend.magnitude)
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


//*============================================================================*
// MARK: * ANK x Full Width x Unsigned x Division x Knuth
//*============================================================================*

extension ANKFullWidth where Self: AwesomeUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing the dividend by the divisor.
    ///
    /// It is basically long division but with larger digits than those in base 10.
    ///
    @inlinable func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
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
        let _remainder = remainder.low.minWordCountReportingIsZeroOrMinusOne() // hm...
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
        var quotient = Self(); quotient.withUnsafeMutableWords { QUOTIENT in
            let divisorLast =  divisor.low[unchecked: divisorMinLastIndex]
            var remainderIndex = _remainder.minWordCount
            var  quotientIndex = _remainder.minWordCount &- divisorMinLastIndex
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                //=------------------------------=
                // Approximate Quotient Digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords { REMAINDER in
                    let  remainderLast0 = REMAINDER[unchecked: remainderIndex]
                    REMAINDER.formIndex(before: &remainderIndex)
                    
                    if  remainderLast0 >= divisorLast { return UInt.max }
                    let remainderLast1  = REMAINDER[unchecked: remainderIndex]
                    let remainderLastX  = HL(remainderLast0,   remainderLast1)
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
                QUOTIENT[unchecked: quotientIndex] = digit
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
    
    @inlinable func dividingFullWidthAsKnuth(_ dividend: DoubleWidth) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending:(dividend.high, dividend.low))
        let divisor  = DoubleWidth(descending:(Self(), Magnitude(bitPattern: self)))
        let qr: QR<DoubleWidth, DoubleWidth> = dividend.quotientAndRemainderAsKnuth(dividingBy: divisor)
        return  QR(Self(bitPattern: qr.quotient.low), Self(bitPattern: qr.remainder.low))
    }
}
