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
// MARK: * ANK x Full Width x Bitwise x Shifts x L
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &<<=(lhs: inout Self, rhs: Self) {
        lhs._bitshiftLeft(by: rhs.absoluteValueModuloBitWidth)
    }
    
    @_transparent @usableFromInline static func &<<(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Internal
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(by amount: Int) {
        self = self._bitshiftedLeft(by: amount)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(by amount: Int) -> Self {
        assert(0 <= amount &&  amount < Self.bitWidth)
        let words = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftedLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(words: Int, bits: Int) {
        self = self._bitshiftedLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedLeft(words: Int, bits: Int) -> Self {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        var next = Self()
        //=--------------------------------------=
        next.withUnsafeMutableWords { NEXT in
        self.withUnsafeWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var i = SELF.endIndex
            var j = SELF.index(i, offsetBy: -words)
            var k = SELF.index(before: j)
            
            while k  != SELF.startIndex {
                SELF.formIndex(before: &i)
                SELF.formIndex(before: &j)
                SELF.formIndex(before: &k)
                
                let p = /*-------*/ SELF[unchecked: j] &<< a
                let q = !a.isZero ? SELF[unchecked: k] &>> b : UInt()
                NEXT[unchecked: i] = p | q
            }
            
            SELF.formIndex(before: &i)
            SELF.formIndex(before: &j)
            NEXT[unchecked: i] = SELF[unchecked: j] &<< a
        }}
        //=--------------------------------------=
        return next
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Bitwise x Shifts x R
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func &>>=(lhs: inout Self, rhs: Self) {
        lhs._bitshiftRight(by: rhs.absoluteValueModuloBitWidth)
    }
    
    @_transparent @usableFromInline static func &>>(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int x Internal
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(by amount: Int) {
        self = self._bitshiftedRight(by: amount)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable func _bitshiftedRight(by amount: Int) -> Self {
        assert(0 <= amount &&  amount < Self.bitWidth)
        let words = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits  = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftedRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(words: Int, bits: Int) {
        self = self._bitshiftedRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable func _bitshiftedRight(words: Int, bits: Int) -> Self {
        assert(0 <= words && words < self.endIndex)
        assert(0 <= bits  && bits  < UInt.bitWidth)
        //=--------------------------------------=
        let isLessThanZero = (self.isLessThanZero)
        var next = Self(repeating: isLessThanZero)
        //=--------------------------------------=
        next.withUnsafeMutableWords { NEXT in
        self.withUnsafeWords { SELF in
            let a = bits
            let b = UInt.bitWidth &- bits
            
            var i = SELF.startIndex
            var j = SELF.index(i, offsetBy: words)
            var k = SELF.index(after: j)

            while k  != SELF.endIndex {
                let p = /*-------*/ SELF[unchecked: j] &>> a
                let q = !a.isZero ? SELF[unchecked: k] &<< b : UInt()
                NEXT[unchecked: i] = p | q
                
                SELF.formIndex(after: &i)
                SELF.formIndex(after: &j)
                SELF.formIndex(after: &k)
            }
            
            let p = SELF[unchecked: j] &>> a
            let q = !a.isZero && isLessThanZero ? ~UInt() &<< b : UInt()
            NEXT[unchecked: i] = p | q
        }}
        //=--------------------------------------=
        return next
    }
}
