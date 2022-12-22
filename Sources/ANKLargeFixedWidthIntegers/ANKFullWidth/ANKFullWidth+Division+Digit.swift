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
// MARK: * ANK x Full Width x Division x Digit
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func /=(lhs: inout Self, rhs: Self.Digit) {
        let o = lhs.divideReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable static func /(lhs: Self, rhs: Self.Digit) -> Self {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    @inlinable static func %=(lhs: inout Self, rhs: Self.Digit) {
        let o = lhs.formRemainderReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable static func %(lhs: Self, rhs: Self.Digit) -> Self.Digit {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Self.Digit) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Self.Digit) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Self.Digit) -> Bool {
        let pvo = self.remainderReportingOverflow(dividingBy: divisor)
        self = Self(digit: pvo.partialValue); return pvo.overflow
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self.Digit) -> PVO<Self.Digit> {
        if divisor.isZero { return PVO(Self.Digit(), true) } // TODO: decide overflow semantics
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Self.Digit(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
    
    @inlinable mutating func divideReportingRemainder(dividingBy divisor: Self.Digit) -> Self.Digit {
        let qr = self.quotientAndRemainder(dividingBy: divisor); self = qr.quotient; return qr.remainder
    }
    
    @inlinable mutating func formRemainderReportingQuotient(dividingBy divisor: Self.Digit) -> Self {
        let qr = self.quotientAndRemainder(dividingBy: divisor); self = Self(digit: qr.remainder); return qr.quotient
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Self.Digit) -> QR<Self, Self.Digit> {
        let dividendIsLessThanZero = self.isLessThanZero
        var division = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            let overflow = division.quotient .formTwosComplementReportingOverflow()
            precondition(!overflow, "the quotient overflowed during division")
        }
        
        if  dividendIsLessThanZero {
            division.remainder = ~division.remainder &+ 1 // cannot overflow: abs <= max
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: division.quotient), Self.Digit(bitPattern: division.remainder))
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Unsigned x Division x Digit
//*============================================================================*

extension ANKFullWidth where Self: AwesomeUnsignedLargeFixedWidthInteger {
 
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Self.Digit) -> QR<Self, Self.Digit> {
        precondition(!divisor.isZero)
        //=--------------------------------------=
        var quotient  = self
        var remainder = UInt()
        //=--------------------------------------=
        quotient.withUnsafeMutableWords { QUOTIENT in
            var quotientIndex = QUOTIENT.endIndex
            
            while quotientIndex != QUOTIENT.startIndex {
                (QUOTIENT).formIndex(before: &quotientIndex)
                let dividend = (remainder, QUOTIENT[unchecked: quotientIndex]) as (UInt, UInt)
                let division = divisor.dividingFullWidth(dividend) as (UInt, UInt)
                (QUOTIENT[unchecked: quotientIndex], remainder) = division as (UInt, UInt)
            }
        }
        //=--------------------------------------=
        return QR(quotient, remainder)
    }
}
