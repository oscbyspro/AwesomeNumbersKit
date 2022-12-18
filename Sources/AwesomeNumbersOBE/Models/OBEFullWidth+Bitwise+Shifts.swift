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
        
        var x = self.index(self.endIndex, offsetBy: -0 &- words)
        var y = self.index(self.endIndex, offsetBy: -1 &- words)
        var z = self.endIndex
        
        self.withUnsafeMutableWords { SELF in
            brrr: while z != SELF.startIndex {
                x &-= 1
                y &-= 1
                z &-= 1
                
                let p = x >= SELF.startIndex ? SELF[unchecked: x] << a : c
                let q = y >= SELF.startIndex ? SELF[unchecked: y] >> b : d
                
                SELF[unchecked: z] = p | q
            }
        }
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
        
        self.withUnsafeMutableWords { SELf in
            var x = SELf.index(SELf.startIndex, offsetBy: +0 &+ words)
            var y = SELf.index(SELf.startIndex, offsetBy: +1 &+ words)
            var z = SELf.startIndex
            
            brrr: while z != SELf.endIndex {
                let p = x <  SELf.endIndex ? SELf[unchecked: x] >> a : c
                let q = y <  SELf.endIndex ? SELf[unchecked: y] << b : d
                
                SELf[unchecked: z] = p | q
                
                z &+= 1
                x &+= 1
                y &+= 1
            }
        }
    }
}
