//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Division
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func /=(lhs: inout Self, rhs: Self) {
        let (pv, o) = lhs.dividedReportingOverflow(by: rhs); precondition(!o); lhs = pv
    }
    
    @inlinable public static func /(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs /= rhs; return lhs
    }
    
    @inlinable public static func %=(lhs: inout Self, rhs: Self) {
        let (pv, o) = lhs.remainderReportingOverflow(dividingBy: rhs); precondition(!o); lhs = pv
    }
    
    @inlinable public static func %(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs %= rhs; return lhs
    }
}
