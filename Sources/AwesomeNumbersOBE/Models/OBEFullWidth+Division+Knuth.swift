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
        typealias PlusUInt = OBEFullWidth<UInt, Magnitude>
        let (divisorCount, divisorIsZero) = divisor.minWordsCountReportingIsZeroOrMinusOne() as (Int, Bool)
        precondition(!divisorIsZero, "division by zero")
        //=--------------------------------------=
        // Dividend <= Divisor
        //=--------------------------------------=
        if  self <= divisor {
            return (self == divisor) ? QR(1, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Division By One Word
        //=--------------------------------------=
        if  divisorCount == 1 {
            let word = divisor[unchecked: startIndex] as UInt
            let (quotient, remainder) = self.quotientAndRemainder(dividingBy: word) as (Self, UInt)
            return QR(quotient, Self(small: remainder))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var divisor = divisor
        var remainder = PlusUInt(descending:(UInt(), Magnitude(bitPattern: self)))
        let shift = divisor[unchecked: divisor.index(before: divisorCount)].leadingZeroBitCount
        let remainderCount = remainder.low.minWordsCount // shift is taken into account by loop

        divisor  ._bitrotateLeft(words: Int(), bits: shift)
        remainder._bitrotateLeft(words: Int(), bits: shift)
        
        assert(  divisorCount >= 2)
        assert(remainderCount >= 2)
        assert(remainderCount >= divisorCount)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var quotient = Self(); quotient.withUnsafeMutableWords { QUOTIENT in
            var remainderIndex = remainderCount &+ 1
            var  quotientIndex = remainderIndex &- divisorCount
            
            let divisor0 = divisor[unchecked: divisor.index(before: divisorCount)]
            backwards: while quotientIndex != QUOTIENT.startIndex {
                 QUOTIENT.formIndex(before:  &quotientIndex)
                remainder.formIndex(before: &remainderIndex)
                //=------------------------------=
                // Approximation: 2 vs 1
                //=------------------------------=
                var digit: UInt = remainder.withUnsafeWords { REMAINDER in
                    assert(divisor0.mostSignificantBit)
                    let remainder0  = REMAINDER[unchecked: remainderIndex]
                    if  remainder0 >= divisor0 { return UInt.max }
                    let remaidner1  = REMAINDER[unchecked: REMAINDER.index(before: remainderIndex)]
                    return divisor0.dividingFullWidth((remainder0, remaidner1)).quotient
                }
                
                var approximation = PlusUInt(descending: divisor.multipliedFullWidth(by: digit))
                approximation._bitrotateLeft(words: quotientIndex, bits: Int())
                
                overestimated: if approximation > remainder {
                    var increment = PlusUInt(descending:(UInt(), Magnitude(bitPattern: divisor)))
                    increment._bitrotateLeft(words: quotientIndex, bits: Int())
                    x1or2: repeat { digit &-= 1; approximation &-= increment  } while approximation > remainder
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
