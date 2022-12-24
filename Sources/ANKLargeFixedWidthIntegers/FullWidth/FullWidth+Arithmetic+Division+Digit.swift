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
        precondition(!lhs.divideReportingOverflow(by: rhs))
    }
    
    @inlinable static func /(lhs: Self, rhs: Digit) -> Self {
        let pvo = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    @inlinable static func %=(lhs: inout Self, rhs: Digit) {
         precondition(!lhs.formRemainderReportingOverflow(by: rhs))
    }
    
    @inlinable static func %(lhs: Self, rhs: Digit) -> Digit {
        let pvo = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        let pvo = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        if divisor.isZero { return PVO(self, true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(self, true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool {
        let pvo = self.remainderReportingOverflow(dividingBy: divisor)
        self = Self(digit: pvo.partialValue); return pvo.overflow
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        // TODO: decide digit division overflow semantics
        if divisor.isZero { return PVO(Digit(), true) }
        if Self.isSigned && divisor == -1 && self == Self.min { return PVO(Digit(), true) }
        return PVO(self.quotientAndRemainder(dividingBy: divisor).remainder, false)
    }
    
    @inlinable mutating func divideReportingRemainder(dividingBy divisor: Digit) -> Digit {
        let qr = self.quotientAndRemainder(dividingBy: divisor)
        self = qr.quotient; return qr.remainder
    }
    
    @inlinable mutating func formRemainderReportingQuotient(dividingBy divisor: Digit) -> Self {
        let qr = self.quotientAndRemainder(dividingBy: divisor)
        self = Self(digit: qr.remainder); return qr.quotient
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let dividendIsLessThanZero = self.isLessThanZero
        var qr = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        //=--------------------------------------=
        if  dividendIsLessThanZero != divisor.isLessThanZero {
            let overflow = qr.quotient.formTwosComplementReportingOverflow()
            precondition(!overflow, "quotient overflow during division")
        }
        
        if  dividendIsLessThanZero {
            qr.remainder = ~qr.remainder &+ 1 // cannot overflow: abs <= max
        }
        //=--------------------------------------=
        return QR(Self(bitPattern: qr.quotient), Digit(bitPattern: qr.remainder))
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
