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
// MARK: * OBE x Division x Unsigned x Small
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Overflow
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formQuotientReportingOverflow(by divisor: UInt) -> Bool {
        let o: Bool; (self, o) = self.quotientReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable func quotientReportingOverflow(dividingBy divisor: UInt) -> PVO<Self> {
        if  divisor.isZero { return (self, true) } // undefined
        let quotient = self.quotientAndRemainder(dividingBy: divisor).quotient
        return (quotient, false)
    }
    
    @inlinable mutating func formRemainderReportingOverflow(dividingBy divisor: UInt) -> Bool {
        let o: Bool; (self, o) = self.remainderReportingOverflow(dividingBy: divisor); return o
    }
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: UInt) -> PVO<Self> {
        if  divisor.isZero { return (self, true) } // undefined
        let remainder = self.quotientAndRemainder(dividingBy: divisor).remainder
        return (Self(small: remainder), false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Components
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formRemainderReportingQuotient(dividingBy divisor: UInt) -> Self {
        let qr = quotientAndRemainder(dividingBy: divisor); self = Self(small: qr.remainder); return qr.quotient
    }
    
    @inlinable mutating func formQuotientReportingRemainder(dividingBy divisor: UInt) -> UInt {
        precondition(!divisor.isZero, "division by zero")
        
        var index = self.endIndex
        var remainder = UInt()
        
        self.withUnsafeMutableWords { SELF in
        while index != SELF.startIndex {
            (SELF).formIndex(before: &index)
            (SELF[index], remainder) = divisor.dividingFullWidth((remainder, SELF[index]))
        }}
        
        return remainder
    }
    
    @inlinable func quotientAndRemainder(dividingBy divisor: UInt) -> QR<Self, UInt> {
        var lhs = self; let rhs = lhs.formQuotientReportingRemainder(dividingBy: divisor); return QR(lhs, rhs)
    }
}
