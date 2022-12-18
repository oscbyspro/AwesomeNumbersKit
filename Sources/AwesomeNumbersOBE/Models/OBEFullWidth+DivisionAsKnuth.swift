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
        let division  = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        var quotient  = Self(division.quotient )
        var remainder = Self(division.remainder)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            precondition(!remainder.formTwosComplementReportingOverflow())
        }
        
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            precondition(!quotient .formTwosComplementReportingOverflow())
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return QR(quotient, remainder)
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
    
    @inlinable @inline(never) func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        typealias Large = OBEFullWidth<UInt, Magnitude>
        let (divisorReducedCount, divisorIsZero): (Int, Bool) = divisor.minWordsCountReportingIsZeroOrMinusOne()
        precondition(!divisorIsZero, "division by zero")
        //=--------------------------------------=
        // LHS <= RHS
        //=--------------------------------------=
        if  self <= divisor {
            return (self == divisor) ? QR(1 as Self, Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Fast x UInt
        //=--------------------------------------=
        if  divisorReducedCount == 1 {
            let (quotient, remainder): (Self, UInt) = self.quotientAndRemainder(dividingBy: divisor[unchecked: startIndex])
            return QR(quotient, Self(small: remainder))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        var divisor   = divisor
        var remainder = Large(descending:(UInt(), Magnitude(bitPattern: self)))
        
        var remainderReducedCount = remainder.low.minWordsCount
        let remainderBitAlignment = remainder[unchecked: remainder.index(before: remainderReducedCount)].leadingZeroBitCount
        let   divisorBitAlignment =   divisor[unchecked:   divisor.index(before:   divisorReducedCount)].leadingZeroBitCount
        
        divisor  ._bitrotateLeft(words: Int(), bits: divisorBitAlignment)
        remainder._bitrotateLeft(words: Int(), bits: divisorBitAlignment)
        remainder.formIndex(&remainderReducedCount, offsetBy: Int(remainderBitAlignment < divisorBitAlignment))
                
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
                    let remainderIndexIsEndIndex = remainderIndex == REMAINDER.endIndex
                    let remainder0 = remainderIndexIsEndIndex ? 0 : REMAINDER[unchecked: remainderIndex]
                    let remainder1 = REMAINDER[unchecked: REMAINDER.index(remainderIndex, offsetBy: -1)]
                    return (remainder0, remainder1)
                }
                //=------------------------------=
                // Approximation
                //=------------------------------=
                var digit = UInt.approximateQuotient(dividing: remainderLast2, by: divisorLast1)
                var approximation = Large(descending: divisor.multipliedFullWidth(by: digit))
                approximation._bitrotateLeft(words: quotientIndex, bits: Int())
                //=------------------------------=
                // Overestimation < Divisor * 2
                //=------------------------------=
                overestimated: if approximation > remainder {
                    var increment = Large(descending:(UInt(), Magnitude(bitPattern: divisor)))
                    increment._bitrotateLeft(words: quotientIndex, bits: Int())
                    //=--------------------------=
                    //
                    //=--------------------------=
                    digit &-= 1 as UInt
                    approximation &-= increment
                    //=--------------------------=
                    //
                    //=--------------------------=
                    if  approximation > remainder {
                        digit &-= 1 as UInt
                        approximation &-= increment
                    }
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
        remainder._bitrotateRight(words: Int(), bits: divisorBitAlignment)
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

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// - The quotient is overestimated by at most `2 * divisor`.
    @inlinable static func approximateQuotient(dividing dividend: (Self, Self), by divisor: Self) -> Self {
        assert(divisor.mostSignificantBit)
        if  dividend.0 >= divisor { return max }
        let division = divisor.dividingFullWidth((dividend.0, dividend.1))
        return division.quotient
    }
}
