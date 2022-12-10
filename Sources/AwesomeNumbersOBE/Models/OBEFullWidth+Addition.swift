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
// MARK: * Full Width x Addition
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Self) {
        let o = lhs.addReportingOverflow(rhs); precondition(!o)
    }
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs += rhs; return lhs
    }
    
    @inlinable public static func &+=(lhs: inout Self, rhs: Self) {
        let _ = lhs.addReportingOverflow(rhs)
    }
    
    @inlinable public static func &+(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &+= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        let o: (Bool, Bool, Bool)
        o.0 = self.low .addReportingOverflow(amount.low )
        o.1 = self.high.addReportingOverflow(amount.high)
        o.2 = self.high.addReportingOverflow(o.0 ? 1 : 0 as High) // TODO: as Small or Pointer
        return o.1 || o.2
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount); return (pv, o)
    }
}
