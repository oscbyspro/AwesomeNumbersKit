//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Full Width x Division x Knuth
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let dividendIsLessThanZero = self.isLessThanZero
        var division = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            precondition(!division.remainder.formTwosComplementReportingOverflow())
        }
        
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            precondition(!division.quotient .formTwosComplementReportingOverflow())
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return QR(Self(bitPattern: division.quotient), Self(bitPattern: division.remainder))
    }
    
    @inlinable func dividingFullWidthAsKnuth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let divisorIsLessThanZero = self.isLessThanZero
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero = dividend.isLessThanZero
        var division = self.magnitude.dividingFullWidthAsKnuth(dividend.magnitude.descending)
        //=--------------------------------------=
        // Truncates Negation Overflow
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            division.remainder.formTwosComplement()
        }
        
        if  dividendIsLessThanZero != divisorIsLessThanZero {
            division.quotient .formTwosComplement()
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return QR(Self(bitPattern: division.quotient), Self(bitPattern: division.remainder))
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Unsigned x Division x Knuth
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the quotient and remainder of dividing the dividend by the divisor.
    ///
    /// It is basically long division but with larger digits than those in base 10.
    ///
    @inlinable @inline(never) func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let (divisorReducedCount, divisorIsZero): (Int, Bool) = divisor.minWordsCountReportingIsZeroOrMinusOne()
        precondition(!divisorIsZero, "division by zero")
        //=--------------------------------------=
        // Dividend <= Divisor
        //=--------------------------------------=
        if  self <= divisor {
            return (self == divisor) ? QR(1 as Self, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Division By One Word
        //=--------------------------------------=
        if  divisorReducedCount == 1 {
            let word = divisor[unchecked: startIndex] as UInt
            let (quotient, remainder) = self.quotientAndRemainder(dividingBy: word) as (Self, UInt)
            return QR(quotient, Self(small: remainder))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var divisor = divisor
        var remainder = OBEFullWidth<UInt, Magnitude>(descending:(UInt(), Magnitude(bitPattern: self)))
        let shift = divisor[unchecked: divisor.index(before: divisorReducedCount)].leadingZeroBitCount
        let remainderReducedCount = remainder.low.minWordsCount // shift is taken into account by loop

        divisor  ._bitrotateLeft(words: Int(), bits: shift)
        remainder._bitrotateLeft(words: Int(), bits: shift)
        
        assert(divisor[divisor.index(before:   divisorReducedCount)].mostSignificantBit)
        assert(remainderReducedCount >= divisorReducedCount && divisorReducedCount >= 2)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var quotient = Self(); quotient.withUnsafeMutableWords { QUOTIENT in
            var remainderIndex = remainderReducedCount &+ 1
            var  quotientIndex = remainderIndex &- divisorReducedCount
            
            let divisorLast1 = divisor[unchecked: divisor.index(before: divisorReducedCount)]
            backwards: while quotientIndex != QUOTIENT.startIndex {
                 quotientIndex &-= 1
                remainderIndex &-= 1
                //=------------------------------=
                // The Reminder Changes Each Loop
                //=------------------------------=
                let remainderLast2: (UInt, UInt) = remainder.withUnsafeWords { REMAINDER in
                    let remainder0 = REMAINDER[unchecked: remainderIndex]
                    let remainder1 = REMAINDER[unchecked: REMAINDER.index(before: remainderIndex)]
                    return (remainder0, remainder1)
                }
                //=------------------------------=
                // Approximation
                //=------------------------------=
                var digit = OBEFullWidthKnuthDivision.approximateQuotient(dividing: remainderLast2, by: divisorLast1)
                var approximation = OBEFullWidth<UInt, Magnitude>(descending: divisor.multipliedFullWidth(by: digit))
                approximation._bitrotateLeft(words: quotientIndex, bits: Int())
                //=------------------------------=
                //
                //=------------------------------=
                overestimated: if approximation > remainder {
                    var stride = OBEFullWidth<UInt, Magnitude>(descending:(UInt(), Magnitude(bitPattern: divisor)))
                    stride._bitrotateLeft(words:  quotientIndex, bits: Int())
                    do1or2: repeat { digit &-= 1 as UInt; approximation &-= stride } while approximation > remainder
                }
                //=------------------------------=
                //
                //=------------------------------=
                assert(approximation <= remainder)
                remainder &-= approximation
                QUOTIENT[unchecked: quotientIndex] = digit
            }
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        remainder._bitrotateRight(words: Int(), bits: shift)
        return QR(quotient, Self(bitPattern: remainder.low))
    }
    
    @inlinable func dividingFullWidthAsKnuth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending:(dividend.high,  dividend.low))
        let divisor  = DoubleWidth(descending:(Self(), Magnitude(bitPattern: self)))
        let division = dividend.quotientAndRemainderAsKnuth(dividingBy: divisor)
        return QR(Self(bitPattern: division.quotient.low), Self(bitPattern: division.remainder.low))
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Division x Knuth x Auxiliaries
//*============================================================================*

@usableFromInline enum OBEFullWidthKnuthDivision {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// - The quotient is overestimated by at most `2 * divisor`.
    @inlinable static func approximateQuotient(dividing dividend: (UInt, UInt), by divisor: UInt) -> UInt {
        assert(divisor.mostSignificantBit)
        if dividend.0 >= divisor { return UInt.max }
        return divisor.dividingFullWidth((dividend.0, dividend.1)).quotient
    }
}
