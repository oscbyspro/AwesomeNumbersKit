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
/// - Its `base` is `>= 2` and `<= 36`
/// - Its `exponent` is `>= 1` and `<= UInt.bitWidth`
/// - Its `power` is `0` when `pow(radix, exponent) == UInt.max + 1`
///
@frozen @usableFromInline struct RadixUIntRoot {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let base: UInt
    @usableFromInline let exponent: UInt
    @usableFromInline let power: UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var baseInt: Int {
        assert(base <= 36)
        return Int(bitPattern: base)
    }
    
    @inlinable var exponentInt: Int {
        assert(exponent <= UInt.bitWidth)
        return Int(bitPattern:  exponent)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given radix.
    ///
    /// The radix must not exceed `36`, because that is the size of the alphabet.
    ///
    /// - Parameter radix: A value from `2` through `36`.
    ///
    @inlinable init(_ radix: Int) {
        Swift.precondition(2 ... 36 ~= radix)
        (self.base) = UInt(bitPattern: radix)
        (self.exponent, self.power)  = radix.isPowerOf2 ? Perfect._root(self.base) : Self._root(self.base)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func asPerfect<T>(_ asPerfect: (Perfect) throws -> T, asImperfect: (Imperfect) throws -> T) rethrows -> T {
        try self.power.isZero ? asPerfect(.init(unchecked: self)) :  asImperfect(.init(unchecked: self))
    }
}

//*============================================================================*
// MARK: * ANK x Radix UInt Root x Perfect
//*============================================================================*

extension RadixUIntRoot {
    
    //*========================================================================*
    // MARK: * Perfect
    //*========================================================================*
    
    /// A ``RadixUIntRoot`` with a power that is zero.
    @dynamicMemberLookup @frozen @usableFromInline struct Perfect {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let root: RadixUIntRoot
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(unchecked: RadixUIntRoot) {
            assert(unchecked.power.isZero)
            assert([2, 4, 16].contains(unchecked.base))
            self.root = unchecked
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @inlinable subscript<T>(dynamicMember keyPath: KeyPath<RadixUIntRoot, T>) -> T {
            self.root[keyPath: keyPath]
        }
    }
}

//*============================================================================*
// MARK: * ANK x Radix UInt Root x Imperfect
//*============================================================================*

extension RadixUIntRoot {
    
    //*========================================================================*
    // MARK: * Imperfect
    //*========================================================================*
    
    /// A ``RadixUIntRoot`` with a power that is non-zero.
    @dynamicMemberLookup @frozen @usableFromInline struct Imperfect {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let root: RadixUIntRoot
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(unchecked: RadixUIntRoot) {
            assert(!unchecked.power.isZero)
            assert(![2, 4, 16].contains(unchecked.base))
            self.root = unchecked
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @inlinable subscript<T>(dynamicMember keyPath: KeyPath<RadixUIntRoot, T>) -> T {
            self.root[keyPath: keyPath]
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Utilities
        //=--------------------------------------------------------------------=
        
        /// Overestimates how many times its power divides the magnitude.
        ///
        /// [67]: https://github.com/oscbyspro/AwesomeNumbersKit/issues/67
        ///
        @inlinable func divisibilityByPowerUpperBound(_ magnitude: some UnsignedInteger) -> Int {
            magnitude.bitWidth / 36.leadingZeroBitCount &+ 1
        }
    }
}

//*============================================================================*
// MARK: * ANK x Radix UInt Root x Algorithm
//*============================================================================*

extension RadixUIntRoot {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
    @inlinable static func _root(_ radix: UInt) -> (exponent: UInt, power: UInt) {
        assert(radix >= 2)
        //=--------------------------------------=
        var exponent  = 1 as UInt
        var power = radix as UInt
        let radix = radix as UInt
        //=--------------------------------------=
        exponentiate: while true {
            let product = power.multipliedFullWidth(by: radix) as HL<UInt, UInt>
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

//=----------------------------------------------------------------------------=
// MARK: + Perfect
//=----------------------------------------------------------------------------=

extension RadixUIntRoot.Perfect {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns the largest exponent such that `pow(radix, exponent) <= UInt.max + 1`.
    @inlinable static func _root(_ radix: UInt) -> (exponent: UInt, power: UInt) {
        assert(radix >= 2)
        assert(radix.isPowerOf2)
        //=--------------------------------------=
        let zeros = UInt(bitPattern: radix.trailingZeroBitCount)
        //=--------------------------------------=
        // Radix == 2,  4, 16, 256, ...
        //=--------------------------------------=
        if  zeros.isPowerOf2 {
            let exponent = UInt(bitPattern: UInt.bitWidth &>> zeros.trailingZeroBitCount)
            return (exponent: exponent, power: 0)
        //=--------------------------------------=
        // Radix == 8, 32, 64, 128, ...
        //=--------------------------------------=
        }   else {
            let exponent = UInt(bitPattern: UInt.bitWidth) /  zeros
            let shift: UInt = zeros.multipliedReportingOverflow(by: exponent).partialValue
            let power: UInt = (1 as UInt) &<<  shift
            return (exponent: exponent, power: power)
        }
    }
}
