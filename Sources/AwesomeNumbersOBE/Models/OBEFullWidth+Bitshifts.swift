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
// MARK: * OBE x Full Width x Bitshifts x L
//*============================================================================*

// TODO: it only requires isLessThanZero
extension OBEFullWidthInteger {
    
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
        
        brrr: while z != self.startIndex {
            x &-= 1
            y &-= 1
            z &-= 1
            
            let p = x >= self.startIndex ? self[unchecked: x] << a : c
            let q = y >= self.startIndex ? self[unchecked: y] >> b : d
            
            self[unchecked: z] = p | q
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitshifts x R
//*============================================================================*

// TODO: it only requires isLessThanZero
extension OBEFullWidthInteger {
    
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
        
        var x = self.index(self.startIndex, offsetBy: +0 &+ words)
        var y = self.index(self.startIndex, offsetBy: +1 &+ words)
        var z = self.startIndex
        
        brrr: while z != self.endIndex {
            let p = x <  self.endIndex ? self[unchecked: x] >> a : c
            let q = y <  self.endIndex ? self[unchecked: y] << b : d
            
            self[unchecked: z] = p | q
            
            z &+= 1
            x &+= 1
            y &+= 1
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitrotations x L
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &<<= Int(bitPattern: rhs.words.first ?? UInt())
    }
    
    @inlinable static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable static func &<<=(lhs: inout Self, rhs: Int) {
        lhs._bitrotateLeft(by: rhs & (Self.bitWidth &- 1))
    }

    @inlinable static func &<<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Private
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitrotateLeft(by amount: Int) {
        assert(0 <= amount && amount < Self.bitWidth)
        let words = amount >> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount & (UInt.bitWidth &- 1)
        self._bitrotateLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitrotateLeft(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        var next = Self.uninitialized(); defer { self = next }
        
        let a = bits
        let b = UInt.bitWidth &- bits

        var x = self.index(self.endIndex, offsetBy: -0 &- words)
        var y = self.index(self.endIndex, offsetBy: -1 &- words)
        var z = self.endIndex
        
        brrrrr: while z != self.startIndex {
            x = y
            self.formIndex(&y, offsetBy: y == self.startIndex ? self.lastIndex : -1)
            self.formIndex(before: &z)
            
            next[unchecked: z] = self[unchecked: x] << a | self[unchecked: y] >> b
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitrotations x R
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &>>= Int(bitPattern: rhs.words.first ?? UInt())
    }

    @inlinable static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable static func &>>=(lhs: inout Self, rhs: Int) {
        lhs._bitrotateRight(by: rhs & (Self.bitWidth &- 1))
    }

    @inlinable static func &>>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Private
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitrotateRight(by amount: Int) {
        assert(0 <= amount && amount < Self.bitWidth)
        let words = amount >> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount & (UInt.bitWidth &- 1)
        self._bitrotateRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitrotateRight(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        var next = Self.uninitialized(); defer { self = next }
        
        let a = bits
        let b = UInt.bitWidth &- bits
        
        var x = self.index(self.startIndex, offsetBy: +1 &+ words)
        var y = self.index(self.startIndex, offsetBy: +0 &+ words)
        var z = self.endIndex
        
        brrrrr: while z != self.startIndex {
            x = y
            self.formIndex(&y, offsetBy: y == self.startIndex ? self.lastIndex : -1)
            self.formIndex(before: &z)
            
            next[unchecked: z] = self[unchecked: x] << b | self[unchecked: y] >> a
        }
    }
}
