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
// MARK: * OBE x Fixed Width Integer x Subtraction
//*============================================================================*

extension OBEFixedWidthInteger {
    
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
// MARK: * OBE x Fixed Width Integer x Subtraction x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func -(x: Self) -> Self {
        let (pv, o) = x.negatedReportingOverflow(); precondition(!o); return pv
    }
}
