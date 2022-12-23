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
// MARK: * ANK x Full Width x Subtraction
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Self) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.subtractingReportingOverflow(rhs); precondition(!o); return pv
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Self) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Self) -> Self {
        let (pv, _) = lhs.subtractingReportingOverflow(rhs); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let a = self.low .subtractReportingOverflow(amount.low )
        let b = self.high.subtractReportingOverflow(amount.high)
        let c = a && self.high.subtractReportingOverflow(1 as Digit)
        return  b || c
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount); return (pv, o)
    }
}
