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
// MARK: * Full Width x Integer x Addition
//*============================================================================*

// TODO: does not actually require integers
extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Self) {
        let o = lhs.addReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable static func +(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs += rhs; return lhs
    }
    
    @inlinable static func &+=(lhs: inout Self, rhs: Self) {
        let _ = lhs.addReportingOverflow(rhs)
    }
    
    @inlinable static func &+(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &+= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let o0 = self.low .addReportingOverflow(amount.low )
        let o1 = self.high.addReportingOverflow(amount.high)
        let o2 = self.high.addReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o1 || o2
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        // the code is duplicated because it's faster this way...
        var pv = self
        let o0 = pv.low .addReportingOverflow(amount.low )
        let o1 = pv.high.addReportingOverflow(amount.high)
        let o2 = pv.high.addReportingOverflow(o0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return  (pv, o1 || o2)
    }
}
