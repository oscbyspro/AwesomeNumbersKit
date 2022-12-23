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
// MARK: * ANK x Full Width x Addition
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Self) {
        let o = lhs.addReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func +(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.addingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Self) {
        let _ = lhs.addReportingOverflow(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: Self) -> Self {
        let (pv, _) = lhs.addingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let a = self.low .addReportingOverflow(amount.low )
        let b = self.high.addReportingOverflow(amount.high)
        let c = a && self.high.addReportingOverflow(1 as Digit)
        return  b || c
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount); return (pv, o)
    }
}
