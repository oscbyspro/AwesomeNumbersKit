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
// MARK: * OBE x Fixed Width Integer x Large x Addition
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func +=(lhs: inout Self, rhs: Self) {
        lhs.body += rhs.body
    }
    
    @inlinable public static func +(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body + rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Self) -> Bool {
        self.body.addReportingOverflow(amount.body)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Self) -> PVO<Self> {
        let (pv, o) = self.body.addingReportingOverflow(amount.body); return (Self(bitPattern: pv), o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Signed x Addition
//*============================================================================*

extension OBESignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: Int, at index: Int) -> Bool {
        self.body.addReportingOverflow(amount, at: index)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: Int, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Unsigned x Addition
//*============================================================================*

extension OBEUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func addReportingOverflow(_ amount: UInt, at index: Int) -> Bool {
        self.body.addReportingOverflow(amount, at: index)
    }
    
    @inlinable public func addingReportingOverflow(_ amount: UInt, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, at: index); return (pv, o)
    }
}
