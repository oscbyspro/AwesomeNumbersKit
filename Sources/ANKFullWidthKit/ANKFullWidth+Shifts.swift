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
// MARK: * ANK x Full Width x Shifts x Left
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
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.bitshiftLeft(by: rhs.moduloBitWidth(of: Self.self))
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
    ///   - distance: `Int.min <= distance <= Int.max`
    ///
    @inlinable public mutating func bitshiftLeftSmart(by distance: Int) {
        let size = distance.magnitude as UInt
        switch (distance >= 0, size < UInt(bitPattern: Self.bitWidth)) {
        case (true,  true ): self.bitshiftLeft (by: Int(bitPattern: size))
        case (true,  false): self = Self(repeating: false)
        case (false, true ): self.bitshiftRight(by: Int(bitPattern: size))
        case (false, false): self = Self(repeating: self.isLessThanZero) }
    }
    
    /// Performs a smart left shift.
    ///
    /// - Parameters:
    ///   - distance: `Int.min <= distance <= Int.max`
    ///
    @inlinable public func bitshiftedLeftSmart(by distance: Int) -> Self {
        var result = self; result.bitshiftLeftSmart(by: distance); return result
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - distance: `0 <= distance < Self.bitWidth`
    ///
    @inlinable public mutating func bitshiftLeft(by distance: Int) {
        precondition(distance >= 0, "shift distance must be at least zero")
        let major  = distance .quotientDividingByBitWidthAssumingIsAtLeastZero()
        let minor  = distance.remainderDividingByBitWidthAssumingIsAtLeastZero()
        return self.bitshiftLeft(words: major, bits: minor)
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - distance: `0 <= distance < Self.bitWidth`
    ///
    @inlinable public func bitshiftedLeft(by distance: Int) -> Self {
        var result = self; result.bitshiftLeft(by: distance); return result
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public mutating func bitshiftLeft(words: Int, bits: Int) {
        precondition(0 ..< self.endIndex ~= words, "invalid major shift distance")
        precondition(0 ..< UInt.bitWidth ~= bits,  "invalid minor shift distance")
        //=--------------------------------------=
        if  bits.isZero {
            return self.bitshiftLeft(words: words)
        }
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth - bits)
        //=--------------------------------------=
        var x = self.distance(from: words, to: self.lastIndex)
        var y = self[x] as UInt
        //=--------------------------------------=
        for i in stride(from: self.lastIndex, to: -1, by: -1) {
            let p = y &<< a
            
            x = x  - 1
            y = x >= self.startIndex ? self[x] : 0
            
            let q = y &>> b
            self[i] = p | q
        }
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public func bitshiftedLeft(words: Int, bits: Int) -> Self {
        var result = self; result.bitshiftLeft(words: words, bits: bits); return result
    }
        
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///
    @inlinable public mutating func bitshiftLeft(words: Int) {
        precondition(0 ..< self.endIndex ~= words, "invalid major shift distance")
        //=--------------------------------------=
        guard words > Int.zero else { return }
        //=--------------------------------------=
        for i in self.indices.reversed() {
            self[i] = i >= words ? self[i - words] : 0
        }
    }
    
    /// Performs an unchecked left shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///
    @inlinable public func bitshiftedLeft(words: Int) -> Self {
        var result = self; result.bitshiftLeft(words: words); return result
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Shifts x Right
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
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.bitshiftRight(by: rhs.moduloBitWidth(of: Self.self))
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
    ///   - distance: `Int.min <= distance <= Int.max`
    ///
    @inlinable public mutating func bitshiftRightSmart(by distance: Int) {
        let size = distance.magnitude as UInt
        switch (distance >= 0, size < UInt(bitPattern: Self.bitWidth)) {
        case (true,  true ): self.bitshiftRight(by: Int(bitPattern: size))
        case (true,  false): self = Self(repeating: self.isLessThanZero)
        case (false, true ): self.bitshiftLeft (by: Int(bitPattern: size))
        case (false, false): self = Self(repeating: false) }
    }
    
    /// Performs a smart, signed, right shift.
    ///
    /// - Parameters:
    ///   - distance: `Int.min <= distance <= Int.max`
    ///
    @inlinable public func bitshiftedRightSmart(by distance: Int) -> Self {
        var result = self; result.bitshiftRightSmart(by: distance); return result
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - distance: `0 <= distance < Self.bitWidth`
    ///
    @inlinable public mutating func bitshiftRight(by distance: Int) {
        precondition(distance >= 0, "shift distance must be at least zero")
        let major =  distance .quotientDividingByBitWidthAssumingIsAtLeastZero()
        let minor =  distance.remainderDividingByBitWidthAssumingIsAtLeastZero()
        return self.bitshiftRight(words: major, bits: minor)
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - distance: `0 <= distance < Self.bitWidth`
    ///
    @inlinable public func bitshiftedRight(by distance: Int) -> Self {
        var result = self; result.bitshiftRight(by: distance); return result
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public mutating func bitshiftRight(words: Int, bits: Int) {
        precondition(0 ..< self.endIndex ~= words, "invalid major shift distance")
        precondition(0 ..< UInt.bitWidth ~= bits,  "invalid minor shift distance")
        //=--------------------------------------=
        if  bits.isZero {
            return self.bitshiftRight(words: words)
        }
        //=--------------------------------------=
        let a = UInt(bitPattern: bits)
        let b = UInt(bitPattern: UInt.bitWidth - bits)
        let s = UInt(repeating:  self.isLessThanZero )
        //=--------------------------------------=
        var x = (words) as  Int
        var y = self[x] as UInt
        //=--------------------------------------=
        for i in self.indices {
            let p = y &>> a
            
            x = x + 1
            y = x < self.endIndex ? self[x] : s
            
            let q = y &<< b
            self[i] = p | q
        }
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///   - bits:  `0 <= bits  < UInt.bitWidth`
    ///
    @inlinable public func bitshiftedRight(words: Int, bits: Int) -> Self {
        var result = self; result.bitshiftRight(words: words, bits: bits); return result
    }
        
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///
    @inlinable public mutating func bitshiftRight(words: Int) {
        precondition(0 ..< self.endIndex ~= words, "invalid major shift distance")
        //=--------------------------------------=
        if words.isZero { return }
        //=--------------------------------------=
        let s = UInt(repeating: self.isLessThanZero)
        let e = self.endIndex - words
        //=--------------------------------------=
        for i in self.indices {
            self[i] = (i < e) ? self[i + words] : s
        }
    }
    
    /// Performs an unchecked, signed, right shift.
    ///
    /// - Parameters:
    ///   - words: `0 <= words < Self.endIndex`
    ///
    @inlinable public func bitshiftedRight(words: Int) -> Self {
        var result = self; result.bitshiftRight(words: words); return result
    }
}
