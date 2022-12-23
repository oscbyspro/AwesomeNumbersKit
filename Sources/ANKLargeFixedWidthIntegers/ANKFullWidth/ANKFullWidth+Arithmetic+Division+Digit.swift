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
    
    @inlinable static func /=(lhs: inout Self, rhs: Digit) {
        let o = lhs.divideReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable static func /(lhs: Self, rhs: Digit) -> Self {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    @inlinable static func %=(lhs: inout Self, rhs: Digit) {
        let o = lhs.formRemainderReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable static func %(lhs: Self, rhs: Digit) -> Digit {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        let o: Bool; (self, o) = self.dividedReportingOverflow(by: divisor); return o
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool {
        let (pv, o) = self.remainderReportingOverflow(dividingBy: divisor); self = Self(digit: pv); return o
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        // TODO: decide digit division overflow semantics
        if divisor.isZero { return PVO(Digit(), true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Digit(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
    
    @inlinable mutating func divideReportingRemainder(dividingBy divisor: Digit) -> Digit {
        let (q, r) = self.quotientAndRemainder(dividingBy: divisor); self = q; return r
    }
    
    @inlinable mutating func formRemainderReportingQuotient(dividingBy divisor: Digit) -> Self {
        let (q, r) = self.quotientAndRemainder(dividingBy: divisor); self = Self(digit: r); return q
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let dividendIsLessThanZero = self.isLessThanZero
        var (q, r) = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            let o = q.formTwosComplementReportingOverflow()
            precondition(!o, "quotient overflow during division")
        }
        
        if  dividendIsLessThanZero {
            r = ~r &+ 1 // cannot overflow: abs <= max
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: q), Digit(bitPattern: r))
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Unsigned x Division x Digit
//*============================================================================*

extension ANKFullWidth where Self: AwesomeUnsignedLargeFixedWidthInteger {
 
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        precondition(!divisor.isZero)
        //=--------------------------------------=
        var quotient = self, remainder = UInt()
        //=--------------------------------------=
        quotient.withUnsafeMutableWords { QUOTIENT in
            var quotientIndex = QUOTIENT.endIndex
            //=----------------------------------=
            backwards: while quotientIndex != QUOTIENT.startIndex {
                QUOTIENT.formIndex(before: &quotientIndex)
                let dividend = (remainder, QUOTIENT[unchecked: quotientIndex]) as (UInt, UInt)
                let division = divisor.dividingFullWidth(dividend) as (UInt, UInt)
                (QUOTIENT[unchecked: quotientIndex], remainder) = division as (UInt, UInt)
            }
        }
        //=--------------------------------------=
        return QR(quotient, remainder)
    }
}
