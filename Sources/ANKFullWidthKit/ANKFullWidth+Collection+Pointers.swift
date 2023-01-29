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
// MARK: * ANK x Full Width x Collection x Pointers
//*============================================================================*

/// An internal, full width, unsafe words pointer protocol.
///
/// **Requirements**
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
        self.count - 1
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
        assert((/*-----------*/     self.endIndex) > index)
        assert((self.startIndex ... self.endIndex).contains(index))
        return index &+ 1
    }
    
    @inlinable public func index(before index: Int) -> Int {
        assert((self.startIndex     /*---------*/) < index)
        assert((self.startIndex ... self.endIndex).contains(index))
        return index &- 1
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int) -> Int {
        let next = index &+ distance
        assert((self.startIndex ... self.endIndex).contains(index))
        assert((self.startIndex ... self.endIndex).contains(next ))
        return next
    }
    
    @inlinable public func distance(from start: Int, to end: Int) -> Int {
        assert((self.startIndex ... self.endIndex).contains(start))
        assert((self.startIndex ... self.endIndex).contains(end  ))
        return end &- start
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Collection x Pointers x Words
//*============================================================================*

/// An unsafe words pointer.
///
/// - Warning: In addition to being unsafe, this collection also provides
///   unchecked subscript access and wrapping index arithmetic. So, don't
///   do stupid stuff. Understood? Cool. Let's go!
///
@frozen public struct UnsafeWordsPointer<Layout>: ANKFullWidthUnsafeWordsPointer where Layout: ANKBitPatternConvertible<Layout> {
    
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
            assert(self.indices.contains(index))
            #if _endian(big)
            yield self.base[self.lastIndex &- index]
            #else
            yield self.base[index]
            #endif
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Collection x Pointers x Words x Mutable
//*============================================================================*

/// An unsafe, mutable, words pointer.
///
/// - Warning: In addition to being unsafe, this collection also provides
///   unchecked subscript access and wrapping index arithmetic. So, don't
///   do stupid stuff. Understood? Cool. Let's go!
///
@frozen public struct UnsafeMutableWordsPointer<Layout>: ANKFullWidthUnsafeWordsPointer where Layout: ANKBitPatternConvertible<Layout> {
        
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
            assert(self.indices.contains(index))
            #if _endian(big)
            yield self.base[self.lastIndex &- index]
            #else
            yield self.base[index]
            #endif
        }
        
        @_transparent nonmutating _modify {
            assert(self.indices.contains(index))
            #if _endian(big)
            yield &self.base[self.lastIndex &- index]
            #else
            yield &self.base[index]
            #endif
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Collection x Pointers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public func withUnsafeWordsPointer<T>(
    _ body: (UnsafeWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) {  SELF in
            try SELF.withMemoryRebound(to: UInt.self, capacity: Self.count) { WORDS in
                try body(UnsafeWordsPointer(WORDS))
            }
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public mutating func withUnsafeMutableWordsPointer<T>(
    _ body: (UnsafeMutableWordsPointer<BitPattern>) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { SELF in
            try SELF.withMemoryRebound(to: UInt.self, capacity: Self.count) { WORDS in
                try body(UnsafeMutableWordsPointer(WORDS))
            }
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    ///
    /// - Warning: In addition to being unsafe, this collection also provides
    ///   unchecked subscript access and wrapping index arithmetic. So, don't
    ///   do stupid stuff. Understood? Cool. Let's go!
    ///
    @_transparent public static func fromUnsafeMutableWordsAllocation(
    _ body: (UnsafeMutableWordsPointer<BitPattern>) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try SELF.withMemoryRebound(to: UInt.self, capacity: Self.count) { WORDS in
                try body(UnsafeMutableWordsPointer(WORDS))
            }
            
            return SELF.pointee
        }
    }
}
