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
        let a: Bool = self.addReportingOverflow(amount)
        let b: Bool = self.addReportingOverflow(UInt(bit: carry))
        return a || b
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self, _ carry: Bool) -> PVO<Self> {
        var partialValue: Self = self;
        let overflow: Bool = partialValue.addReportingOverflow(amount, carry)
        return PVO<Self>(partialValue, overflow)
    }
    
    /// - it cannot crash for the same reason that `9 + 9 * 9 == 90`
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        let hl = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(hl.low) ? hl.high &+ 1 : hl.high
    }
    
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low:  Self = self
        let high: Self = low.addFullWidth(multiplicands: multiplicands)
        return HL<Self, Self>(high, low)
    }
    
    /// - it cannot crash for the same reason that `9 + 9 + 9 * 9 == 99`
    @inlinable mutating func addFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> Self {
        let high = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(carry) ? high &+ 1 : high
    }
    
    @inlinable func addingFullWidth(_ carry: Self,  multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low:  Self = self
        let high: Self = low.addFullWidth(carry, multiplicands: multiplicands)
        return HL<Self, Self>(high,  low)
    }
}
