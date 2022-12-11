//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Bitshifts x L
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs <<= Int(clamping: rhs)
    }
    
    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Int) {
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
    
    @inlinable public static func <<(lhs: Self, rhs: Int) -> Self {
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
        self.withUnsafeMutableTwosComplementWords { SELF in
            assert(0 <= words && words < SELF.endIndex)
            assert(0 <= bits  && bits  < UInt.bitWidth)
            
            let a = bits
            let b = UInt.bitWidth &- bits
            let c = UInt(repeating: false)
            
            var x = SELF.index(SELF.endIndex, offsetBy: -words &- 0)
            var y = SELF.index(SELF.endIndex, offsetBy: -words &- 1)
            var z = SELF.endIndex
            
            brrr: while z != SELF.startIndex {
                x &-= 1
                y &-= 1
                z &-= 1
                
                let p = x >= SELF.startIndex ? SELF[x] << a : c
                let q = y >= SELF.startIndex ? SELF[y] >> b : c
                
                SELF[z] = p | q
            }
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitshifts x R
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some BinaryInteger
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs >>= Int(clamping: rhs)
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Int) {
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
    
    @inlinable public static func >>(lhs: Self, rhs: Int) -> Self {
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
        self.withUnsafeMutableTwosComplementWords { SELF in
            assert(0 <= words && words < SELF.endIndex)
            assert(0 <= bits  && bits  < UInt.bitWidth)
            
            let a = bits
            let b = UInt.bitWidth &- bits
            let c = UInt(repeating:  SELF.isLessThanZero)
            
            var x = SELF.index(SELF.startIndex, offsetBy: words &+ 0)
            var y = SELF.index(SELF.startIndex, offsetBy: words &+ 1)
            var z = SELF.startIndex
            
            brrr: while z != SELF.endIndex {
                let p = x <  SELF.endIndex ? SELF[x] >> a : c
                let q = y <  SELF.endIndex ? SELF[y] << b : c

                SELF[z] = p | q
                
                z &+= 1
                x &+= 1
                y &+= 1
            }
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
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &<<= Int(bitPattern: rhs.words.first ?? UInt())
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        lhs._bitrotateLeft(by: rhs & (Self.bitWidth &- 1))
    }

    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
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
        self = self.withUnsafeTwosComplementWords { SELF in
        Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
            assert(0 <= words && words < SELF.endIndex)
            assert(0 <= bits  && bits  < UInt.bitWidth)
            
            let a = bits
            let b = UInt.bitWidth &- bits

            var x = SELF.index(SELF.endIndex, offsetBy: -0 &- words)
            var y = SELF.index(SELF.endIndex, offsetBy: -1 &- words)
            var z = SELF.endIndex
            
            brrrrr: while z != SELF.startIndex {
                x = y
                SELF.formIndex(&y, offsetBy: y == SELF.startIndex ? SELF.lastIndex : -1)
                SELF.formIndex(before: &z)
                
                NEXT[z] = SELF[x] << a | SELF[y] >> b
            }
        }}
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Bitrotations x R
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &>>= Int(bitPattern: rhs.words.first ?? UInt())
    }

    @inlinable public static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        lhs._bitrotateRight(by: rhs & (Self.bitWidth &- 1))
    }

    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
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
        self = self.withUnsafeTwosComplementWords { SELF in
        Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
            assert(0 <= words && words < SELF.endIndex)
            assert(0 <= bits  && bits  < UInt.bitWidth)
            
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var x = SELF.index(SELF.startIndex, offsetBy: +1 &+ words)
            var y = SELF.index(SELF.startIndex, offsetBy: +0 &+ words)
            var z = SELF.endIndex
            
            brrrrr: while z != SELF.startIndex {
                x = y
                SELF.formIndex(&y, offsetBy: y == SELF.startIndex ? SELF.lastIndex : -1)
                SELF.formIndex(before: &z)
                
                NEXT[z] = SELF[x] << b | SELF[y] >> a
            }
        }}
    }
}
