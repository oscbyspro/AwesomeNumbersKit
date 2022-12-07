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
    
    @inlinable var isZero: Bool {
        self.allSatisfy({ $0.isZero })
    }
    
    @inlinable var isLessThanZero: Bool {
        self[lastIndex] >> (UInt.bitWidth - 1) != 0
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var count: Int {
        MemoryLayout<Integer>.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable var startIndex: Int {
        0
    }
    
    @inlinable var endIndex: Int {
        count
    }
    
    @inlinable var firstIndex: Int {
        startIndex
    }
    
    @inlinable var lastIndex: Int {
        count - 1
    }
    
    @inlinable var indices: Range<Int> {
        0 ..< count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        index + 1
    }
    
    @inlinable func index(before index: Int) -> Int {
        index - 1
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        index + distance
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        end - start
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func bigEndianIndex(_ index: Int) -> Int {
        Swift.precondition(indices.contains(index))
        
        #if _endian(big)
        return index
        #else
        return lastIndex - index
        #endif
    }
    
    @inlinable func littleEndianIndex(_ index: Int) -> Int {
        Swift.precondition(indices.contains(index))
        
        #if _endian(big)
        return lastIndex - index
        #else
        return index
        #endif
    }
}
