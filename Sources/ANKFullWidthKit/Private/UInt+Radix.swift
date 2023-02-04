//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

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
            let radixTrailingZeroBitCount = radix.trailingZeroBitCount
            if  radixTrailingZeroBitCount.isPowerOf2 {
                let exponent = Self.bitWidth &>> radixTrailingZeroBitCount.trailingZeroBitCount
                return (exponent: exponent, power: 0)
            }   else {
                let exponent = Self.bitWidth  /  radixTrailingZeroBitCount
                return (exponent: exponent, power: 1 &<< (radixTrailingZeroBitCount * exponent))
            }
        }
        //=--------------------------------------=
        // Slow Path
        //=--------------------------------------=
        var power = Self(1)
        let radix = Self(bitPattern: radix)
        var exponent = Int()
        //=--------------------------------------=
        exponentiate: while true {
            let product = power.multipliedFullWidth(by: radix)
            if !product.high.isZero {
                //=------------------------------=
                if  product.high == (1 as Self), product.low.isZero {
                    exponent &+= 1
                    power = product.low
                }
                //=------------------------------=
                return (exponent: exponent, power: power)
            }
            
            exponent &+= 1
            power = product.low
        }
    }
}
