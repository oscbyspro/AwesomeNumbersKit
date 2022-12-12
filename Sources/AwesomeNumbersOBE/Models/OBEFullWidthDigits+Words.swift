//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width Digits x Words
//*============================================================================*

extension OBEFullWidthDigits {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var count: Int {
        Layout.count
    }
    
    @inlinable var startIndex: Int {
        Layout.startIndex
    }
    
    @inlinable var endIndex: Int {
        Layout.endIndex
    }
    
    @inlinable var firstIndex: Int {
        Layout.firstIndex
    }
    
    @inlinable var lastIndex: Int {
        Layout.lastIndex
    }
    
    @inlinable var indices: Range<Int> {
        Layout.indices
    }
    
    @inlinable var first: UInt {
        self[Layout.firstIndex]
    }
    
    @inlinable var last: UInt {
        self[Layout.lastIndex]
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        assert((/*------*/     endIndex) > index)
        assert((startIndex ... endIndex).contains(index))
        return index &+ 1
    }
    
    @inlinable func index(before index: Int) -> Int {
        assert((startIndex     /*----*/) < index)
        assert((startIndex ... endIndex).contains(index))
        return index &- 1
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        let next = index &+ distance
        assert((startIndex ... endIndex).contains(index))
        assert((startIndex ... endIndex).contains(next ))
        return next
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        assert((startIndex ... endIndex).contains(start))
        assert((startIndex ... endIndex).contains(end  ))
        return end &- start
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func bigEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return index
        #else
        return lastIndex &- index
        #endif
    }
    
    @inlinable func littleEndianIndex(_ index: Int) -> Int {
        assert(indices.contains(index))
        #if _endian(big)
        return lastIndex &- index
        #else
        return index
        #endif
    }
}

