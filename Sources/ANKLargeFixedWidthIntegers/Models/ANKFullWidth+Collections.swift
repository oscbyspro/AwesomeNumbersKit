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

@usableFromInline protocol ANKFullWidthCollection: WoRdS {
    
    associatedtype High: AwesomeFixedWidthInteger
    
    associatedtype Low:  AwesomeUnsignedFixedWidthInteger where Low == Low.Magnitude
    
    typealias Body = ANKFullWidth<High, Low>
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
    
    @inlinable var partitionIndex: Int {
        Body.partitionIndex
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
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        assert((/*-----------*/     Body.endIndex) > index)
        assert((Body.startIndex ... Body.endIndex).contains(index))
        return index &+ 1
    }
    
    @inlinable func index(before index: Int) -> Int {
        assert((Body.startIndex     /*---------*/) < index)
        assert((Body.startIndex ... Body.endIndex).contains(index))
        return index &- 1
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        let next = index &+ distance
        assert((Body.startIndex ... Body.endIndex).contains(index))
        assert((Body.startIndex ... Body.endIndex).contains(next ))
        return next
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        assert((Body.startIndex ... Body.endIndex).contains(start))
        assert((Body.startIndex ... Body.endIndex).contains(end  ))
        return end &- start
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Collection
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable static var partitionIndex: Int {
        MemoryLayout<Low >.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable static var startIndex: Int {
        0
    }
    
    @inlinable static var endIndex: Int {
        count
    }
    
    @inlinable static var lastIndex: Int {
        count - 1
    }
    
    
    @inlinable static var indices: Range<Int> {
        0 ..< count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read { yield  withUnsafeWords({ $0[index] /*------*/ }) }
        @_transparent  set  { withUnsafeMutableWords({ $0[index] = newValue }) }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  withUnsafeWords({ $0[unchecked: index] /*------*/ }) }
        @_transparent  set  { withUnsafeMutableWords({ $0[unchecked: index] = newValue }) }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline func withUnsafeWords<T>(
    _ body: (UnsafeWordsBufferPointer) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { SELF in
            try body(UnsafeWordsBufferPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline mutating func withUnsafeMutableWords<T>(
    _ body: (UnsafeMutableWordsBufferPointer) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { SELF in
            try body(UnsafeMutableWordsBufferPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline static func fromUnsafeTemporaryWords(
    _ body: (UnsafeMutableWordsBufferPointer) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
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
                precondition(indices.contains(index))
                yield self[unchecked: index]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(indices.contains(index))
                #if _endian(big)
                yield base[lastIndex &- index]
                #else
                yield base[/*---------*/index]
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
                precondition(Body.indices.contains(index))
                yield  self[unchecked: index]
            }
            
            @_transparent nonmutating _modify {
                precondition(Body.indices.contains(index))
                yield &self[unchecked: index]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(Body.indices.contains(index))
                #if _endian(big)
                yield base[lastIndex &- index]
                #else
                yield base[/*---------*/index]
                #endif
            }
            
            @_transparent nonmutating _modify {
                assert(Body.indices.contains(index))
                #if _endian(big)
                yield &base[lastIndex &- index]
                #else
                yield &base[/*---------*/index]
                #endif
            }
        }
    }
}
