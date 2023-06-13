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
// MARK: * ANK x Arithmetic x Int
//*============================================================================*

extension Int {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the `quotient` of dividing this value by its bit width.
    @inlinable func quotientDividingByBitWidthAssumingIsAtLeastZero() -> Self {
        assert(self.isLessThanZero == false, "this value must be at least zero")
        return Self(bitPattern: Magnitude(bitPattern: self).quotientDividingByBitWidth())
    }
    
    /// Returns the `remainder` of dividing this value by its bit width.
    @inlinable func remainderDividingByBitWidthAssumingIsAtLeastZero() -> Self {
        assert(self.isLessThanZero == false, "this value must be at least zero")
        return Self(bitPattern: Magnitude(bitPattern: self).remainderDividingByBitWidth())
    }
}

//*============================================================================*
// MARK: * ANK x Arithmetic x UInt
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the `quotient` of dividing this value by its bit width.
    @inlinable func quotientDividingByBitWidth() -> Self {
        self &>> Self(bitPattern: Self.bitWidth.trailingZeroBitCount)
    }
    
    /// Returns the `remainder` of dividing this value by its bit width.
    @inlinable func remainderDividingByBitWidth() -> Self {
        self & Self(bitPattern: Self.bitWidth &- 1)
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
    @inlinable func moduloBitWidth() -> Int where Self: FixedWidthInteger {
        self.moduloBitWidth(of: Self.self)
    }
    
    /// Returns `self` modulo `other.bitWidth`.
    @inlinable func moduloBitWidth<T>(of other: T.Type) -> Int where T: FixedWidthInteger {
        Int(bitPattern: self.modulo(UInt(bitPattern: other.bitWidth)))
    }
    
    /// Returns `self` modulo `modulus`.
    @inlinable func modulo(_ modulus: UInt) -> UInt {
        //=--------------------------------------=
        if  modulus.isPowerOf2 {
            return self._lowWord & (modulus &- 1)
        }
        //=--------------------------------------=
        let minus = Self.isSigned && self < (0 as Self)
        var residue = UInt.zero
        
        for word in self.magnitude.words.reversed() {
            residue = modulus.dividingFullWidth(HL(residue, word)).remainder
        }
        
        return minus ? modulus &- residue : residue
    }
}
