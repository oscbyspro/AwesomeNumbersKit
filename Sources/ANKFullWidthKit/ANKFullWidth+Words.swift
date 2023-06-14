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
// MARK: * ANK x Full Width x Words
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: Self {
        _read { yield self }
    }
    
    /// The least significant word of this value.
    ///
    /// - Note: This member is required by `Swift.BinaryInteger.
    ///
    @inlinable public var _lowWord: UInt {
        self.low._lowWord
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Collection
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var count: Int {
        assert(MemoryLayout<Self>.size / MemoryLayout<UInt>.stride >= 2)
        assert(MemoryLayout<Self>.size % MemoryLayout<UInt>.stride == 0)
        return MemoryLayout<Self>.size / MemoryLayout<UInt>.stride
    }
    
    @inlinable public static var startIndex: Int {
        0
    }
    
    @inlinable public static var endIndex: Int {
        self.count
    }
    
    @inlinable public static var lastIndex: Int {
        self.count - 1
    }
    
    @inlinable public static var indices: Range<Int> {
        0 ..< self.count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var count: Int {
        Self.count
    }
    
    @inlinable public var startIndex: Int {
        Self.startIndex
    }
    
    @inlinable public var endIndex: Int {
        Self.endIndex
    }
    
    @inlinable public var lastIndex: Int {
        Self.lastIndex
    }
    
    @inlinable public var indices: Range<Int> {
        Self.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// The least significant word of this integer.
    @inlinable public var first: UInt {
        get { self.withUnsafeWords({/*---*/ $0.first /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0.first = newValue }) }
    }
    
    /// The most significant word of this integer.
    @inlinable public var last: UInt {
        get { self.withUnsafeWords({/*---*/ $0.last /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0.last = newValue }) }
    }
    
    /// The most significant word of this integer, reinterpreted as a ``Digit``.
    @inlinable public var tail: Digit {
        get { self.withUnsafeWords({/*---*/ $0.tail /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0.tail = newValue }) }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Accesses the word at the given index, from least significant to most.
    @inlinable public subscript(index: Int) -> UInt {
        get { self.withUnsafeWords({/*---*/ $0[index] /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0[index] = newValue }) }
    }
    
    /// Accesses the word at the given index, from least significant to most.
    ///
    /// - Warning: This subscript provides unchecked read and write access. Use
    ///   it only when you know the index is valid and that bounds-checking poses
    ///   significant performance problems.
    ///
    @inlinable public subscript(unchecked index: Int) -> UInt {
        get { self.withUnsafeWords({/*---*/ $0[unchecked: index] /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0[unchecked: index] = newValue }) }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities x Private
    //=------------------------------------------------------------------------=
    
    @inlinable static func endiannessSensitiveIndex(unchecked index: Int) -> Int {
        assert(self.indices ~= index, ANK.callsiteIndexOutOfBoundsInfo())
        #if _endian(big)
        return self.lastIndex - index
        #else
        return index
        #endif
    }
}
