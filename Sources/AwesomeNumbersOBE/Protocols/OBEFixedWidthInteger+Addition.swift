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
// MARK: * OBE x Fixed Width Integer x Addition
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Self) {
        lhs._storage += rhs._storage
    }
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs._storage + rhs._storage)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        self._storage.addReportingOverflow(amount._storage)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        let (pv, o) = self._storage.addingReportingOverflow(amount._storage); return (Self(bitPattern: pv), o)
    }
}
