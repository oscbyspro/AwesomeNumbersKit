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
    
    @inlinable static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable static var startIndex: Int {
        0
    }
    
    @inlinable static var endIndex: Int {
        count
    }
    
    @inlinable static var firstIndex: Int {
        0
    }
    
    @inlinable static var lastIndex: Int {
        count - 1
    }
    
    @inlinable static var indices: Range<Int> {
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
    
    @inlinable static func bigEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return index
        #else
        return lastIndex &- index
        #endif
    }
    
    @inlinable static func littleEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return lastIndex &- index
        #else
        return index
        #endif
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Collection
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var count: Int {
        Self.count
    }
    
    @inlinable var startIndex: Int {
        Self.startIndex
    }
    
    @inlinable var endIndex: Int {
        Self.endIndex
    }
    
    @inlinable var firstIndex: Int {
        Self.firstIndex
    }
    
    @inlinable var lastIndex: Int {
        Self.lastIndex
    }
    
    @inlinable var indices: Range<Int> {
        Self.indices
    }
    
    @inlinable var first: UInt {
        self[Self.firstIndex]
    }
    
    @inlinable var last: UInt {
        self[Self.lastIndex]
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        Self.index(after: index)
    }
    
    @inlinable func index(before index: Int) -> Int {
        Self.index(before: index)
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        Self.index(index, offsetBy: distance)
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        Self.distance(from: start, to: end)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        //=--------------------------------------=
        // Pseudo Fixed Width Array (Get)
        //=--------------------------------------=
        @_transparent _read {
            precondition(Self.indices.contains(index))
            yield  self[unchecked: index]
        }
        //=--------------------------------------=
        // Pseudo Fixed Width Array (Set)
        //=--------------------------------------=
        @_transparent _modify {
            precondition(Self.indices.contains(index))
            yield &self[unchecked: index]
        }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        //=--------------------------------------=
        // Pseudo Fixed Width Array (Get)
        //=--------------------------------------=
        @_transparent get {
            withUnsafePointer(to: self) {  SELF in
                let RAW = UnsafeRawPointer(SELF)
                let WORDS = RAW.assumingMemoryBound(to: UInt.self)
                assert(Self.indices.contains(index))
                return WORDS[Self.littleEndianIndex(index)]
            }
        }
        //=--------------------------------------=
        // Pseudo Fixed Width Array (Set)
        //=--------------------------------------=
        @_transparent set {
            withUnsafeMutablePointer(to: &self) { SELF in
                let RAW = UnsafeMutableRawPointer(SELF)
                let WORDS = RAW.assumingMemoryBound(to: UInt.self)
                assert(Self.indices.contains(index))
                WORDS[Self.littleEndianIndex(index)] = newValue
            }
        }
    }
}
