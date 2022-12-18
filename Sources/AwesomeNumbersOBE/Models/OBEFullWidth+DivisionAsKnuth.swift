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
    
    #warning("negate vs formTwosComplement")
    @inlinable func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let dividendIsLessThanZero = self.isLessThanZero
        let division  = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        var quotient  = Self(division.quotient )
        var remainder = Self(division.remainder)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            // TODO: negate()
            remainder.formTwosComplement()
        }
        
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            // TODO: negate()
            quotient .formTwosComplement()
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
            return (self == divisor) ? QR(Self(_truncatingBits: 1 as UInt), Self()) : QR(Self(), self)
        }
        //=--------------------------------------=
        // Fast x UInt
        //=--------------------------------------=
        if  divisorReducedCount == 1 {
            let (quotient, remainder): (Self, UInt) = self.quotientAndRemainder(dividingBy: divisor[unchecked: startIndex])
            return QR(quotient, Self(_truncatingBits: remainder))
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
            let divisorMainDigits = divisor[unchecked: divisor.index(before: divisorReducedCount)]
            
            backwards: while quotientIndex != QUOTIENT.startIndex {
                remainderIndex &-= 1
                 quotientIndex &-= 1
                //=------------------------------=
                // The Reminder Changes Each Loop
                //=------------------------------=
                let remainderMainDigits: (UInt, UInt) = remainder.withUnsafeWords { REMAINDER in
                    let remainder0 = remainderIndex < REMAINDER.endIndex ? REMAINDER[remainderIndex] : 0
                    let remainder1 = REMAINDER[unchecked: REMAINDER.index(remainderIndex, offsetBy: -1)]
                    return (remainder0, remainder1)
                }
                //=------------------------------=
                // Approximation - Quotient <= 2
                //=------------------------------=
                var digit = UInt.approximateQuotient(dividing: remainderMainDigits, by: divisorMainDigits)
                var approximation = Large(descending: divisor.multipliedFullWidth(by: digit))
                approximation._bitrotateLeft(words: quotientIndex, bits: Int())
                //=------------------------------=
                //
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
                    //=--------------------------=
                    //
                    //=--------------------------=
                    assert(approximation <= remainder)
                }
                //=------------------------------=
                //
                //=------------------------------=
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
    
    /// - The quotient is overestimated by at most 2.
    /// - The divisor's most significant bit must be set to clamp the approximation range.
    @inlinable static func approximateQuotient(dividing x: (Self, Self), by y: Self) -> Self {
        assert(y.mostSignificantBit); return x.0 >= y ? max : y.dividingFullWidth((x.0, x.1)).quotient
    }
}
