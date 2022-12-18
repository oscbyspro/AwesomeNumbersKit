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
// MARK: * OBE x Full Width x Division
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        let o = lhs.divideReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        let o = lhs.formRemainderReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Self(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
    
    @inlinable func quotientAndRemainder(dividingBy  divisor: Self) -> QR<Self, Self> {
        self.quotientAndRemainderAsKnuth(dividingBy: divisor)
    }
    
    @inlinable func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        self.dividingFullWidthAsKnuth(dividend)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Unsigned x Division x Knuth
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        let division  = self.magnitude.quotientAndRemainderAsKnuth(dividingBy: divisor.magnitude)
        var quotient  = Self(division.quotient )
        var remainder = Self(division.remainder)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  isLessThanZero {
            // TODO: negate()
            remainder.formTwosComplement()
        }
        
        if  isLessThanZero != divisor.isLessThanZero {
            // TODO: negate()
            quotient .formTwosComplement()
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return (quotient, remainder)
    }
    
    @inlinable public func dividingFullWidthAsKnuth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let dividend = DoubleWidth(descending: dividend)
        let dividendIsLessThanZero = dividend.isLessThanZero
        var division = self.magnitude.dividingFullWidthAsKnuth(dividend.magnitude.descending)
        //=--------------------------------------=
        // Truncates On Negation Overflow
        //=--------------------------------------=
        if  dividendIsLessThanZero {
            division.remainder.formTwosComplement()
        }
        
        if  dividendIsLessThanZero != self.isLessThanZero {
            division.quotient .formTwosComplement()
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return (Self(bitPattern: division.quotient), Self(bitPattern: division.remainder))
    }
}

extension OBEFullWidth where High: UnsignedInteger {
    
    #warning("TEST")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable @inline(never) func quotientAndRemainderAsKnuth(dividingBy divisor: Self) -> QR<Self, Self> {
        typealias Extended = OBEFullWidth<UInt, Magnitude>
        let (divisorReducedCount, divisorIsZero) = divisor.minWordsCountReportingIsZeroOrMinusOne()
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
        var remainderReducedCount = self.minWordsCount
        let remainderBitAlignment =    self[unchecked:    self.index(before: remainderReducedCount)].leadingZeroBitCount
        let   divisorBitAlignment = divisor[unchecked: divisor.index(before:   divisorReducedCount)].leadingZeroBitCount
        
        var divisor   = divisor
        var remainder = Extended(descending:(UInt(), Magnitude(bitPattern: self)))
        
        divisor  ._bitrotateLeft(words: Int(), bits: divisorBitAlignment)
        remainder._bitrotateLeft(words: Int(), bits: divisorBitAlignment)
        remainder.formIndex(&remainderReducedCount, offsetBy: Int(remainderBitAlignment < divisorBitAlignment))
                
        assert(divisor[divisor.index(before: divisorReducedCount)].mostSignificantBit)
        assert(remainderReducedCount >= divisorReducedCount && divisorReducedCount >= 2)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let divisorX2: (UInt, UInt) = divisor.withUnsafeWords { DIVISOR in
            let divisor0 = DIVISOR[unchecked: DIVISOR.index(divisorReducedCount, offsetBy: -1)]
            let divisor1 = DIVISOR[unchecked: DIVISOR.index(divisorReducedCount, offsetBy: -2)]
            return (divisor0, divisor1)
        }
        
        var quotient = Self(); quotient.withUnsafeMutableWords { QUOTIENT in
            var remainderIndex = remainderReducedCount &+ 1
            var  quotientIndex = remainderReducedCount &+ 1 &- divisorReducedCount
            
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT .formIndex(before:  &quotientIndex)
                remainder.formIndex(before: &remainderIndex)
                //=------------------------------=
                //
                //=------------------------------=
                let remainderX3: (UInt, UInt, UInt) = remainder.withUnsafeWords { REMAINDER in
                    let remainder0 = REMAINDER[unchecked: REMAINDER.index(remainderIndex, offsetBy:  0)]
                    let remainder1 = REMAINDER[unchecked: REMAINDER.index(remainderIndex, offsetBy: -1)]
                    let remainder2 = REMAINDER[unchecked: REMAINDER.index(remainderIndex, offsetBy: -2)]
                    return (remainder0, remainder1, remainder2)
                }
                //=------------------------------=
                // Approximation - Quotient <= 1
                //=------------------------------=
                var quotientDigitAsUInt = UInt.approximateQuotientAsKnuth(dividing: remainderX3, by: divisorX2)
                var approximation = Extended(descending:  divisor.multipliedFullWidth(by: quotientDigitAsUInt))
                approximation._bitrotateLeft(words: quotientIndex, bits: Int())
                //=------------------------------=
                // 
                //=------------------------------=
                overestimated: if approximation > remainder {
                    quotientDigitAsUInt &-= 1 as UInt
                    var quotientDigitAsMagnitude = Magnitude(_truncatingBits: quotientDigitAsUInt)
                    quotientDigitAsMagnitude._bitrotateLeft(words: quotientIndex, bits:Int())
                    approximation &-= Extended(descending:(UInt(), quotientDigitAsMagnitude))
                }
                //=------------------------------=
                //
                //=------------------------------=
                remainder &-= approximation
                QUOTIENT[unchecked: quotientIndex] = quotientDigitAsUInt
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
// MARK: * OBE x Division x Unsigned x Small
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    #warning("TEST")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formQuotientReportingRemainder(dividingBy rhs: UInt) -> UInt {
        self.withUnsafeMutableWords { LHS in
            precondition(!rhs.isZero)
            
            var remainder = UInt()
            var lhsIndex  = LHS.endIndex
            
            backwards: while lhsIndex != LHS.startIndex {
                LHS.formIndex(before: &lhsIndex)
                (LHS[lhsIndex], remainder) = rhs.dividingFullWidth((remainder, LHS[lhsIndex]))
            }
            
            return remainder
        }
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: UInt) -> QR<Self, UInt> {
        var lhs = self; let rhs = lhs.formQuotientReportingRemainder(dividingBy: divisor); return QR(lhs, rhs)
    }
}
