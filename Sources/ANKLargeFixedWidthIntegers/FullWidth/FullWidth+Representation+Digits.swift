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
// MARK: * ANK x Full Width x Digits
//*============================================================================*

@usableFromInline protocol ANKFullWidthCollection: WoRdS where
High.Digit: AwesomeIntOrUInt, High.Magnitude.Digit == UInt {
    
    associatedtype High: AwesomeLargeFixedWidthInteger
    
    associatedtype Low:  AwesomeUnsignedLargeFixedWidthInteger<UInt> where Low == Low.Magnitude
    
    typealias Body = ANKFullWidth<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable subscript(unchecked index: Int) -> UInt { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKFullWidthCollection {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var count: Int {
        Body.count
    }
    
    @inlinable var startIndex: Int {
        Body.startIndex
    }
    
    @inlinable var endIndex: Int {
        Body.endIndex
    }
    
    @inlinable var lastIndex: Int {
        Body.lastIndex
    }
    
    @inlinable var indices: Range<Int> {
        Body.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var first: UInt {
        self[unchecked: self.startIndex]
    }
    
    @inlinable var last: UInt {
        self[unchecked: self.lastIndex]
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        assert((/*-----------*/     self.endIndex) > index)
        assert((self.startIndex ... self.endIndex).contains(index))
        return index &+ 1
    }
    
    @inlinable func index(before index: Int) -> Int {
        assert((self.startIndex     /*---------*/) < index)
        assert((self.startIndex ... self.endIndex).contains(index))
        return index &- 1
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        let next = index &+ distance
        assert((self.startIndex ... self.endIndex).contains(index))
        assert((self.startIndex ... self.endIndex).contains(next ))
        return next
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        assert((self.startIndex ... self.endIndex).contains(start))
        assert((self.startIndex ... self.endIndex).contains(end  ))
        return end &- start
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Digits
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
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
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWords({ $0[index] /*------*/ }) }
        @_transparent  set  { self.withUnsafeMutableWords({ $0[index] = newValue }) }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWords({ $0[unchecked: index] /*------*/ }) }
        @_transparent  set  { self.withUnsafeMutableWords({ $0[unchecked: index] = newValue }) }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Digits x Pointers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline func withUnsafeWords<T>(
    _ body: (UnsafeWordsBufferPointer) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) { SELF in
            try body(UnsafeWordsBufferPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline mutating func withUnsafeMutableWords<T>(
    _ body: (UnsafeMutableWordsBufferPointer) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { SELF in
            try body(UnsafeMutableWordsBufferPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline static func fromUnsafeTemporaryWords(
    _ body: (UnsafeMutableWordsBufferPointer) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try body(UnsafeMutableWordsBufferPointer(SELF))
            return SELF.pointee
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words Buffer Pointer
    //*========================================================================*
    
    @frozen @usableFromInline struct UnsafeWordsBufferPointer: ANKFullWidthCollection {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafePointer<UInt>
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(_ BODY: UnsafePointer<Body>) {
            self.base = UnsafeRawPointer(BODY).assumingMemoryBound(to: UInt.self)
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @usableFromInline subscript(index: Int) -> UInt {
            @_transparent _read {
                precondition(self.indices.contains(index))
                yield self[unchecked: index]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(self.indices.contains(index))
                #if _endian(big)
                yield self.base[self.lastIndex &- index]
                #else
                yield self.base[/*--------------*/index]
                #endif
            }
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words Buffer Pointer x Mutable
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeMutableWordsBufferPointer: ANKFullWidthCollection {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafeMutablePointer<UInt>
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(_ BODY: UnsafeMutablePointer<Body>) {
            self.base = UnsafeMutableRawPointer(BODY).assumingMemoryBound(to: UInt.self)
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @usableFromInline subscript(index: Int) -> UInt {
            @_transparent _read {
                precondition(self.indices.contains(index))
                yield  self[unchecked: index]
            }
            
            @_transparent nonmutating _modify {
                precondition(self.indices.contains(index))
                yield &self[unchecked: index]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(self.indices.contains(index))
                #if _endian(big)
                yield self.base[self.lastIndex &- index]
                #else
                yield self.base[/*--------------*/index]
                #endif
            }
            
            @_transparent nonmutating _modify {
                assert(self.indices.contains(index))
                #if _endian(big)
                yield &self.base[self.lastIndex &- index]
                #else
                yield &self.base[/*--------------*/index]
                #endif
            }
        }
    }
}
