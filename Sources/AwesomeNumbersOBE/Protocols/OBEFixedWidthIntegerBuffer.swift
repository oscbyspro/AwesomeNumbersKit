//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer Pointer
//*============================================================================*

@usableFromInline protocol OBEFixedWidthIntegerBuffer: WoRdS {
    
    //=------------------------------------------------------------------------=
    // MARK: Type Meta Dats
    //=------------------------------------------------------------------------=
        
    associatedtype Integer: OBEFixedWidthIntegerLayout
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthIntegerBuffer {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var count: Int {
        Integer.count
    }
    
    @inlinable var startIndex: Int {
        Integer.startIndex
    }
    
    @inlinable var endIndex: Int {
        Integer.endIndex
    }
    
    @inlinable var firstIndex: Int {
        Integer.firstIndex
    }
    
    @inlinable var lastIndex: Int {
        Integer.lastIndex
    }
    
    @inlinable var indices: Range<Int> {
        Integer.indices
    }
    
    @inlinable var first: UInt {
        self[Integer.firstIndex]
    }
    
    @inlinable var last: UInt {
        self[Integer.lastIndex]
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
