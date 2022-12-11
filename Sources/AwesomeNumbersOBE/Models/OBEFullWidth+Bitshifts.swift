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
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs <   type(of: rhs).init() {
            lhs >>= type(of: rhs).init() - rhs; return
        }
        //=--------------------------------------=
        // RHS >= Self.bitWidth
        //=--------------------------------------=
        if  rhs >= Self.bitWidth {
            lhs  = Self(); return
        }
        //=--------------------------------------=
        // Self.zero <= RHS <  Self.bitWidth
        //=--------------------------------------=
        lhs._bitshiftLeft(by: Int(bitPattern: rhs.words.first ?? UInt()))
    }
    
    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Self
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Self) {
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs.isLessThanZero {
            lhs >>= Self(bitPattern: rhs.magnitude); return
        }
        //=--------------------------------------=
        // RHS >= Self.bitWidth
        //=--------------------------------------=
        if  rhs.leadingZeroBitCount <= Self.bitWidth.leadingZeroBitCount {
            lhs = Self(); return
        }
        //=--------------------------------------=
        // Self.zero <= RHS <  Self.bitWidth
        //=--------------------------------------=
        lhs._bitshiftLeft(by: Int(bitPattern: rhs.leastSignificantWord))
    }
    
    @inlinable public static func <<(lhs: Self, rhs: Self) -> Self {
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
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        self.withUnsafeMutableTwosComplementWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits
            let c = UInt(repeating: false)
            
            var x = Self.endIndex &- words
            var y = Self.endIndex &- words &- 1
            var z = Self.endIndex
            
            backwards: while z != Self.startIndex {
                x &-= 1
                y &-= 1
                z &-= 1
                
                let up   = x >= Self.startIndex ? SELF[x] << a : c
                let down = y >= Self.startIndex ? SELF[y] >> b : c
                
                SELF[z] = up | down
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
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs <   type(of: rhs).init() {
            lhs <<= type(of: rhs).init() - rhs; return
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
        lhs._bitshiftRight(by: Int(bitPattern: rhs.words.first ?? UInt()))
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Self
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Self) {
        //=--------------------------------------=
        // RHS <  Self.zero
        //=--------------------------------------=
        if  rhs.isLessThanZero {
            lhs <<= Self(bitPattern: rhs.magnitude); return
        }
        //=--------------------------------------=
        // RHS >= Self.bitWidth
        //=--------------------------------------=
        if  rhs.leadingZeroBitCount <= Self.bitWidth.leadingZeroBitCount {
            lhs = Self(repeating: lhs.isLessThanZero); return
        }
        //=--------------------------------------=
        // Self.zero <= RHS <  Self.bitWidth
        //=--------------------------------------=
        lhs._bitshiftRight(by: Int(bitPattern: rhs.leastSignificantWord))
    }
    
    @inlinable public static func >>(lhs: Self, rhs: Self) -> Self {
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
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        self.withUnsafeMutableTwosComplementWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits
            let c = UInt(repeating:  SELF.isLessThanZero)
            
            var x = words
            var y = words &+ 1
            var z = Self.startIndex
            
            loop: while z !=   Self.endIndex {
                let down = x < Self.endIndex ? SELF[x] >> a : c
                let up   = y < Self.endIndex ? SELF[y] << b : c

                SELF[z] = up | down
                
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
    // MARK: Transformations x Self
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Self) {
        lhs &<<= Int(bitPattern: rhs.leastSignificantWord)
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: Self) -> Self {
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
    // MARK: Transformations x UInt x Private
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
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        self.withUnsafeTwosComplementWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits

            var x = Self.endIndex &- words
            var y = Self.endIndex &- words &- 1
            var z = Self.endIndex
            
            loop: while z != Self.startIndex {
                z &-= 1
                x = x > Self.startIndex ? x &- 1 : x &+ Self.lastIndex
                y = y > Self.startIndex ? y &- 1 : y &+ Self.lastIndex
                
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
    // MARK: Transformations x Self
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Self) {
        lhs &>>= Int(bitPattern: rhs.leastSignificantWord)
    }

    @inlinable public static func &>>(lhs: Self, rhs: Self) -> Self {
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
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        self.withUnsafeTwosComplementWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var x = words &- 1
            var y = words
            var z = Self.startIndex
            
            loop: while z  != Self.endIndex {
                defer { z &+= 1 }
                x = x < Self.lastIndex ? x &+ 1 : x &- Self.lastIndex
                y = y < Self.lastIndex ? y &+ 1 : y &- Self.lastIndex
                NEXT[z] = SELF[x] >> a | SELF[y] << b
            }
        }}
    }
}
