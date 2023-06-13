//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width x Shifts x L
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.bitshiftLeftSmart(by: Int(clamping: rhs))
    }

    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs <<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.bitshiftLeftUnchecked(by: rhs.moduloBitWidth(of: Self.self))
    }

    @inlinable public static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &<<= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// Performs a smart left shift.
    ///
    /// - Parameters:
    ///   - amount: `Int.min <= amount <= Int.max`
    ///
    @inlinable public mutating func bitshiftLeftSmart(by amount: Int) {
        let unsigned = amount.magnitude as UInt
        switch (amount >= 0, unsigned < UInt(bitPattern: Self.bitWidth)) {
        case (true,  true ): self.bitshiftLeftUnchecked(by:  Int(bitPattern: unsigned))
        case (true,  false): self = Self(repeating:  false)
        case (false, true ): self.bitshiftRightUnchecked(by: Int(bitPattern: unsigned))
        case (false, false): self = Self(repeating:  self.isLessThanZero)
        }
    }
    
    /// Performs a smart left shift.
    ///
    /// - Parameters:
    ///   - amount: `Int.min <= amount <= Int.max`
    ///
    @inlinable public func bitshiftedLeftSmart(by amount: Int) -> Self {
        var result = self; result.bitshiftLeftSmart(by: amount); return result
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable public mutating func bitshiftLeftUnchecked(by amount: Int) {
        assert(0 ..< Self.bitWidth ~= amount, "invalid left shift amount")
        let major = amount .quotientDividingByBitWidthAssumingIsAtLeastZero()
        let minor = amount.remainderDividingByBitWidthAssumingIsAtLeastZero()
        return self.bitshiftLeftUnchecked(words: major, bits: minor)
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable public func bitshiftedLeftUnchecked(by amount: Int) -> Self {
        var result = self; result.bitshiftLeftUnchecked(by: amount); return result
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public mutating func bitshiftLeftUnchecked(words major: Int, bits minor: Int) {
        assert(0 ..< Self.endIndex ~= major, "invalid major left shift amount")
        assert(0 ..< UInt.bitWidth ~= minor, "invalid minor left shift amount")
        //=--------------------------------------=
        let a = UInt(bitPattern: minor)
        let b = UInt(bitPattern: UInt.bitWidth &- minor)
        let x = minor.isZero as  Bool
        //=--------------------------------------=
        self.withUnsafeMutableWords { this in
            for i: Int  in  this.indices.reversed() {
                let j:  Int = i &- major
                let k:  Int = j &- 1
                
                let p: UInt =         (j >= this.startIndex ? this[j] : 0) &<< a
                let q: UInt = x ? 0 : (k >= this.startIndex ? this[k] : 0) &>> b
                
                this[i] = p | q
            }
        }
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public func bitshiftedLeftUnchecked(words: Int, bits: Int) -> Self {
        var result = self; result.bitshiftLeftUnchecked(words: words, bits: bits); return result
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Shifts x R
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.bitshiftRightSmart(by: Int(clamping: rhs))
    }

    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs >>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self,  rhs: some BinaryInteger) {
        lhs.bitshiftRightUnchecked(by: rhs.moduloBitWidth(of: Self.self))
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        var lhs = lhs; lhs &>>= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    /// Performs a smart, signed, right shift.
    ///
    /// - Parameters:
    ///   - amount: `Int.min <= amount <= Int.max`
    ///
    @inlinable public mutating func bitshiftRightSmart(by amount: Int) {
        let unsigned = amount.magnitude as UInt
        switch (amount >= 0, unsigned < UInt(bitPattern: Self.bitWidth)) {
        case (true,  true ): self.bitshiftRightUnchecked(by: Int(bitPattern: unsigned))
        case (true,  false): self = Self(repeating:  self.isLessThanZero)
        case (false, true ): self.bitshiftLeftUnchecked(by:  Int(bitPattern: unsigned))
        case (false, false): self = Self(repeating:  false)
        }
    }
    
    /// Performs a smart, signed, right shift.
    ///
    /// - Parameters:
    ///   - amount: `Int.min <= amount <= Int.max`
    ///
    @inlinable public func bitshiftedRightSmart(by amount: Int) -> Self {
        var result = self; result.bitshiftRightSmart(by: amount); return result
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable public mutating func bitshiftRightUnchecked(by amount: Int) {
        assert(0 ..< Self.bitWidth ~= amount, "invalid right shift amount")
        let major = amount .quotientDividingByBitWidthAssumingIsAtLeastZero()
        let minor = amount.remainderDividingByBitWidthAssumingIsAtLeastZero()
        return self.bitshiftRightUnchecked(words: major, bits: minor)
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - amount: `0 <= amount < Self.bitWidth`
    ///
    @inlinable public func bitshiftedRightUnchecked(by amount: Int) -> Self {
        var result = self; result.bitshiftRightUnchecked(by: amount); return result
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public mutating func bitshiftRightUnchecked(words major: Int, bits minor: Int) {
        assert(0 ..< Self.endIndex ~= major, "invalid major right shift amount")
        assert(0 ..< UInt.bitWidth ~= minor, "invalid minor right shift amount")
        //=--------------------------------------=
        let a = UInt(bitPattern: minor)
        let b = UInt(bitPattern: UInt.bitWidth &- minor)
        let c = UInt(repeating:  self.isLessThanZero)
        let x = minor.isZero as  Bool
        //=--------------------------------------=
        self.withUnsafeMutableWords { this in
            for i: Int  in  this.indices {
                let j:  Int = i &+ major
                let k:  Int = j &+ 1
                
                let p: UInt =         (j < this.endIndex ? this[j] : c) &>> a
                let q: UInt = x ? 0 : (k < this.endIndex ? this[k] : c) &<< b
                
                this[i] = p | q
            }
        }
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public func bitshiftedRightUnchecked(words: Int, bits: Int) -> Self {
        var result = self; result.bitshiftRightUnchecked(words: words, bits: bits); return result
    }
}
