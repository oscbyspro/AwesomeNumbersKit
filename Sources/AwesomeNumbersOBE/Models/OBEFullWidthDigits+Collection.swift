//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width Digits x Collection
//*============================================================================*

extension OBEFullWidthDigits {
    
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
    
    @inlinable var firstIndex: Int {
        Body.firstIndex
    }
    
    @inlinable var lastIndex: Int {
        Body.lastIndex
    }
    
    @inlinable var indices: Range<Int> {
        Body.indices
    }
    
    @inlinable var first: UInt {
        self[Body.firstIndex]
    }
    
    @inlinable var last: UInt {
        self[Body.lastIndex]
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func index(after index: Int) -> Int {
        Body.index(after: index)
    }
    
    @inlinable func index(before index: Int) -> Int {
        Body.index(before: index)
    }
    
    @inlinable func index(_ index: Int, offsetBy distance: Int) -> Int {
        Body.index(index, offsetBy: distance)
    }
    
    @inlinable func distance(from start: Int, to end: Int) -> Int {
        Body.distance(from: start, to: end)
    }
}
