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
// MARK: * ANK x UInt x Radix
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= max + 1`.
    @inlinable static func radixRootReportingImperfectPowerOrZero(_ radix: Int) -> (exponent: Int, power: Self) {
        precondition(radix >= 2)
        //=--------------------------------------=
        // Fast Path
        //=--------------------------------------=
        if  radix.isPowerOf2 {
            let rtzbc = radix.trailingZeroBitCount
            //=----------------------------------=
            // Radix == 2, 4, 16, 256, ...
            //=----------------------------------=
            if  rtzbc.isPowerOf2 {
                let exponent = Self.bitWidth &>> rtzbc.trailingZeroBitCount
                return (exponent: exponent, power: 0)
            //=----------------------------------=
            // Radix == 8, 32, 64, 128, ...
            //=----------------------------------=
            }   else {
                let exponent = Self.bitWidth / rtzbc
                return (exponent: exponent, power: 1 &<< (rtzbc * exponent))
            }
        }
        //=--------------------------------------=
        // Slow Path
        //=--------------------------------------=
        var exponent = Int(1)
        var power = Self(bitPattern: radix)
        let radix = Self(bitPattern: radix)
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
