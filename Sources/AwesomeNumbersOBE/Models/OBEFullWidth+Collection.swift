//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Collection
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
    }
    
    @_transparent @usableFromInline static var startIndex: Int {
        0
    }
    
    @_transparent @usableFromInline static var endIndex: Int {
        count
    }
    
    @_transparent @usableFromInline static var firstIndex: Int {
        0
    }
    
    @_transparent @usableFromInline static var lastIndex: Int {
        count - 1
    }
    
    @_transparent @usableFromInline static var indices: Range<Int> {
        0 ..< count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func index(after index: Int) -> Int {
        assert((/*------*/     endIndex) > index)
        assert((startIndex ... endIndex).contains(index))
        return index &+ 1
    }
    
    @inlinable static func index(before index: Int) -> Int {
        assert((startIndex     /*----*/) < index)
        assert((startIndex ... endIndex).contains(index))
        return index &- 1
    }
    
    @inlinable static func index(_ index: Int, offsetBy distance: Int) -> Int {
        let next = index &+ distance
        assert((startIndex ... endIndex).contains(index))
        assert((startIndex ... endIndex).contains(next ))
        return next
    }
    
    @inlinable static func distance(from start: Int, to end: Int) -> Int {
        assert((startIndex ... endIndex).contains(start))
        assert((startIndex ... endIndex).contains(end  ))
        return end &- start
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static func bigEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return index
        #else
        return lastIndex &- index
        #endif
    }
    
    @_transparent @usableFromInline static func littleEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return lastIndex &- index
        #else
        return index
        #endif
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func withUnsafeTwosComplementWords<T>(
    _ operation: (UnsafeLittleEndianReader) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { SELF in
            try operation(UnsafeLittleEndianReader(SELF))
        }
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableTwosComplementWords<T>(
    _ operation: (UnsafeLittleEndianMutator) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { SELF in
            try operation(UnsafeLittleEndianMutator(SELF))
        }
    }
    
    @_transparent @usableFromInline static func fromUnsafeUninitializedTwosComplementWords(
    _ operation: (UnsafeLittleEndianMutator) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try operation(UnsafeLittleEndianMutator(SELF)); return SELF.pointee
        }
    }
}
