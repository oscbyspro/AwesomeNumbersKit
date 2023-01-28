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
// MARK: * ANK x Full Width x Collection
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var count: Int {
        assert(Self.bitWidth / UInt.bitWidth >= 1)
        assert(Self.bitWidth % UInt.bitWidth == 0)
        return Self.bitWidth / UInt.bitWidth
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
    
    @_transparent public var first: UInt {
        self[unchecked: self.startIndex]
    }
    
    @_transparent public var last: UInt {
        self[unchecked: self.lastIndex]
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWordsPointer({ $0[index] /*------*/ }) }
        @_transparent  set  { self.withUnsafeMutableWordsPointer({ $0[index] = newValue }) }
    }
    
    public subscript(index: Int) -> UInt {
        @_transparent _read { precondition(self.indices.contains(index)); yield self[unchecked: index] /*------*/ }
        @_transparent  set  { precondition(self.indices.contains(index)); /*-*/ self[unchecked: index] = newValue }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Contiguous Bytes
    //=------------------------------------------------------------------------=
    
    @_transparent public func withUnsafeBytes<T>(_ body: (UnsafeRawBufferPointer) throws -> T) rethrows -> T {
        try Swift.withUnsafeBytes(of: self, body)
    }
}
