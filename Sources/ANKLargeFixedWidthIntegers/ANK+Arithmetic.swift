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
        let b = self.addReportingOverflow(UInt(bit: carry))
        return  a || b
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self, _ carry: Bool) -> PVO<Self> {
        var pv = self; let o = pv.addReportingOverflow(amount, carry); return PVO(pv,o)
    }
    
    /// - it cannot crash for the same reason that `9 + 9 * 9 == 90`
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        let hl = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(hl.low) ? hl.high &+ 1 : hl.high
    }
    
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(multiplicands: multiplicands); return (high, low)
    }
    
    /// - it cannot crash for the same reason that `9 + 9 + 9 * 9 == 99`
    @inlinable mutating func addFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> Self {
        let high = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(carry) ? high &+ 1 : high
    }
    
    @inlinable func addingFullWidth(_ carry: Self,  multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self; let high = low.addFullWidth(carry, multiplicands: multiplicands); return (high, low)
    }
}
