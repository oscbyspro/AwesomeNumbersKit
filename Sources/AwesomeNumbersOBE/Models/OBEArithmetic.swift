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
// MARK: * OBE x Arithmetic x UInt
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self, _ carry: Bool) -> Bool {
        let a = self.addReportingOverflow(amount)
        let b = self.addReportingOverflow(carry ? 1 : 0)
        return  a || b
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self, _ carry: Bool) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, carry); return PVO(pv,o)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @inlinable mutating func subtractReportingOverflow(_ amount: Self, _ borrow: Bool) -> Bool {
        let a = self.subtractReportingOverflow(amount)
        let b = self.subtractReportingOverflow(borrow ? 1 : 0)
        return  a || b
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self, _ borrow: Bool) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, borrow); return PVO(pv,o)
    }
}

//*============================================================================*
// MARK: * OBE x Arithmetic x Unsigned
//*============================================================================*

extension FixedWidthInteger where Self: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func sum(_ x0: Self, _ x1: Self, _ x2: Self) -> HL<Self, Self> {
        let (x3, o3) = x0.addingReportingOverflow(x1)
        let (x4, o4) = x3.addingReportingOverflow(x2)
        let (x5) = o3 && o4 ? 2 : o3 || o4 ? 1 : 0 as Self
        return (x5, x4)
    }
}
