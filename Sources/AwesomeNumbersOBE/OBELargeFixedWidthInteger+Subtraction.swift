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
// MARK: * OBE x Fixed Width Integer x Large x Subtraction
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func -=(lhs: inout Self, rhs: Self) {
        lhs.body -= rhs.body
    }
    
    @inlinable public static func -(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body - rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Self) -> Bool {
        self.body.subtractReportingOverflow(amount.body)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Self) -> PVO<Self> {
        let (pv, o) = self.body.subtractingReportingOverflow(amount.body); return (Self(bitPattern: pv), o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Signed x Subtraction
//*============================================================================*

extension OBESignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: Int, at index: Int) -> Bool {
        self.body.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: Int, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Unsigned x Subtraction
//*============================================================================*

extension OBEUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func subtractReportingOverflow(_ amount: UInt, at index: Int) -> Bool {
        self.body.subtractReportingOverflow(amount, at: index)
    }
    
    @inlinable public func subtractingReportingOverflow(_ amount: UInt, at index: Int) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, at: index); return (pv, o)
    }
}
