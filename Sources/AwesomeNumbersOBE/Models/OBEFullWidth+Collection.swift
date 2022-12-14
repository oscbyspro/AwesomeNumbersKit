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
    
    @inlinable static var lastIndex: Int {
        count - 1
    }
    
    @inlinable static var indices: Range<Int> {
        0 ..< count
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
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read { yield  withUnsafeLittleEndianWords({ $0[index] /*------*/ }) }
        @_transparent  set  { withUnsafeMutableLittleEndianWords({ $0[index] = newValue }) }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  withUnsafeLittleEndianWords({ $0[unchecked: index] /*------*/ }) }
        @_transparent  set  { withUnsafeMutableLittleEndianWords({ $0[unchecked: index] = newValue }) }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Collection
//*============================================================================*

@usableFromInline protocol OBEFullWidthCollection: WoRdS {
    
    associatedtype High
    
    associatedtype Low
    
    typealias Body = OBEFullWidth<High, Low>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFullWidthCollection {
    
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
