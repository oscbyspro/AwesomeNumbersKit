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
    
    @_transparent @usableFromInline func withUnsafeBigEndianWords<T>(
    _ operation: (UnsafeBigEndianWords) throws -> T) rethrows -> T {
        try withUnsafePointer(to:   self) { SELF in
            let WORDS = UnsafeBigEndianWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline func withUnsafeLittleEndianWords<T>(
    _ operation: (UnsafeLittleEndianWords) throws -> T) rethrows -> T {
        try withUnsafePointer(to:   self) { SELF in
            let WORDS = UnsafeLittleEndianWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableBigEndianWords<T>(
    _ operation: (UnsafeMutableBigEndianWords) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to:  &self) { SELF in
            let WORDS = UnsafeMutableBigEndianWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableLittleEndianWords<T>(
    _ operation: (UnsafeMutableLittleEndianWords) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to:  &self) { SELF in
            let WORDS = UnsafeMutableLittleEndianWords(SELF)
            return  try operation(WORDS)
        }
    }
    
    @_transparent @usableFromInline static func fromUnsafeBigEndianWordsAllocation(
    _ operation: (UnsafeMutableBigEndianWords) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF  = BUFFER.baseAddress!
            let WORDS = UnsafeMutableBigEndianWords(SELF)
            try operation(WORDS)
            return SELF.pointee
        }
    }
    
    @_transparent @usableFromInline static func fromUnsafeLittleEndianWordsAllocation(
    _ operation: (UnsafeMutableLittleEndianWords) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF  = BUFFER.baseAddress!
            let WORDS = UnsafeMutableLittleEndianWords(SELF)
            try operation(WORDS)
            return SELF.pointee
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words x Big Endian
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeBigEndianWords: OBEFullWidthCollection {
                
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
                yield base[Body.bigEndianIndex(index)]
            }
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words x Big Endian x Mutable
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeMutableBigEndianWords: OBEFullWidthCollection {
        
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
                yield  base[Body.bigEndianIndex(index)]
            }
            
            @_transparent nonmutating _modify {
                assert(Body.indices.contains(index))
                yield &base[Body.bigEndianIndex(index)]
            }
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words x Little Endian
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeLittleEndianWords: OBEFullWidthCollection {
                
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
                yield base[Body.littleEndianIndex(index)]
            }
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words x Little Endian x Mutable
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeMutableLittleEndianWords: OBEFullWidthCollection {
        
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
                yield  base[Body.littleEndianIndex(index)]
            }
            
            @_transparent nonmutating _modify {
                assert(Body.indices.contains(index))
                yield &base[Body.littleEndianIndex(index)]
            }
        }
    }
}
