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
// MARK: * ANK x Full Width x Collection
//*============================================================================*

@usableFromInline protocol ANKFullWidthCollection: WoRdS where
High.Digit: AwesomeEitherIntOrUInt, High.Magnitude.Digit == UInt {
    
    associatedtype High: AwesomeLargeFixedWidthInteger
    
    associatedtype Low:  AwesomeUnsignedLargeFixedWidthInteger<UInt> where Low == Low.Magnitude
    
    typealias Body = ANKFullWidth<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable subscript(unchecked index: Int) -> UInt { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKFullWidthCollection {
    
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
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var first: UInt {
        self[unchecked: Body.startIndex]
    }
    
    @inlinable var last: UInt {
        self[unchecked: Body.lastIndex]
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

//*============================================================================*
// MARK: * ANK x Full Width x Collection
//*============================================================================*

extension ANKFullWidth {
    
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
        self.count
    }
    
    @inlinable static var lastIndex: Int {
        self.count - 1
    }
    
    @inlinable static var indices: Range<Int> {
        0 ..< self.count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWords({ $0[index] /*------*/ }) }
        @_transparent  set  { self.withUnsafeMutableWords({ $0[index] = newValue }) }
    }
    
    @usableFromInline subscript(unchecked index: Int) -> UInt {
        @_transparent _read { yield  self.withUnsafeWords({ $0[unchecked: index] /*------*/ }) }
        @_transparent  set  { self.withUnsafeMutableWords({ $0[unchecked: index] = newValue }) }
    }
}
