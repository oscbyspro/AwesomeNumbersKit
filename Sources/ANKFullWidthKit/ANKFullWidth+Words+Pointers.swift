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
// MARK: * ANK x Full Width x Words x Pointers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    @_transparent public func withUnsafeWords<T>(_ body: (UnsafeWords) throws -> T) rethrows -> T {
        try self.withUnsafeUIntPointer({ try body(UnsafeWords($0)) })
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    @_transparent public mutating func withUnsafeMutableWords<T>(_ body: (UnsafeMutableWords) throws -> T) rethrows -> T {
        try self.withUnsafeMutableUIntPointer({ try body(UnsafeMutableWords($0)) })
    }
    
    /// Grants unsafe access to the integer's words, from least significant to most.
    @_transparent public static func fromUnsafeMutableWords(_ body: (UnsafeMutableWords) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: UInt.self, capacity: Self.count) { buffer in
            //=--------------------------------------=
            // de/init: pointee is trivial
            //=--------------------------------------=
            let base = buffer.baseAddress.unsafelyUnwrapped
            try body(UnsafeMutableWords(base))
            return UnsafeRawPointer(base).load(as: Self.self)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Trivial UInt Collection
    //=------------------------------------------------------------------------=
    
    /// Grants unsafe access to the collection's contiguous storage.
    ///
    /// The elements of the contiguous storage appear in the order of the collection.
    ///
    @inlinable public func withContiguousStorage<T>(_ body: (ANK.UnsafeWords) throws -> T) rethrows -> T {
        var base = self
        #if _endian(big)
        base.reverse()
        #endif
        return try base.withUnsafeUIntBufferPointer(body)
    }
        
    /// Grants unsafe access to the collection's contiguous storage.
    ///
    /// The elements of the contiguous storage appear in the order of the collection.
    ///
    /// - Note: This member is required by `Swift.Sequence`.
    ///
    @inlinable public func withContiguousStorageIfAvailable<T>(_ body: (ANK.UnsafeWords) throws -> T) rethrows -> T? {
        try self.withContiguousStorage(body)
    }
    
    /// Grants unsafe access to the collection's contiguous mutable storage.
    ///
    /// The elements of the contiguous mutable storage appear in the order of the collection.
    ///
    @inlinable public mutating func withContiguousMutableStorage<T>(_ body: (inout ANK.UnsafeMutableWords) throws -> T) rethrows -> T {
        #if _endian(big)
        do    { self.reverse() }
        defer { self.reverse() }
        #endif
        return try self.withUnsafeMutableUIntBufferPointer(body)
    }
    
    /// Grants unsafe access to the collection's contiguous mutable storage.
    ///
    /// The elements of the contiguous mutable storage appear in the order of the collection.
    ///
    /// - Note: This member is required by `Swift.MutableCollection`.
    ///
    @inlinable public mutating func withContiguousMutableStorageIfAvailable<T>(_ body: (inout ANK.UnsafeMutableWords) throws -> T) rethrows -> T? {
        try self.withContiguousMutableStorage(body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Trivial UInt Collection x Private
    //=------------------------------------------------------------------------=
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @inlinable func withUnsafeUIntPointer<T>(_  body: (UnsafePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { base in
            try base.withMemoryRebound(to: UInt.self, capacity: Self.count, body)
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @inlinable func withUnsafeUIntBufferPointer<T>(_ body: (ANK.UnsafeWords) throws -> T) rethrows -> T {
        try self.withUnsafeUIntPointer { base in
            try body(UnsafeBufferPointer(start: base, count: Self.count))
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @inlinable mutating func withUnsafeMutableUIntPointer<T>(_ body: (UnsafeMutablePointer<UInt>) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { base in
            try base.withMemoryRebound(to: UInt.self, capacity: Self.count, body)
        }
    }
    
    /// Grants unsafe access to the integer's in-memory representation.
    ///
    /// - Note: The order of the integer's words depends on the platform's endianness.
    ///
    @inlinable mutating func withUnsafeMutableUIntBufferPointer<T>(_ body: (inout ANK.UnsafeMutableWords) throws -> T) rethrows -> T {
        try self.withUnsafeMutableUIntPointer { base in
            var buffer = UnsafeMutableBufferPointer(start: base, count: Self.count);
            return try body(&buffer)
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Words x Pointers x Endianness Sensitive
//*============================================================================*

extension ANKFullWidth {
    
    //*========================================================================*
    // MARK: * Unsafe Words
    //*========================================================================*
    
    /// An unsafe words pointer.
    @frozen public struct UnsafeWords: RandomAccessCollection {
        
        //=------------------------------------------------------------------------=
        // MARK: State
        //=------------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafePointer<UInt>
        
        //=------------------------------------------------------------------------=
        // MARK: Initializers
        //=------------------------------------------------------------------------=
        
        @inlinable init(_ base: UnsafePointer<UInt>) {
            self.base = base
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        @inlinable public var count: Int {
            ANKFullWidth.count
        }
        
        @inlinable public var startIndex: Int {
            ANKFullWidth.startIndex
        }
        
        @inlinable public var lastIndex: Int {
            ANKFullWidth.lastIndex
        }
        
        @inlinable public var endIndex: Int {
            ANKFullWidth.endIndex
        }
        
        @inlinable public var indices: Range<Int> {
            ANKFullWidth.indices
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        /// The least significant word of this integer.
        @inlinable public var first: UInt {
            self[unchecked: self.startIndex]
        }
        
        /// The most significant word of this integer.
        @inlinable public var last: UInt {
            self[unchecked: self.lastIndex]
        }
        
        /// The most significant word of this integer, reinterpreted as a ``Digit``.
        @inlinable public var tail: Digit {
            Digit(bitPattern: self.last)
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        /// Accesses the word at the given index, from least significant to most.
        @inlinable public subscript(index: Int) -> UInt {
            precondition(self.indices ~= index, ANK.callsiteOutOfBoundsInfo())
            return self[unchecked: index]
        }
        
        /// Accesses the word at the given index, from least significant to most.
        ///
        /// - Warning: This subscript provides unchecked read and write access. Use
        ///   it only when you know the index is valid and that bounds-checking poses
        ///   significant performance problems.
        ///
        @inlinable public subscript(unchecked index: Int) -> UInt {
            self.base[ANKFullWidth.BitPattern.endiannessSensitiveIndex(unchecked: index)]
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
    }
    
    //*========================================================================*
    // MARK: * Unsafe Mutable Words
    //*========================================================================*
    
    /// An unsafe, mutable, words pointer.
    @frozen public struct UnsafeMutableWords: MutableCollection, RandomAccessCollection {
        
        //=------------------------------------------------------------------------=
        // MARK: State
        //=------------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafeMutablePointer<UInt>
        
        //=------------------------------------------------------------------------=
        // MARK: Initializers
        //=------------------------------------------------------------------------=
        
        @inlinable init(_ base: UnsafeMutablePointer<UInt>) {
            self.base = base
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        @inlinable public var count: Int {
            ANKFullWidth.count
        }
        
        @inlinable public var startIndex: Int {
            ANKFullWidth.startIndex
        }
        
        @inlinable public var lastIndex: Int {
            ANKFullWidth.lastIndex
        }
        
        @inlinable public var endIndex: Int {
            ANKFullWidth.endIndex
        }
        
        @inlinable public var indices: Range<Int> {
            ANKFullWidth.indices
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        /// The least significant word of this integer.
        @inlinable public var first: UInt {
            nonmutating get { self[unchecked: self.startIndex] }
            nonmutating set { self[unchecked: self.startIndex] = newValue }
        }
        
        /// The most significant word of this integer.
        @inlinable public var last: UInt {
            nonmutating get { self[unchecked: self.lastIndex] }
            nonmutating set { self[unchecked: self.lastIndex] = newValue }
        }
        
        /// The most significant word of this integer, reinterpreted as a ``Digit``.
        @inlinable public var tail: Digit {
            nonmutating get { Digit(bitPattern: self.last) }
            nonmutating set { self.last = UInt(bitPattern: newValue) }
        }
        
        //=------------------------------------------------------------------------=
        // MARK: Accessors
        //=------------------------------------------------------------------------=
        
        /// Accesses the word at the given index, from least significant to most.
        @inlinable public subscript(index: Int) -> UInt {
            nonmutating get {
                precondition(self.indices ~= index, ANK.callsiteOutOfBoundsInfo())
                return self[unchecked: index]
            }
            
            nonmutating set {
                precondition(self.indices ~= index, ANK.callsiteOutOfBoundsInfo())
                self[unchecked: index] = newValue
            }
        }
        
        /// Accesses the word at the given index, from least significant to most.
        ///
        /// - Warning: This subscript provides unchecked read and write access. Use
        ///   it only when you know the index is valid and that bounds-checking poses
        ///   significant performance problems.
        ///
        @inlinable public subscript(unchecked index: Int) -> UInt {
            nonmutating get {
                self.base[ANKFullWidth.BitPattern.endiannessSensitiveIndex(unchecked: index)]
            }
            
            nonmutating set {
                self.base[ANKFullWidth.BitPattern.endiannessSensitiveIndex(unchecked: index)] = newValue
            }
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
    }
}
