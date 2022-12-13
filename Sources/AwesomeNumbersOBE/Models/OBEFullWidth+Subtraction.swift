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
// MARK: * Full Width x Integer x Subtraction
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Self) {
        let o = lhs.subtractReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func -(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs -= rhs; return lhs
    }
    
    @inlinable static func &-=(lhs: inout Self, rhs: Self) {
        let _ = lhs.subtractReportingOverflow(rhs)
    }
    
    @inlinable static func &-(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &-= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        let o0 = self.low .subtractReportingOverflow(amount.low )
        let o1 = self.high.subtractReportingOverflow(amount.high)
        let o2 = self.high.subtractReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o1 || o2
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        // the code is duplicated because it's faster this way...
        var pv = self
        let o0 = pv.low .subtractReportingOverflow(amount.low )
        let o1 = pv.high.subtractReportingOverflow(amount.high)
        let o2 = pv.high.subtractReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return  (pv, o1 || o2)
    }
    
    #warning("TODO: large x small")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
}
