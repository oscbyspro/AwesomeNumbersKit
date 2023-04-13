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
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Self) {
        lhs._bitshiftLeft(by: rhs._moduloBitWidth)
    }
    
    @_transparent public static func &<<(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(by amount: Int) {
        assert(0 ..< Self.bitWidth ~= amount)
        let words: Int = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits:  Int = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftLeft(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @_transparent @usableFromInline func _bitshiftedLeft(by amount: Int) -> Self {
        var x = self; x._bitshiftLeft(by: amount); return x
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftLeft(words: Int, bits: Int) {
        assert(0 ..< Self.endIndex ~= words)
        assert(0 ..< UInt.bitWidth ~= bits )
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth &- bits)
        let x = bits.isZero  as  Bool
        //=--------------------------------------=
        self.withUnsafeMutableWords { SELF in
            var i: Int = SELF.endIndex
            backwards: while i > SELF.startIndex {
                SELF.formIndex(before: &i)
                
                let j: Int  = i &- words
                let k: Int  = j &- 1
                
                let p: UInt = /*---*/ (j >= SELF.startIndex ? SELF[j] : 0) &<< a
                let q: UInt = x ? 0 : (k >= SELF.startIndex ? SELF[k] : 0) &>> b
                
                SELF[i] = p | q
            }
        }
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @_transparent @usableFromInline func _bitshiftedLeft(words: Int, bits: Int) -> Self {
        var x = self; x._bitshiftLeft(words: words, bits: bits); return x
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Shifts x R
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Self) {
        lhs._bitshiftRight(by: rhs._moduloBitWidth)
    }
    
    @_transparent public static func &>>(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(by amount: Int) {
        assert(0 ..< Self.bitWidth ~= amount)
        let words: Int = amount &>> UInt.bitWidth.trailingZeroBitCount
        let bits:  Int = amount &  (UInt.bitWidth &- 1)
        return self._bitshiftRight(words: words, bits: bits)
    }
    
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @_transparent @usableFromInline func _bitshiftedRight(by amount: Int) -> Self {
        var x = self; x._bitshiftRight(by: amount); return x
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable mutating func _bitshiftRight(words: Int, bits: Int) {
        assert(0 ..< Self.endIndex ~= words)
        assert(0 ..< UInt.bitWidth ~= bits )
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth &- bits)
        let c = UInt(repeating:  self.isLessThanZero)
        let x = bits.isZero  as  Bool
        //=--------------------------------------=
        self.withUnsafeMutableWords { SELF in
            var i: Int = SELF.startIndex
            forwards: while i < SELF.endIndex {
                let j:  Int = i &+ words
                let k:  Int = j &+ 1
                
                let p: UInt = /*---*/ (j < SELF.endIndex ? SELF[j] : c) &>> a
                let q: UInt = x ? 0 : (k < SELF.endIndex ? SELF[k] : c) &<< b
                SELF[i] = p | q
                
                SELF.formIndex(after: &i)
            }
        }
    }
    
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @_transparent @usableFromInline func _bitshiftedRight(words: Int, bits: Int) -> Self {
        var x = self; x._bitshiftRight(words: words, bits: bits); return x
    }
}
