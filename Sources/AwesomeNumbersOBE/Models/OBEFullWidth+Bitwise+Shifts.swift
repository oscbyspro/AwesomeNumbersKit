//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Full Width x Bitwise x Shifts x L
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs <<= Int(clamping: rhs)
    }
    
    @inlinable static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable static func <<=(lhs: inout Self, rhs: Int) {
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs.isLessThanZero {
            lhs >>= Int() - rhs; return
        }
        //=--------------------------------------=
        // RHS >= Self.bitWidth
        //=--------------------------------------=
        if  rhs >= Self.bitWidth {
            lhs  = Self(); return
        }
        //=--------------------------------------=
        // RHS <  Self.bitWidth
        //=--------------------------------------=
        lhs._bitshiftLeft(by: rhs)
    }
    
    @inlinable static func <<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Private
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(by amount: Int) {
        assert(0 <= amount && amount < Self.bitWidth)
        let words = amount >> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount & (UInt.bitWidth &- 1)
        self._bitshiftLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(by amount: Int) -> Self {
        var S0 = self; S0._bitshiftLeft(by: amount); return S0
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        let a = bits
        let b = UInt.bitWidth &- bits
        let c = UInt(repeating: false) << a
        let d = UInt(repeating: false) >> b
        
        var i = self.endIndex
        var j = self.index(self.endIndex, offsetBy: -0 &- words)
        var k = self.index(self.endIndex, offsetBy: -1 &- words)
        
        self.withUnsafeMutableWords { SELF in
        brrr: while i != SELF.startIndex {
            i &-= 1
            j &-= 1
            k &-= 1
            
            let p = j >= SELF.startIndex ? SELF[unchecked: j] << a : c
            let q = k >= SELF.startIndex ? SELF[unchecked: k] >> b : d
            
            SELF[unchecked: i] = p | q
        }}
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(words: Int, bits: Int) -> Self {
        var S0 = self; S0._bitshiftLeft(words: words, bits: bits); return S0
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitwise x Shifts x R
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some BinaryInteger
    //=------------------------------------------------------------------------=
    
    @inlinable static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs >>= Int(clamping: rhs)
    }
    
    @inlinable static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable static func >>=(lhs: inout Self, rhs: Int) {
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs.isLessThanZero {
            lhs <<= Int() - rhs; return
        }
        //=--------------------------------------=
        // RHS >= Self.bitWidth
        //=--------------------------------------=
        if  rhs >= Self.bitWidth {
            lhs  = Self(repeating: lhs.isLessThanZero); return
        }
        //=--------------------------------------=
        // Self.zero <= RHS <  Self.bitWidth
        //=--------------------------------------=
        lhs._bitshiftRight(by: rhs)
    }
    
    @inlinable static func >>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Private
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(by amount: Int) {
        assert(0 <= amount && amount < Self.bitWidth)
        let words = amount >> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount & (UInt.bitWidth &- 1)
        self._bitshiftRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedRight(by amount: Int) -> Self {
        var S0 = self; S0._bitshiftRight(by: amount); return S0
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        let a = bits
        let b = UInt.bitWidth &- bits
        let c = UInt(repeating:  self.isLessThanZero) << a
        let d = UInt(repeating:  self.isLessThanZero) >> b
        
        var i = self.startIndex
        var j = self.index(self.startIndex, offsetBy: +0 &+ words)
        var k = self.index(self.startIndex, offsetBy: +1 &+ words)
        
        self.withUnsafeMutableWords { SELf in
        brrr: while i != SELf.endIndex {
            let p = j <  SELf.endIndex ? SELf[unchecked: j] >> a : c
            let q = k <  SELf.endIndex ? SELf[unchecked: k] << b : d
            
            SELf[unchecked: i] = p | q
            
            i &+= 1
            j &+= 1
            k &+= 1
        }}
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedRight(words: Int, bits: Int) -> Self {
        var S0 = self; S0._bitshiftRight(words: words, bits: bits); return S0
    }
}
