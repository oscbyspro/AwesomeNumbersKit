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
// MARK: * ANK x Full Width x Shifts x L
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &<<=(lhs: inout Self, rhs: Self) {
        lhs = lhs &<< rhs
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: Self) -> Self {
        lhs._bitshiftedLeft(by: rhs._moduloBitWidth)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @_transparent @usableFromInline mutating func _bitshiftLeft(by amount: Int) {
        self = self._bitshiftedLeft(by: amount)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(by amount: Int) -> Self {
        assert(0 ..< Self.bitWidth ~= amount)
        let words: Int = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits:  Int = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftedLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @_transparent @usableFromInline mutating func _bitshiftLeft(words: Int, bits: Int) {
        self = self._bitshiftedLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(words: Int, bits: Int) -> Self {
        assert(0 ..< Self.endIndex ~= words)
        assert(0 ..< UInt.bitWidth ~= bits )
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth &- bits)
        let c = bits != Int()
        //=--------------------------------------=
        return self.withUnsafeWords { SELF in
        Self.fromUnsafeMutableWords { NEXT in
        for i in SELF.indices {
            let j = i &- words
            let k = j &- 1
            
            let p: UInt =     (j >= SELF.startIndex ? SELF[j] : UInt()) &<< a
            let q: UInt = c ? (k >= SELF.startIndex ? SELF[k] : UInt()) &>> b : UInt()
            NEXT[i] = p | q
        }}}
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Shifts x R
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &>>=(lhs: inout Self, rhs: Self) {
        lhs = lhs &>> rhs
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: Self) -> Self {
        lhs._bitshiftedRight(by: rhs._moduloBitWidth)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @_transparent @usableFromInline mutating func _bitshiftRight(by amount: Int) {
        self = self._bitshiftedRight(by: amount)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedRight(by amount: Int) -> Self {
        assert(0 ..< Self.bitWidth ~= amount)
        let words: Int = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits:  Int = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftedRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @_transparent @usableFromInline mutating func _bitshiftRight(words: Int, bits: Int) {
        self = self._bitshiftedRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedRight(words: Int, bits: Int) -> Self {
        assert(0 ..< Self.endIndex ~= words)
        assert(0 ..< UInt.bitWidth ~= bits )
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth &- bits)
        let c = bits != Int()
        let d = UInt(repeating: self.isLessThanZero)
        //=--------------------------------------=
        return self.withUnsafeWords { SELF in
        Self.fromUnsafeMutableWords { NEXT in
        for i in SELF.indices {
            let j = i &+ words
            let k = j &+ 1
            
            let p: UInt =     (j < SELF.endIndex ? SELF[j] : d) &>> a
            let q: UInt = c ? (k < SELF.endIndex ? SELF[k] : d) &<< b : UInt()
            NEXT[i] = p | q
        }}}
    }
}
