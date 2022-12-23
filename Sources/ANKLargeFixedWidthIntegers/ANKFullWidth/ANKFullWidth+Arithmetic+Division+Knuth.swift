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
        let o = self.divideReportingOverflowAsKnuth(by: divisor); precondition(!o)
    }
    
    @inlinable func dividedAsKnuth(by divisor: Self) -> Self {
        let (pv, o) = self.dividedReportingOverflowAsKnuth(by: divisor); precondition(!o); return pv
    }
    
    @inlinable mutating func formRemainderAsKnuth(dividingBy divisor: Self) {
        let o = self.formRemainderReportingOverflowAsKnuth(by: divisor); precondition(!o)
    }
    
    @inlinable func remainderAsKnuth(dividingBy divisor: Self) -> Self {
        let (pv, o) = self.remainderReportingOverflowAsKnuth(dividingBy: divisor); precondition(!o); return pv
    }
    
    @inlinable mutating func divideReportingOverflowAsKnuth(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflowAsKnuth(by: divisor); return o
    }
    
    @inlinable func dividedReportingOverflowAsKnuth(by divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainderAsKnuth(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflowAsKnuth(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflowAsKnuth(dividingBy: divisor); return o
    }
    
    @inlinable func remainderReportingOverflowAsKnuth(dividingBy divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Self(), true) }
        return PVO(self.quotientAndRemainderAsKnuth(dividingBy: divisor).remainder, false)
    }
    
    @inlinable mutating func divideReportingRemainderAsKnuth(dividingBy divisor: Self) -> Self {
        let (q, r) = self.quotientAndRemainderAsKnuth(dividingBy: divisor); self = q; return r
    }
    
    @inlinable mutating func formRemainderReportingQuotientAsKnuth(dividingBy divisor: Self) -> Self {
        let (q, r) = self.quotientAndRemainderAsKnuth(dividingBy: divisor); self = r; return q
    }
    
    @inlinable func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let dividendIsLessThanZero = self.isLessThanZero
        var qr = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            let overflow = qr.quotient.formTwosComplementReportingOverflow()
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
        let divisorIsLessThanZero = self.isLessThanZero
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero = dividend.isLessThanZero
        var qr = self.magnitude.dividingFullWidthAsKnuth(dividend.magnitude)
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
        let _divisor = divisor.minLastIndexReportingIsZeroOrMinusOne()
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
        if  _divisor.minLastIndex.isZero {
            let qr = self.quotientAndRemainder(dividingBy: divisor.first) as QR<Self, Digit>
            return QR(qr.quotient, Self(digit: qr.remainder))
        }
        //=--------------------------------------=
        // << To Clamp Digit Approximation Range
        //=--------------------------------------=
        var divisor = divisor
        let divisorShift = divisor[unchecked: _divisor.minLastIndex].leadingZeroBitCount
        
        var  remainder = ExtraDigitWidth(descending:(UInt(), Magnitude(bitPattern: self)))
        let _remainder = remainder.low.minLastIndexReportingIsZeroOrMinusOne() // hm...
        
        divisor  ._bitshiftLeft(words: Int(), bits: divisorShift)
        remainder._bitshiftLeft(words: Int(), bits: divisorShift)
        
        assert(  _divisor.minLastIndex as Int >= 1)
        assert(_remainder.minLastIndex as Int >= 1)
        assert(_remainder.minLastIndex as Int >= _divisor.minLastIndex)
        //=--------------------------------------=
        // The Main Loop
        //=--------------------------------------=
        var quotient = Self(); quotient.withUnsafeMutableWords { QUOTIENT in
            var remainderIndex = _remainder.minLastIndex &+ 1 as Int
            var  quotientIndex = remainderIndex &- _divisor.minLastIndex as Int
            //=----------------------------------=
            let divisorLast0 = divisor[unchecked: _divisor.minLastIndex]
            //=----------------------------------=
            while quotientIndex != QUOTIENT.startIndex {
                 QUOTIENT.formIndex(before: &quotientIndex)
                //=------------------------------=
                // Approximate The Quotient Digit
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords { REMAINDER in
                    let  remainderLast0  = REMAINDER[unchecked: remainderIndex]
                    REMAINDER.formIndex(before: &remainderIndex)
                    
                    if   remainderLast0 >= divisorLast0 { return UInt.max }
                    let  remainderLast1  = REMAINDER[unchecked: remainderIndex] as UInt
                    let  remainderLastX  = HL(remainderLast0,   remainderLast1)
                    return divisorLast0.dividingFullWidth(remainderLastX).quotient
                }
                //=------------------------------=
                var approximation = ExtraDigitWidth(descending: divisor.multipliedFullWidth(by: digit))
                approximation._bitshiftLeft(words: quotientIndex, bits: Int())
                //=------------------------------=
                // Subtract When Digit Is Too Big
                //=------------------------------=
                if  approximation > remainder {
                    var increment = ExtraDigitWidth(descending:(UInt(), Magnitude(bitPattern: divisor)))
                    increment._bitshiftLeft(words: quotientIndex, bits: Int())
                    
                    brrrrrrrrrrrrrrrrrrrrrrr: do { digit &-= 1; approximation &-= increment }
                    if approximation > remainder { digit &-= 1; approximation &-= increment }
                }
                //=------------------------------=
                // Quotient Digit Is Correct Here
                //=------------------------------=
                assert(approximation <= remainder)
                remainder &-= approximation as ExtraDigitWidth
                QUOTIENT[unchecked: quotientIndex] = digit as UInt
            }
        }
        //=--------------------------------------=
        // >> To Undo << From Before Main Loop
        //=--------------------------------------=
        remainder._bitshiftRight(words: Int(), bits: divisorShift)
        return QR(quotient, Self(bitPattern: remainder.low))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func dividingFullWidthAsKnuth(_ dividend: DoubleWidth) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending:(dividend.high,  dividend.low))
        let divisor  = DoubleWidth(descending:(Self(), Magnitude(bitPattern: self)))
        let qr = dividend.quotientAndRemainderAsKnuth(dividingBy: divisor) as QR<DoubleWidth, DoubleWidth>
        return QR(Self(bitPattern: qr.quotient.low), Self(bitPattern: qr.remainder.low))
    }
}
