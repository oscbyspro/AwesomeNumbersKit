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
// MARK: * ANK x Full Width x Words x Pointers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public func withUnsafeWords<T>(
    _ body: (ANKUnsafeWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try self._withUnsafeUIntPointer {  START in
            try body(ANKUnsafeWordsPointer(START))
        }
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public mutating func withUnsafeMutableWords<T>(
    _ body: (ANKUnsafeMutableWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try self._withUnsafeMutableUIntPointer {  START in
            try body(ANKUnsafeMutableWordsPointer(START))
        }
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public static func fromUnsafeMutableWords(
    _ body: (ANKUnsafeMutableWordsPointer<BitPattern>) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { ALLOC in
            let SELF = ALLOC.baseAddress.unsafelyUnwrapped
            try SELF.withMemoryRebound(to: UInt.self, capacity: Self.count) { WORDS in
                try body(ANKUnsafeMutableWordsPointer(WORDS))
            }
            
            return SELF.pointee
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities x Contiguous UInt Sequence
    //=------------------------------------------------------------------------=
    
    @inlinable public func withContiguousStorageIfAvailable<T>(
    _ body: (UnsafeBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        var base: Self { self._wordSwapped }
        #else
        var base: Self { self }
        #endif
        return try base._withUnsafeUIntBufferPointer(body)
    }
    
    @inlinable public mutating func withContiguousMutableStorageIfAvailable<T>(
    _ body: (inout UnsafeMutableBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        do    { self = self._wordSwapped }
        defer { self = self._wordSwapped }
        #endif
        return try self._withUnsafeMutableUIntBufferPointer(body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities x Trivial UInt Collection
    //=------------------------------------------------------------------------=
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline func _withUnsafeUIntPointer<T>(
    _ body: (UnsafePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { START in
            try START.withMemoryRebound(to: UInt.self, capacity: Self.count, body)
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline func _withUnsafeUIntBufferPointer<T>(
    _ body: (UnsafeBufferPointer<UInt>) throws -> T) rethrows -> T {
        try self._withUnsafeUIntPointer { START in
            try body(UnsafeBufferPointer(start: START, count: Self.count))
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline mutating func _withUnsafeMutableUIntPointer<T>(
    _ body: (UnsafeMutablePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { START in
            try START.withMemoryRebound(to: UInt.self, capacity: Self.count, body)
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline mutating func _withUnsafeMutableUIntBufferPointer<T>(
    _ body: (inout UnsafeMutableBufferPointer<UInt>) throws -> T) rethrows -> T {
        try self._withUnsafeMutableUIntPointer { START in
            var BUFFER = UnsafeMutableBufferPointer<UInt>(start: START, count: Self.count)
            return try body(&BUFFER)
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Words x Pointers x Custom
//*============================================================================*

/// An internal, full width, unsafe words pointer.
///
/// ### Requirements
///
/// ```swift
/// MemoryLayout<Layout>.size / MemoryLayout<UInt>.size >= 2
/// MemoryLayout<Layout>.size % MemoryLayout<UInt>.size == 0
/// ```
///
@usableFromInline protocol ANKFullWidthUnsafeWordsPointer: RandomAccessCollection where Element == UInt, Index == Int {
    
    associatedtype Layout: ANKBitPatternConvertible<Layout>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKFullWidthUnsafeWordsPointer {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var count: Int {
        assert(MemoryLayout<Layout>.size / MemoryLayout<UInt>.size >= 2, "invalid memory layout")
        assert(MemoryLayout<Layout>.size % MemoryLayout<UInt>.size == 0, "invalid memory layout")
        return MemoryLayout<Layout>.size / MemoryLayout<UInt>.size
    }
    
    @inlinable static var startIndex: Int {
        0
    }
    
    @inlinable static var endIndex: Int {
        self.count
    }
    
    @inlinable static var lastIndex: Int {
        self.count &- 1
    }
    
    @inlinable static var indices: Range<Int> {
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
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public func distance(from start: Int, to end: Int) -> Int {
        assert(self.startIndex ... self.endIndex ~= start, ANK.callsiteIndexOutOfBoundsInfo())
        assert(self.startIndex ... self.endIndex ~= end  , ANK.callsiteIndexOutOfBoundsInfo())
        return end &- start
    }
    
    @inlinable public func index(after index: Int) -> Int {
        let value = index &+ 1
        assert(self.startIndex ... self.endIndex ~= index, ANK.callsiteIndexOutOfBoundsInfo())
        assert(self.startIndex ... self.endIndex ~= value, ANK.callsiteIndexOutOfBoundsInfo())
        return value  as Index
    }
    
    @inlinable public func index(before index: Int) -> Int {
        let value = index &- 1
        assert(self.startIndex ... self.endIndex ~= index, ANK.callsiteIndexOutOfBoundsInfo())
        assert(self.startIndex ... self.endIndex ~= value, ANK.callsiteIndexOutOfBoundsInfo())
        return value  as Index
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int) -> Int {
        let value = index &+ distance
        assert(self.startIndex ... self.endIndex ~= index, ANK.callsiteIndexOutOfBoundsInfo())
        assert(self.startIndex ... self.endIndex ~= value, ANK.callsiteIndexOutOfBoundsInfo())
        return value  as Index
    }
    
    @_transparent @usableFromInline func endianSensitiveIndex(_ index: Int) -> Int {
        assert(self.indices ~= index, ANK.callsiteIndexOutOfBoundsInfo())
        #if _endian(big)
        return self.lastIndex &- index
        #else
        return index
        #endif
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Words x Pointers x Custom x Read
//*============================================================================*

/// An unsafe words pointer.
///
/// - Warning: In addition to being unsafe, this collection also provides
///   unchecked subscript access and wrapping index arithmetic. So, don't
///   do stupid stuff. Understood? Cool. Let's go!
///
@frozen public struct ANKUnsafeWordsPointer<Layout>: ANKFullWidthUnsafeWordsPointer where Layout: ANKBitPatternConvertible<Layout> {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let base: UnsafePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(_ base: UnsafePointer<UInt>) {
        self.base = base
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var first: UInt {
        @_transparent get {
            self[self.startIndex]
        }
    }
    
    @inlinable public var last: UInt {
        @_transparent get {
            self[self.lastIndex]
        }
    }
    
    @inlinable public subscript(index: Int) -> UInt {
        @_transparent get {
            self.base[self.endianSensitiveIndex(index)]
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Words x Pointers x Custom x Read & Write
//*============================================================================*

/// An unsafe, mutable, words pointer.
///
/// - Warning: In addition to being unsafe, this collection also provides
///   unchecked subscript access and wrapping index arithmetic. So, don't
///   do stupid stuff. Understood? Cool. Let's go!
///
@frozen public struct ANKUnsafeMutableWordsPointer<Layout>: ANKFullWidthUnsafeWordsPointer where Layout: ANKBitPatternConvertible<Layout> {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let base: UnsafeMutablePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline init(_ base: UnsafeMutablePointer<UInt>) {
        self.base = base
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var first: UInt {
        @_transparent get {
            self[self.startIndex]
        }
        
        @_transparent nonmutating set {
            self[self.startIndex] = newValue
        }
    }
    
    @inlinable public var last: UInt {
        @_transparent get {
            self[self.lastIndex]
        }
        
        @_transparent nonmutating set {
            self[self.lastIndex] = newValue
        }
    }
    
    @inlinable public subscript(index: Int) -> UInt {
        @_transparent get {
            self.base[self.endianSensitiveIndex(index)]
        }
        
        @_transparent nonmutating set {
            self.base[self.endianSensitiveIndex(index)] = newValue
        }
    }
}
