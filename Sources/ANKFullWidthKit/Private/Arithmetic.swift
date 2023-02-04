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
        var partialValue = self
        let overflow: Bool = partialValue.addReportingOverflow(amount, carry)
        return PVO(partialValue, overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addFullWidth(multiplicands: (Self, Self)) -> Self {
        let hl: HL<Self, Self> = multiplicands.0.multipliedFullWidth(by: multiplicands.1)
        return self.addReportingOverflow(hl.low) ? hl.high &+ 1 : hl.high
    }
    
    @inlinable func addingFullWidth(multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self
        let high: Self = low.addFullWidth(multiplicands: multiplicands)
        return HL(high,  low)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> Self {
        let high: Self = self.addFullWidth(multiplicands: multiplicands)
        return self.addReportingOverflow(carry) ? high &+ 1 : high
    }
    
    @inlinable func addingFullWidth(_ carry: Self, multiplicands: (Self, Self)) -> HL<Self, Self> {
        var low = self
        let high: Self = low.addFullWidth(carry, multiplicands: multiplicands)
        return HL(high,  low)
    }
}

//*============================================================================*
// MARK: * ANK x Arithmetic x UInt
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= max + 1`.
    ///
    /// - Note: The expression `max + 1` is also equivalent to `pow(2, bitWidth)`.
    ///
    @inlinable static func maxPlusOneRootReportingUnderestimatedPowerOrZero(_ radix: Int) -> (exponent: Int, power: Self) {
        precondition(radix >= 2)
        //=--------------------------------------=
        var power = Self(1)
        let radix = Self(radix)
        var exponent = Int()
        //=--------------------------------------=
        while true {
            //=----------------------------------=
            let product = power.multipliedFullWidth(by: radix)
            if !product.high.isZero {
                //=------------------------------=
                if  product.low.isZero, product.high == (1 as Self) {
                    exponent &+= 1
                    power = product.low
                }
                //=------------------------------=
                assert(power.isZero == (radix.isPowerOf2 && Self.bitWidth.isMultiple(of: radix.trailingZeroBitCount)))
                return(exponent: exponent, power: power)
            }
            //=----------------------------------=
            exponent &+= 1
            power = product.low
        }
    }
}
