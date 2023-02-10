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
// MARK: * ANK x Arithmetic
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the given value and bit to this value,
    /// and returns a value indicating whether overflow occured.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```
    /// var a: UInt = ~0; a.addReportingOverflow( 0, false) // a = ~0; -> false
    /// var b: UInt = ~0; a.addReportingOverflow( 0, true ) // b =  0; -> true
    /// var c: UInt = ~0; c.addReportingOverflow(~0, false) // c = ~1; -> true
    /// var d: UInt = ~0; d.addReportingOverflow(~0, true ) // d = ~0; -> true
    /// ```
    ///
    /// - Returns: A value truncating the range: `HL(0, 0) ... HL(1, ~0)`.
    ///
    @inlinable mutating func addReportingOverflow(_ amount: Self, _ bit: Bool) -> Bool {
        let a: Bool = self.addReportingOverflow(amount)
        let b: Bool = self.addReportingOverflow(UInt(bit: bit))
        return a || b
    }
    
    /// Returns the sum of adding the given value and bit to this value,
    /// along with a value indicating whether overflow occured.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```
    /// (~0 as UInt).addingReportingOverflow( 0, false) // (partialValue: ~0, overflow: false)
    /// (~0 as UInt).addingReportingOverflow( 0, true ) // (partialValue:  0, overflow: true )
    /// (~0 as UInt).addingReportingOverflow(~0, false) // (partialValue: ~1, overflow: true )
    /// (~0 as UInt).addingReportingOverflow(~0, true ) // (partialValue: ~0, overflow: true )
    /// ```
    ///
    /// - Returns: A value truncating the range: `HL(0, 0) ... HL(1, ~0)`.
    ///
    @inlinable func addingReportingOverflow(_ amount: Self, _ bit: Bool) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount, bit)
        return PVO(partialValue, overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the product of the multiplicands to this value.
    ///
    /// ```
    /// var a: UInt = ~0; a.addFullWidth(multiplicands:( 2,  3)) // a = 5; ->  1
    /// var b: UInt = ~0; b.addFullWidth(multiplicands:(~0, ~0)) // b = 0; -> ~0
    /// ```
    ///
    /// - Returns: A value in the range: `HL(0, 0) ... HL(~0, 0)`.
    ///
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        let hl: HL<Self, Self> = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(hl.low) ? hl.high &+ 1 : hl.high
    }
    
    /// Returns the sum of adding the product of the multiplicands to this value.
    ///
    /// ```
    /// (~0 as UInt).addingFullWidth(multiplicands:( 2,  3)) // (high:  1, low: 5)
    /// (~0 as UInt).addingFullWidth(multiplicands:(~0, ~0)) // (high: ~0, low: 0)
    /// ```
    ///
    /// - Returns: A value in the range: `HL(0, 0) ... HL(~0, 0)`.
    ///
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Magnitude> {
        var low = self
        let high: Self = low.addFullWidth(multiplicands: multiplicands)
        return HL(high,  low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the sum of adding the addend and product of the multiplicands to this value.
    ///
    /// ```
    /// var a: UInt = ~0; a.addFullWidth( 1, multiplicands:( 2,  3)) // a =  6; ->  1
    /// var b: UInt = ~0; b.addFullWidth(~0, multiplicands:(~0, ~0)) // b = ~0; -> ~0
    /// ```
    ///
    /// - Returns: A value in the range: `HL(0, 0) ... HL(~0, ~0)`.
    ///
    @inlinable mutating func addFullWidth(_ addend: Self, multiplicands: (Self, Self)) -> Self {
        let high: Self = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(addend) ? high &+ 1 : high
    }
    
    /// Returns the sum of adding the addend and product of the multiplicands to this value.
    ///
    /// ```
    /// (~0 as UInt).addingFullWidth( 1, multiplicands:( 2,  3)) // (high:  1, low:  6)
    /// (~0 as UInt).addingFullWidth(~0, multiplicands:(~0, ~0)) // (high: ~0, low: ~0)
    /// ```
    ///
    /// - Returns: A value in the range: `HL(0, 0) ... HL(~0, ~0)`.
    ///
    @inlinable func addingFullWidth(_ addend: Self, multiplicands: (Self, Self)) -> HL<Self, Magnitude> {
        var low = self
        let high: Self = low.addFullWidth(addend, multiplicands: multiplicands)
        return HL(high,  low)
    }
}
