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
    @_transparent public func withUnsafeWords<T>(_ body: (ANKUnsafeWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try self._withUnsafeUIntPointer({ try body(ANKUnsafeWordsPointer($0)) })
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public mutating func withUnsafeMutableWords<T>(_ body: (ANKUnsafeMutableWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try self._withUnsafeMutableUIntPointer({ try body(ANKUnsafeMutableWordsPointer($0)) })
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public static func fromUnsafeMutableWords(_ body: (ANKUnsafeMutableWordsPointer<BitPattern>) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try SELF.withMemoryRebound(to: UInt.self, capacity: Self.count) { WORDS in
                try body(ANKUnsafeMutableWordsPointer(WORDS))
            }
            
            return SELF.pointee
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities x Contiguous Sequence
    //=------------------------------------------------------------------------=
    
    @inlinable public func withContiguousStorageIfAvailable<T>(_ body: (UnsafeBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        var base: Self { self.wordSwapped }
        #else
        var base: Self { self }
        #endif
        return try base._withUnsafeUIntBufferPointer(body)
    }
    
    @inlinable public mutating func withContiguousMutableStorageIfAvailable<T>(_ body: (inout UnsafeMutableBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        do    { self = self.wordSwapped }
        defer { self = self.wordSwapped }
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
    @_transparent @usableFromInline func _withUnsafeUIntPointer<T>(_ body: (UnsafePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { try $0.withMemoryRebound(to: UInt.self, capacity: Self.count) { try body($0) } }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline func _withUnsafeUIntBufferPointer<T>(_ body: (UnsafeBufferPointer<UInt>) throws -> T) rethrows -> T {
        try self._withUnsafeUIntPointer({ try body(UnsafeBufferPointer(start: $0, count: Self.count)) })
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline mutating func _withUnsafeMutableUIntPointer<T>(_ body: (UnsafeMutablePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { try $0.withMemoryRebound(to: UInt.self, capacity: Self.count) { try body($0) } }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @_transparent @usableFromInline mutating func _withUnsafeMutableUIntBufferPointer<T>(_ body: (inout UnsafeMutableBufferPointer<UInt>) throws -> T) rethrows -> T {
        try self._withUnsafeMutableUIntPointer({ var x = UnsafeMutableBufferPointer<UInt>(start: $0, count: Self.count); return try body(&x) })
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Words x Pointers x Custom
//*============================================================================*

/// An internal, full width, unsafe words pointer protocol.
///
/// ### Requirements
///
/// ```
/// MemoryLayout<Layout>.size / MemoryLayout<UInt>.size >= 1
/// MemoryLayout<Layout>.size % MemoryLayout<UInt>.size == 0
/// ```
///
@usableFromInline protocol ANKFullWidthUnsafeWordsPointer: ANKWords {
    
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
        assert(MemoryLayout<Layout>.size / MemoryLayout<UInt>.size >= 1)
        assert(MemoryLayout<Layout>.size % MemoryLayout<UInt>.size == 0)
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
    
    @inlinable public func index(after index: Int) -> Int {
        let value = index &+ 1
        assert(self.startIndex ... self.endIndex ~= index)
        assert(self.startIndex ... self.endIndex ~= value)
        return value  as Index
    }
    
    @inlinable public func index(before index: Int) -> Int {
        let value = index &- 1
        assert(self.startIndex ... self.endIndex ~= index)
        assert(self.startIndex ... self.endIndex ~= value)
        return value  as Index
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int) -> Int {
        let value = index &+ distance
        assert(self.startIndex ... self.endIndex ~= index)
        assert(self.startIndex ... self.endIndex ~= value)
        return value  as Index
    }
    
    @inlinable public func distance(from start: Int, to end: Int) -> Int {
        assert(self.startIndex ... self.endIndex ~= start)
        assert(self.startIndex ... self.endIndex ~= end  )
        return end &- start
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
    
    public let base: UnsafePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ base: UnsafePointer<UInt>) {
        self.base = base
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    public subscript(index: Int) -> UInt {
        @_transparent _read {
            assert(self.indices ~= index)
            #if _endian(big)
            yield self.base[self.lastIndex &- index]
            #else
            yield self.base[index]
            #endif
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
    
    public let base: UnsafeMutablePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ base: UnsafeMutablePointer<UInt>) {
        self.base = base
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    public subscript(index: Int) -> UInt {
        @_transparent _read {
            assert(self.indices ~= index)
            #if _endian(big)
            yield self.base[self.lastIndex &- index]
            #else
            yield self.base[index]
            #endif
        }
        
        @_transparent nonmutating _modify {
            assert(self.indices ~= index)
            #if _endian(big)
            yield &self.base[self.lastIndex &- index]
            #else
            yield &self.base[index]
            #endif
        }
    }
}
