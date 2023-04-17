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
// MARK: * ANK x Full Width x Words
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var count: Int {
        assert(Self.bitWidth / UInt.bitWidth >= 2)
        assert(Self.bitWidth % UInt.bitWidth == 0)
        return Self.bitWidth / UInt.bitWidth
    }
    
    @inlinable public static var startIndex: Int {
        0
    }
    
    @inlinable public static var endIndex: Int {
        self.count
    }
    
    @inlinable public static var lastIndex: Int {
        self.count &- 1
    }
    
    @inlinable public static var indices: Range<Int> {
        0 ..< self.count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var count: Int {
        Self.count
    }
    
    @_transparent public var startIndex: Int {
        Self.startIndex
    }
    
    @_transparent public var endIndex: Int {
        Self.endIndex
    }
    
    @_transparent public var lastIndex: Int {
        Self.lastIndex
    }
    
    @_transparent public var indices: Range<Int> {
        Self.indices
    }
    
    @_transparent public var first: UInt {
        _read   { yield  self[unchecked: self.startIndex] }
        _modify { yield &self[unchecked: self.startIndex] }
    }
    
    @_transparent public var last: UInt {
        _read   { yield  self[unchecked: self.lastIndex] }
        _modify { yield &self[unchecked: self.lastIndex] }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var words: some ANKWords {
        self.bitPattern
    }
    
    /// The least significant word of this value.
    ///
    /// This is a top-secret™ requirement of [BinaryInteger][].
    ///
    /// []: https://github.com/apple/swift/blob/main/stdlib/public/core/Integers.swift
    ///
    @_transparent public var _lowWord: UInt {
        self.low._lowWord
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    public subscript(index: Int) -> UInt {
        @_transparent _read   { precondition(self.indices ~= index); yield  self[unchecked: index] }
        @_transparent _modify { precondition(self.indices ~= index); yield &self[unchecked: index] }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWords({ $0[index]            }) }
        @_transparent  set  { self.withUnsafeMutableWords({ $0[index] = newValue }) }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Min Two's Complement
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Returns this value's last index, in min two's complement form.
    ///
    /// ```swift
    /// Int256( 1).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: false)
    /// Int256( 0).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: true )
    /// Int256(-1).minLastIndexReportingIsZeroOrMinusOne() // (minLastIndex: 0, isZeroOrMinusOne: true )
    /// ```
    ///
    /// - Note: Using `isLessThanZero` is an efficient way to differentiate between `0` and `-1`.
    ///
    @inlinable public func minLastIndexReportingIsZeroOrMinusOne() -> (minLastIndex: Int, isZeroOrMinusOne: Bool) {
        let sign:  UInt = UInt(repeating: self.isLessThanZero)
        let index: Int? = self.withUnsafeWords({ SELF in SELF.lastIndex(where:{ word in word != sign }) })
        return index.map({( $0, false )}) ?? (0, true)
    }
    
    /// Returns this value's word count, in min two's complement form.
    ///
    /// ```swift
    /// Int256( 1).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: false)
    /// Int256( 0).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: true )
    /// Int256(-1).minWordCountReportingIsZeroOrMinusOne() // (minWordCount: 1, isZeroOrMinusOne: true )
    /// ```
    ///
    /// - Note: Using `isLessThanZero` is an efficient way to differentiate between `0` and `-1`.
    ///
    @inlinable public func minWordCountReportingIsZeroOrMinusOne() -> (minWordCount: Int, isZeroOrMinusOne: Bool) {
        let info = self.minLastIndexReportingIsZeroOrMinusOne()
        return (info.minLastIndex &+ 1, info.isZeroOrMinusOne)
    }
}
