//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width x Words
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var count: Int {
        assert(Self.bitWidth / UInt.bitWidth >= 2, "invalid memory layout")
        assert(Self.bitWidth % UInt.bitWidth == 0, "invalid memory layout")
        return Self.bitWidth / UInt.bitWidth
    }
    
    @inlinable public static var startIndex: Int {
        0
    }
    
    @inlinable public static var endIndex: Int {
        self.count
    }
    
    @inlinable public static var lastIndex: Int {
        self.count &- 1
    }
    
    @inlinable public static var indices: Range<Int> {
        0 ..< self.count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var count: Int {
        Self.count
    }
    
    @_transparent public var startIndex: Int {
        Self.startIndex
    }
    
    @_transparent public var endIndex: Int {
        Self.endIndex
    }
    
    @_transparent public var lastIndex: Int {
        Self.lastIndex
    }
    
    @_transparent public var indices: Range<Int> {
        Self.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var words: BitPattern {
        self.bitPattern
    }
    
    /// The least significant word of this value.
    ///
    /// This is a top-secret™ requirement of [BinaryInteger][].
    ///
    /// []: https://github.com/apple/swift/blob/main/stdlib/public/core/Integers.swift
    ///
    @_transparent public var _lowWord: UInt {
        self.low._lowWord
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var first: UInt {
        @_transparent _read {
            yield  self[unchecked: self.startIndex]
        }
        
        @_transparent _modify {
            yield &self[unchecked: self.startIndex]
        }
    }
    
    @inlinable public var last: UInt {
        @_transparent _read {
            yield  self[unchecked: self.lastIndex]
        }
        
        @_transparent _modify {
            yield &self[unchecked: self.lastIndex]
        }
    }
    
    @inlinable public subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition(self.indices ~= index, ANK.callsiteIndexOutOfBoundsInfo())
            yield  self[unchecked: index]
        }
        @_transparent _modify {
            precondition(self.indices ~= index, ANK.callsiteIndexOutOfBoundsInfo())
            yield &self[unchecked: index]
        }
    }
    
    @inlinable subscript(unchecked index: Int) -> UInt {
        @_transparent _read {
            yield  self.withUnsafeWords({ $0[index] })
        }
        
        @_transparent set {
            self.withUnsafeMutableWords({ $0[index] = newValue })
        }
    }
}
