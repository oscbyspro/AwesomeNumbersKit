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
// MARK: * ANK x Arithmetic x UInt
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self, _ carry: Bool) -> Bool {
        let a = self.addReportingOverflow(amount)
        let b = self.addReportingOverflow(UInt(carry))
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
        let b = self.subtractReportingOverflow(UInt(borrow))
        return  a || b
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self, _ borrow: Bool) -> PVO<Self> {
        var pv = self; let o = pv.subtractReportingOverflow(amount, borrow); return PVO(pv,o)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        // it cannot crash for the same reason that 9 + 9 * 9 == 90
        let (upper, lower) = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(lower) ? upper &+ 1 : upper
    }
    
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(multiplicands: multiplicands); return (high, low)
    }
    
    @inlinable mutating func addFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> Self {
        // it cannot crash for the same reason that 9 + 9 + 9 * 9 == 99
        let upper = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(carry) ? upper &+ 1 : upper
    }
    
    @inlinable func addingFullWidth(_ carry: Self,  multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(carry, multiplicands: multiplicands); return (high, low)
    }
}
