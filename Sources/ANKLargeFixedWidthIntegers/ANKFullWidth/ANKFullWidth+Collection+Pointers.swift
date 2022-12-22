//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Full Width x Collection x Pointers
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
                precondition(Body.indices.contains(index))
                yield self[unchecked: index]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(Body.indices.contains(index))
                #if _endian(big)
                yield self.base[Body.lastIndex &- index]
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
                yield self.base[Body.lastIndex &- index]
                #else
                yield self.base[/*--------------*/index]
                #endif
            }
            
            @_transparent nonmutating _modify {
                assert(Body.indices.contains(index))
                #if _endian(big)
                yield &self.base[Body.lastIndex &- index]
                #else
                yield &self.base[/*---------*/index]
                #endif
            }
        }
    }
}
