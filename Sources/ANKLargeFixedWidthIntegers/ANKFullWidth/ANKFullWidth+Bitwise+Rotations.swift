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
// MARK: * ANK x Full Width x Bitwise x Rotations x L
//*============================================================================*

extension ANKFullWidth {
    
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
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitrotatedLeft(by amount: Int) -> Self {
        var S0 = self; S0._bitrotateLeft(by: amount); return S0
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitrotateLeft(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        self = Self.fromUnsafeTemporaryWords { NEXT in
        self.withUnsafeWords { SELf in
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var x = SELf.index(SELf.endIndex, offsetBy: -0 &- words)
            var y = SELf.index(SELf.endIndex, offsetBy: -1 &- words)
            var z = SELf.endIndex
            
            brrrrr: while z != SELf.startIndex {
                x = y
                SELf.formIndex(&y, offsetBy: y == SELf.startIndex ? SELf.lastIndex : -1)
                SELf.formIndex(before: &z)
                
                NEXT[unchecked: z] = SELf[unchecked: x] << a | SELf[unchecked: y] >> b
            }
        }}
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitrotatedLeft(words: Int, bits: Int) -> Self {
        var S0 = self; S0._bitrotateLeft(words: words, bits: bits); return S0
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Bitwise x Rotations x R
//*============================================================================*

extension ANKFullWidth {
    
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
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitrotatedRight(by amount: Int) -> Self {
        var S0 = self; S0._bitrotateRight(by: amount); return S0
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitrotateRight(words: Int, bits: Int) {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        
        self = Self.fromUnsafeTemporaryWords { NEXT in
        self.withUnsafeWords { SELf in
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var x = SELf.index(SELf.startIndex, offsetBy: +1 &+ words)
            var y = SELf.index(SELf.startIndex, offsetBy: +0 &+ words)
            var z = SELf.endIndex
            
            brrrrr: while z != SELf.startIndex {
                x = y
                SELf.formIndex(&y, offsetBy: y == SELf.startIndex ? SELf.lastIndex : -1)
                SELf.formIndex(before: &z)
                
                NEXT[unchecked: z] = SELf[unchecked: x] << b | SELf[unchecked: y] >> a
            }
        }}
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitrotatedRight(words: Int, bits: Int) -> Self {
        var S0 = self; S0._bitrotateRight(words: words, bits: bits); return S0
    }
}
