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
