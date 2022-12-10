//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Bitrotations x L
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Self) {
        lhs &<<= rhs.leastSignificantWord
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        lhs &<<= rhs.leastSignificantWord
    }

    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: UInt) {
        let words = rhs >> UInt.bitWidth.trailingZeroBitCount
        let bits  = rhs &  UInt(bitPattern: UInt.bitWidth &- 1)
        lhs._bitrotateLeft(words: words &  (UInt(bitPattern: Self.count &- 1)), bits: bits)
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: UInt) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - words: `words < Self.count`
    ///   - bits:  `bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitrotateLeft(words: UInt, bits: UInt) {
        assert(words < Self.endIndex)
        assert(bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let words = Int(bitPattern: words)
        let bits  = Int(bitPattern: bits )
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        withUnsafeTwosComplementWords { SELF in
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
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Self) {
        lhs &>>= rhs.leastSignificantWord
    }

    @inlinable public static func &>>(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        lhs &>>= rhs.leastSignificantWord
    }

    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: UInt) {
        let words = rhs >> UInt.bitWidth.trailingZeroBitCount
        let bits  = rhs &  UInt(bitPattern: UInt.bitWidth &- 1)
        lhs._bitrotateRight(words: words & (UInt(bitPattern: Self.count &- 1)), bits: bits)
    }

    @inlinable public static func &>>(lhs: Self, rhs: UInt) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - words: `words < Self.count`
    ///   - bits:  `bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitrotateRight(words: UInt, bits: UInt) {
        assert(words < Self.endIndex)
        assert(bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let words = Int(bitPattern: words)
        let bits  = Int(bitPattern: bits )
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        withUnsafeTwosComplementWords { SELF in
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

