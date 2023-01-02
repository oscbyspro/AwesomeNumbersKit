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

@usableFromInline protocol _ANKFullWidthUnsafeWordsPointer: WoRdS where
Low == Low.Magnitude, High.Digit: ANKIntOrUInt, High.Magnitude.Digit == UInt {
    
    associatedtype High: ANKLargeFixedWidthInteger & ANKTwosComplement
    
    associatedtype Low:  ANKUnsignedLargeFixedWidthInteger<UInt> & ANKTwosComplement
    
    typealias Layout = ANKFullWidth<High, Low>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension _ANKFullWidthUnsafeWordsPointer {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var count: Int {
        Layout.count
    }
    
    @_transparent public var startIndex: Int {
        Layout.startIndex
    }
    
    @_transparent public var endIndex: Int {
        Layout.endIndex
    }
    
    @_transparent public var lastIndex: Int {
        Layout.lastIndex
    }
    
    @_transparent public var indices: Range<Int> {
        Layout.indices
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
// MARK: * ANK x Full Width x Collection x Unsafe Buffer Pointers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline func withUnsafeWordsPointer<T>(
    _ body: (UnsafeWordsPointer) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) { SELF in
            try body(UnsafeWordsPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline mutating func withUnsafeMutableWordsPointer<T>(
    _ body: (UnsafeMutableWordsPointer) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { SELF in
            try body(UnsafeMutableWordsPointer(SELF))
        }
    }
    
    /// Unsafe access to the integer's words, in order from least significant to most.
    @_transparent @usableFromInline static func fromUnsafeMutableWordsAllocation(
    _ body: (UnsafeMutableWordsPointer) throws -> Void) rethrows -> Self {
        try withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try body(UnsafeMutableWordsPointer(SELF))
            return SELF.pointee
        }
    }
    
    //*========================================================================*
    // MARK: * Unsafe Words Buffer Pointer
    //*========================================================================*
    
    @frozen @usableFromInline struct UnsafeWordsPointer: _ANKFullWidthUnsafeWordsPointer {
                
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafePointer<UInt>
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(_ LAYOUT: UnsafePointer<Layout>) {
            self.base = UnsafeRawPointer(LAYOUT).assumingMemoryBound(to: UInt.self)
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @usableFromInline subscript(index: Int) -> UInt {
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
    
    //*========================================================================*
    // MARK: * Unsafe Words Buffer Pointer x Mutable
    //*========================================================================*
 
    @frozen @usableFromInline struct UnsafeMutableWordsPointer: _ANKFullWidthUnsafeWordsPointer {
        
        //=--------------------------------------------------------------------=
        // MARK: State
        //=--------------------------------------------------------------------=
        
        @usableFromInline let base: UnsafeMutablePointer<UInt>
        
        //=--------------------------------------------------------------------=
        // MARK: Initializers
        //=--------------------------------------------------------------------=
        
        @inlinable init(_ LAYOUT: UnsafeMutablePointer<Layout>) {
            self.base = UnsafeMutableRawPointer(LAYOUT).assumingMemoryBound(to: UInt.self)
        }
        
        //=--------------------------------------------------------------------=
        // MARK: Accessors
        //=--------------------------------------------------------------------=
        
        @usableFromInline subscript(index: Int) -> UInt {
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
}
