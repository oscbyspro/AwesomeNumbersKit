//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Arithmetic x UInt
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding both values to this value, and returns an overflow indicator.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: UInt = ~0; a.addReportingOverflow( 0, false) // a = ~0; -> false
    /// var b: UInt = ~0; a.addReportingOverflow( 0, true ) // b =  0; -> true
    /// var c: UInt = ~0; c.addReportingOverflow(~0, false) // c = ~1; -> true
    /// var d: UInt = ~0; d.addReportingOverflow(~0, true ) // d = ~0; -> true
    /// ```
    ///
    /// - Returns: A truncated value in the range: `(high: 0, low: 0) ... (high: 1, low: ~0)`.
    ///
    @inlinable mutating func addReportingOverflow(_ other: Self, _ bit: Bool) -> Bool {
        let a: Bool = self.addReportingOverflow(other)
        let b: Bool = self.addReportingOverflow(Self(bit: bit))
        return a || b
    }
    
    /// Returns the sum of adding both values to this value, along with an overflow indicator.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// (~0 as UInt).addingReportingOverflow( 0, false) // (partialValue: ~0, overflow: false)
    /// (~0 as UInt).addingReportingOverflow( 0, true ) // (partialValue:  0, overflow: true )
    /// (~0 as UInt).addingReportingOverflow(~0, false) // (partialValue: ~1, overflow: true )
    /// (~0 as UInt).addingReportingOverflow(~0, true ) // (partialValue: ~0, overflow: true )
    /// ```
    ///
    /// - Returns: A truncated value in the range: `(high: 0, low: 0) ... (high: 1, low: ~0)`.
    ///
    @inlinable func addingReportingOverflow(_ other: Self, _ bit: Bool) -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(other, bit)
        return PVO(partialValue, overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the product of the multiplicands to this value.
    ///
    /// ```swift
    /// var a: UInt = ~0; a.addFullWidth(multiplicands:( 2,  3)) // a = 5; ->  1
    /// var b: UInt = ~0; b.addFullWidth(multiplicands:(~0, ~0)) // b = 0; -> ~0
    /// ```
    ///
    /// - Returns: A value in the range: `(high: 0, low: 0) ... (high: ~0, low: 0)`.
    ///
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        let product = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return Self(bit: self.addReportingOverflow(product.low)) &+ product.high
    }
    
    /// Returns the sum of adding the product of the multiplicands to this value.
    ///
    /// ```swift
    /// (~0 as UInt).addingFullWidth(multiplicands:( 2,  3)) // (high:  1, low: 5)
    /// (~0 as UInt).addingFullWidth(multiplicands:(~0, ~0)) // (high: ~0, low: 0)
    /// ```
    ///
    /// - Returns: A value in the range: `(high: 0, low: 0) ... (high: ~0, low: 0)`.
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
    /// ```swift
    /// var a: UInt = ~0; a.addFullWidth( 1, multiplicands:( 2,  3)) // a =  6; ->  1
    /// var b: UInt = ~0; b.addFullWidth(~0, multiplicands:(~0, ~0)) // b = ~0; -> ~0
    /// ```
    ///
    /// - Returns: A value in the range: `(high: 0, low: 0) ... (high: ~0, low: ~0)`.
    ///
    @inlinable mutating func addFullWidth(_ addend: Self, multiplicands: (Self, Self)) -> Self {
        let high: Self = self.addFullWidth(multiplicands: multiplicands)
        return Self(bit: self.addReportingOverflow(addend)) &+ high
    }
    
    /// Returns the sum of adding the addend and product of the multiplicands to this value.
    ///
    /// ```swift
    /// (~0 as UInt).addingFullWidth( 1, multiplicands:( 2,  3)) // (high:  1, low:  6)
    /// (~0 as UInt).addingFullWidth(~0, multiplicands:(~0, ~0)) // (high: ~0, low: ~0)
    /// ```
    ///
    /// - Returns: A value in the range: `(high: 0, low: 0) ... (high: ~0, low: ~0)`.
    ///
    @inlinable func addingFullWidth(_ addend: Self, multiplicands: (Self, Self)) -> HL<Self, Magnitude> {
        var low = self
        let high: Self = low.addFullWidth(addend, multiplicands: multiplicands)
        return HL(high,  low)
    }
}

//*============================================================================*
// MARK: * ANK x Arithmetic x Modulo
//*============================================================================*

extension BinaryInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns `self` modulo `self.bitWidth`.
    @inlinable func moduloBitWidth() -> Int where Self: ANKFixedWidthInteger, Self.Digit: ANKCoreInteger<UInt> {
        self.moduloBitWidth(of: Self.self)
    }
    
    /// Returns `self` modulo `other.bitWidth`.
    @inlinable func moduloBitWidth<T>(of other: T.Type) -> Int where T: ANKFixedWidthInteger, T.Digit: ANKCoreInteger<UInt> {
        //=--------------------------------------=
        if  T.bitWidth.isPowerOf2 {
            return Int(bitPattern: self._lowWord) & (T.bitWidth &- 1)
        //=--------------------------------------=
        }   else if T.bitWidth >= self.bitWidth {
            let minus: Bool = self < (0 as Self)
            let divisor   = T.Magnitude.Digit(bitPattern: T.bitWidth)
            let magnitude = T.Magnitude(truncatingIfNeeded: self.magnitude)
            let remainder = Int(bitPattern: magnitude % divisor)
            return Int(bitPattern: minus ? T.bitWidth - remainder : remainder)
        //=--------------------------------------=
        }   else {
            let minus: Bool = self < (0 as Self)
            let divisor   = Magnitude(truncatingIfNeeded: T.bitWidth)
            let magnitude = Magnitude(truncatingIfNeeded: self.magnitude)
            let remainder = Int(bitPattern: (magnitude % divisor)._lowWord)
            return Int(bitPattern: minus ? T.bitWidth - remainder : remainder)
        }
    }
}
