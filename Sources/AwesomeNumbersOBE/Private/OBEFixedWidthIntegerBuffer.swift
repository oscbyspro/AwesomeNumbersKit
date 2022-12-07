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

@usableFromInline protocol OBEFixedWidthIntegerBuffer: WoRdS, RandomAccessCollection where
Index == Int, Indices == Range<Int>, Element == UInt {
        
    associatedtype Integer: FixedWidthInteger
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
    
    @inlinable static var count: Int {
        MemoryLayout<Integer>.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable var count: Int {
        Self.count
    }
    
    @inlinable var startIndex: Int {
        #if _endian(big)
        return Self.count - 1
        #else
        return 0
        #endif
    }
    
    @inlinable var endIndex: Int {
        #if _endian(big)
        return -1
        #else
        return Self.count
        #endif
    }
    
    @inlinable var firstIndex: Int {
        startIndex
    }
    
    @inlinable var lastIndex: Int {
        #if _endian(big)
        return 0
        #else
        return Self.count - 1
        #endif
    }
    
    @inlinable func index(after index: Int) -> Int {
        #if _endian(big)
        return index - 1
        #else
        return index + 1
        #endif
    }
    
    @inlinable func index(before index: Int) -> Int {
        #if _endian(big)
        return index + 1
        #else
        return index - 1
        #endif
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        #if _endian(big)
        return index - distance
        #else
        return index + distance
        #endif
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        #if _endian(big)
        start - end
        #else
        end - start
        #endif
    }
}
