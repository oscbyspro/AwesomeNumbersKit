//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Pointers
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func withUnsafeWords<T>(
    _ operation: (UnsafeWords) throws -> T) rethrows -> T {
        try withUnsafePointer(to:   self) { SELF in
            let WORDS = UnsafeWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableWords<T>(
    _ operation: (UnsafeMutableWords) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to:  &self) { SELF in
            let WORDS = UnsafeMutableWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline static func fromUnsafeWordsAllocation(
    _ operation: (UnsafeMutableWords) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF  = BUFFER.baseAddress!
            let WORDS = UnsafeMutableWords(SELF)
            try operation(WORDS)
            return SELF.pointee
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeWords: OBEFullWidthCollection {
                
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
                yield base[Body.littleEndianIndex(index)]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(indices.contains(index))
                yield base[Body.littleEndianIndex(index)]
            }
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words x Mutable
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeMutableWords: OBEFullWidthCollection {
        
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
                precondition(indices.contains(index))
                yield  base[Body.littleEndianIndex(index)]
            }
            
            @_transparent nonmutating _modify {
                precondition(indices.contains(index))
                yield &base[Body.littleEndianIndex(index)]
            }
        }
        
        @usableFromInline subscript(unchecked index: Int) -> UInt {
            @_transparent _read {
                assert(indices.contains(index))
                yield  base[Body.littleEndianIndex(index)]
            }
            
            @_transparent nonmutating _modify {
                assert(indices.contains(index))
                yield &base[Body.littleEndianIndex(index)]
            }
        }
    }
}
