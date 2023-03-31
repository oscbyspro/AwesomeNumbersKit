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
// MARK: * ANK x Radix UInt Root
//*============================================================================*

/// The largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
///
/// The decision between Int and UInt typing is based on interoperability.
///
/// - Its `base` is `>= 2`
/// - Its `exponent` is `>= 1` and `<= UInt.bitWidth`
/// - Its `power` is `0` when `pow(radix, exponent) == UInt.max + 1`
///
@usableFromInline struct RadixUIntRoot {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let base: Int
    @usableFromInline let exponent: Int
    @usableFromInline let power: UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ radix: Int) {
        let  root = Self._root(radix)
        self.base = radix
        self.exponent = root.exponent
        self.power = root.power
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
    @inlinable static func _root(_ radix: Int) -> (exponent: Int, power: UInt) {
        precondition(radix >= 2)
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            return self._rootWhereRadixIsAtLeast2AndRadixIsPowerOf2(radix)
        }
        //=--------------------------------------=
        return self._rootWhereRadixIsAtLeast2(radix)
    }
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
    @inlinable static func _rootWhereRadixIsAtLeast2AndRadixIsPowerOf2(_ radix: Int) -> (exponent: Int, power: UInt) {
        assert(radix >= 2)
        assert(radix.isPowerOf2)
        //=--------------------------------------=
        let zeros: Int = radix.trailingZeroBitCount
        //=--------------------------------------=
        // Radix == 2,  4, 16, 256, ...
        //=--------------------------------------=
        if  zeros.isPowerOf2 {
            let exponent = UInt.bitWidth &>> zeros.trailingZeroBitCount
            return (exponent: exponent, power: 0)
        //=--------------------------------------=
        // Radix == 8, 32, 64, 128, ...
        //=--------------------------------------=
        }   else {
            let exponent = UInt.bitWidth  /  zeros
            let shift: Int = zeros.multipliedReportingOverflow(by: exponent).partialValue
            return (exponent: exponent, power: 1 &<< UInt(bitPattern: shift))
        }
    }
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
    @inlinable static func _rootWhereRadixIsAtLeast2(_ radix: Int) -> (exponent: Int, power: UInt) {
        assert(radix >= 2)
        //=--------------------------------------=
        var exponent = 1 as Int
        var power = UInt(bitPattern: radix)
        let radix = UInt(bitPattern: radix)
        //=--------------------------------------=
        exponentiate: while true {
            let product = power.multipliedFullWidth(by: radix)
            if !product.high.isZero {
                if  product.high == 1, product.low.isZero {
                    exponent &+= 1
                    power = product.low
                }
                
                return (exponent: exponent, power: power)
            }
            
            exponent &+= 1
            power = product.low
        }
    }
}
