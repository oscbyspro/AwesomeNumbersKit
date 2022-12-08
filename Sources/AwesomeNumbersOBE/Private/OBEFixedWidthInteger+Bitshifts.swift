//=----------------------------------------------------------------------------=
// This source file is part of the ExtraNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitshifts
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs <<= Int(clamping: rhs)
    }
    
    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs >>= Int(clamping: rhs)
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, _ rhs: Int) {
        rhs >= 0 ? lhs._bitshiftLeft(by: rhs) : lhs._bitshiftRight(by: -rhs)
    }

    @inlinable public static func <<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Int) {
        rhs >= 0 ? lhs._bitshiftRight(by: rhs) : lhs._bitshiftLeft(by: -rhs)
    }
    
    @inlinable public static func >>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
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
        guard amount < Self.bitWidth else { self = Self(); return }
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
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
    
    /// - Parameters:
    ///   - amount: `0 <= amount`
    ///
    @inlinable mutating func _bitshiftRight(by amount: Int) {
        assert(0 <= amount)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        guard amount < Self.bitWidth else { self = Self(repeating: isLessThanZero); return }
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
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
// MARK: * OBE x Fixed Width Integer x Bitrotations
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &<<= Int(clamping: rhs)
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }

    @inlinable public static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs &>>= Int(clamping: rhs)
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        rhs >= 0 ? lhs._bitrotateLeft(by: rhs) : lhs._bitrotateRight(by: -rhs)
    }

    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }

    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        rhs >= 0 ? lhs._bitrotateRight(by: rhs) : lhs._bitrotateLeft(by: -rhs)
    }

    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=

    /// - Parameters:
    ///   - amount: `0 <= amount`
    ///
    @inlinable mutating func _bitrotateLeft(by amount: Int) {
        assert(0 <= amount)
        assert(Self.count   .nonzeroBitCount == 1)
        assert(Self.bitWidth.nonzeroBitCount == 1)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let amount = amount & (Self.bitWidth &- 1)
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
        self._bitrotateLeft(words: words & (Self.count &- 1), bits: bits)
    }

    /// - Parameters:
    ///   - words: `0 <= words < Self.count`
    ///   - bits:  `0 <= bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitrotateLeft(words: Int, bits: Int) {
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        withUnsafeTwosComplementWords { SELF in
            let words0 = words
            let words1 = words < Self.lastIndex ? (words + 1) : (words - Self.lastIndex)

            let bits0  = bits
            let bits1  = UInt.bitWidth - bits

            for index in SELF.indices {
                let index0 = index - words0
                let index1 = index - words1

                let up   = SELF[index0 >= Self.startIndex ? index0 : index0 + Self.endIndex] << bits0
                let down = SELF[index1 >= Self.startIndex ? index1 : index1 + Self.endIndex] >> bits1

                NEXT[index] = up | down
            }
        }}
    }

    /// - Parameters:
    ///   - amount: `0 <= amount`
    ///
    @inlinable mutating func _bitrotateRight(by amount: Int) {
        assert(0 <= amount)
        assert(Self.count   .nonzeroBitCount == 1)
        assert(Self.bitWidth.nonzeroBitCount == 1)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let amount = amount & (Self.bitWidth &- 1)
        let (words, bits) = amount.quotientAndRemainder(dividingBy: UInt.bitWidth)
        self._bitrotateRight(words: words & (Self.count &- 1), bits: bits)
    }

    /// - Parameters:
    ///   - words: `0 <= words < Self.count`
    ///   - bits:  `0 <= bits  < UInt.bitWith`
    ///
    @inlinable mutating func _bitrotateRight(words: Int, bits: Int) {
        assert(0 <= words && words < Self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        //
        //=--------------------------------------=
        self = Self.fromUnsafeUninitializedTwosComplementWords { NEXT in
        withUnsafeTwosComplementWords { SELF in
            let words0 = words
            let words1 = words < Self.lastIndex ? (words + 1) : (words - Self.lastIndex)

            let bits0  = bits
            let bits1  = UInt.bitWidth - bits

            for index in Self.indices {
                let index0 = index + words0
                let index1 = index + words1

                let down = SELF[index0 < Self.endIndex ? index0 : index0 - Self.endIndex] >> bits0
                let up   = SELF[index1 < Self.endIndex ? index1 : index1 - Self.endIndex] << bits1

                NEXT[index] = up | down
            }
        }}
    }
}
