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
    
    /// The number of words.
    @inlinable public static var count: Int {
        assert(MemoryLayout<Self>.size / MemoryLayout<UInt>.stride >= 2)
        assert(MemoryLayout<Self>.size % MemoryLayout<UInt>.stride == 0)
        return MemoryLayout<Self>.size / MemoryLayout<UInt>.stride
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var count: Int {
        Self.count
    }
    
    @inlinable public var words: Self {
        _read { yield self }
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Collection x Indices
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// The index of the least significant word.
    @inlinable public static var startIndex: Int {
        0
    }
    
    /// The index of the most significant word.
    @inlinable public static var lastIndex: Int {
        self.count - 1
    }
    
    /// The index after the last valid subscript argument.
    @inlinable public static var endIndex: Int {
        self.count
    }
    
    /// A collection of every valid subscript argument, in ascending order.
    @inlinable public static var indices: Range<Int> {
        0 ..< self.count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var startIndex: Int {
        Self.startIndex
    }
    
    @inlinable public var lastIndex: Int {
        Self.lastIndex
    }
    
    @inlinable public var endIndex: Int {
        Self.endIndex
    }
    
    @inlinable public var indices: Range<Int> {
        Self.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func distance(from start: Int, to end: Int) -> Int {
        ANKFullWidth.distance(from: start, to: end)
    }
    
    @inlinable public func index(after index: Int) -> Int {
        ANKFullWidth.index(after: index)
    }
    
    @inlinable public func formIndex(after index: inout Int) {
        ANKFullWidth.formIndex(after: &index)
    }
    
    @inlinable public func index(before index: Int) -> Int {
        ANKFullWidth.index(before: index)
    }
    
    @inlinable public func formIndex(before index: inout Int) {
        ANKFullWidth.formIndex(before: &index)
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int) -> Int {
        ANKFullWidth.index(index, offsetBy: distance)
    }
    
    @inlinable public func index(_ index: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        ANKFullWidth.index(index, offsetBy: distance, limitedBy: limit)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities x Private
    //=------------------------------------------------------------------------=
    
    @inlinable static func distance(from start: Int, to end: Int) -> Int {
        end - start
    }
    
    @inlinable static func index(after index: Int) -> Int {
        index +  1
    }
    
    @inlinable static func formIndex(after index: inout Int) {
        index += 1
    }
    
    @inlinable static func index(before index: Int) -> Int {
        index -  1
    }
    
    @inlinable static func formIndex(before index: inout Int) {
        index -= 1
    }
    
    @inlinable static func index(_ index: Int, offsetBy distance: Int) -> Int {
        index + distance
    }
    
    @inlinable static func index(_ index: Int, offsetBy distance: Int, limitedBy limit: Int) -> Int? {
        let distanceLimit: Int = self.distance(from: index, to: limit)
        
        guard distance >= 0
        ? distance <= distanceLimit || distanceLimit < 0
        : distance >= distanceLimit || distanceLimit > 0
        else { return nil }
        
        return self.index(index, offsetBy: distance) as Int
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Collection x Elements
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// The least significant word.
    ///
    /// - Note: This member is required by `Swift.BinaryInteger`.
    ///
    @inlinable public var _lowWord: UInt {
        self.low._lowWord // same as first
    }
    
    /// The least significant word.
    @inlinable public var first: UInt {
        get { self.withUnsafeWords({/*---*/ $0.first /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0.first = newValue }) }
    }
    
    /// The most significant word.
    @inlinable public var last: UInt {
        get { self.withUnsafeWords({/*---*/ $0.last /*------*/ }) }
        set { self.withUnsafeMutableWords({ $0.last = newValue }) }
    }
    
    /// The most significant word, reinterpreted as a ``Digit``.
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
        assert(self.indices ~= index, ANK.callsiteOutOfBoundsInfo())
        #if _endian(big)
        return self.lastIndex - index
        #else
        return index
        #endif
    }
}
