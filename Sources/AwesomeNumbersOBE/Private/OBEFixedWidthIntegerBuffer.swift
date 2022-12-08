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
        
    associatedtype Integer: OBEFixedWidthInteger
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
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        end - start
    }
    
    @inlinable func index(after index: Int) -> Int {
        index + 1
    }
    
    @inlinable func index(before index: Int) -> Int {
        index - 1
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        index + distance
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func bigEndianIndex(_ index: Int) -> Int {        
        #if _endian(big)
        return index
        #else
        return lastIndex - index
        #endif
    }
    
    @inlinable func littleEndianIndex(_ index: Int) -> Int {
        #if _endian(big)
        return lastIndex - index
        #else
        return index
        #endif
    }
}
