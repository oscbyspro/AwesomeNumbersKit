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
// MARK: * OBE x Fixed Width Integer x Bitshifts x L
//*============================================================================*

extension OBEFixedWidthInteger {
    
    // TODO: use real method
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        let rhs = Int(rhs); rhs.isLessThanZero ? lhs._bitshiftRight(by: -rhs) : lhs._bitshiftLeft(by: rhs)
    }
    
    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount`
    ///
    @inlinable mutating func _bitshiftLeft(by amount: Int) {
        assert(0 <= amount)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
        guard words < Self.count else { self = Self(); return }
        self._bitshiftLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.count`
    ///   - bits:  `0 <= bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitshiftLeft(words: Int, bits: Int) {
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self.withUnsafeMutableTwosComplementWords { SELF in
            let words0 = words
            let words1 = words + 1
            
            let bits0  = bits
            let bits1  = UInt.bitWidth - bits
            
            var index  = Self.endIndex
            backwards: while index != Self.startIndex {
                index -= 1
                
                let index0 = index - words0
                let index1 = index - words1
                
                let up   = index0 >= Self.startIndex ? SELF[index0] << bits0 : 0
                let down = index1 >= Self.startIndex ? SELF[index1] >> bits1 : 0
                
                SELF[index] = up | down
            }
        }
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitshifts x R
//*============================================================================*

extension OBEFixedWidthInteger {
    
    // TODO: use real method
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        let rhs = Int(rhs); rhs.isLessThanZero ? lhs._bitshiftLeft(by: -rhs) : lhs._bitshiftRight(by: rhs)
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount`
    ///
    @inlinable mutating func _bitshiftRight(by amount: Int) {
        assert(0 <= amount)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
        guard words < Self.count else { self = isLessThanZero ? -1 : Self(); return }
        self._bitshiftRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.count`
    ///   - bits:  `0 <= bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitshiftRight(words: Int, bits: Int) {
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let sign = UInt(repeating: isLessThanZero)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self.withUnsafeMutableTwosComplementWords { SELF in
            let words0 = words
            let words1 = words + 1
            
            let bits0  = bits
            let bits1  = UInt.bitWidth - bits
            
            for index in Self.indices {
                let index0 = index + words0
                let index1 = index + words1
                
                let down = index0 < Self.endIndex ? SELF[index0] >> bits0 : sign
                let up   = index1 < Self.endIndex ? SELF[index1] << bits1 : sign
                
                SELF[index] = up | down
            }
        }
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitrotations x L
//*============================================================================*

extension OBEFixedWidthInteger {
    
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
// MARK: * OBE x Fixed Width Integer x Bitrotations x R
//*============================================================================*

extension OBEFixedWidthInteger {
    
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
