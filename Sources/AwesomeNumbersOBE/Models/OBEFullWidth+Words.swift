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
// MARK: * OBE x Full Width x Words
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static var bitWidth: Int {
        High.bitWidth + Low.bitWidth
    }
    
    @_transparent @usableFromInline static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
    }
    
    @_transparent @usableFromInline static var startIndex: Int {
        0
    }
    
    @_transparent @usableFromInline static var endIndex: Int {
        count
    }
    
    @_transparent @usableFromInline static var firstIndex: Int {
        0
    }
    
    @_transparent @usableFromInline static var lastIndex: Int {
        count - 1
    }
    
    @_transparent @usableFromInline static var indices: Range<Int> {
        0 ..< count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var nonzeroBitCount: Int {
        low.nonzeroBitCount + high.nonzeroBitCount
    }
    
    @inlinable var leadingZeroBitCount: Int {
        high.isZero ? High.bitWidth + low.leadingZeroBitCount : high.leadingZeroBitCount
    }
    
    @inlinable var trailingZeroBitCount: Int {
        low.isZero ? Low.bitWidth + high.trailingZeroBitCount : low.trailingZeroBitCount
    }
    
    @inlinable var mostSignificantBit: Bool {
        high.mostSignificantBit
    }
    
    @inlinable var leastSignificantBit: Bool {
        low.leastSignificantBit
    }
    
    @inlinable var mostSignificantWord: UInt {
        high.mostSignificantWord
    }
    
    @inlinable var leastSignificantWord: UInt {
        low.leastSignificantWord
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func withUnsafeTwosComplementWords<T>(
    _ operation: (Reader) throws -> T) rethrows -> T {
        try Swift.withUnsafePointer(to: self) { SELF in
            try operation(Reader(SELF))
        }
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableTwosComplementWords<T>(
    _ operation: (Mutator) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutablePointer(to: &self) { SELF in
            try operation(Mutator(SELF))
        }
    }
    
    @_transparent @usableFromInline static func fromUnsafeUninitializedTwosComplementWords(
    _ operation: (Mutator) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
            let SELF = BUFFER.baseAddress.unsafelyUnwrapped
            try operation(Mutator(SELF)); return SELF.pointee
        }
    }
}
