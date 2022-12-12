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
// MARK: * OBE x Fixed Width Integer x Words
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var bitWidth: Int {
        Body.bitWidth
    }
    
    @_transparent @usableFromInline static var count: Int {
        Body.count
    }
    
    @_transparent @usableFromInline static var startIndex: Int {
        Body.startIndex
    }
    
    @_transparent @usableFromInline static var endIndex: Int {
        Body.endIndex
    }
    
    @_transparent @usableFromInline static var firstIndex: Int {
        Body.firstIndex
    }
    
    @_transparent @usableFromInline static var lastIndex: Int {
        Body.lastIndex
    }
    
    @_transparent @usableFromInline static var indices: Range<Int> {
        Body.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: some WoRdS {
        OBEFullWidthLittleEndianWords(body)
    }
    
    @inlinable public var nonzeroBitCount: Int {
        body.nonzeroBitCount
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        body.leadingZeroBitCount
    }
    
    @inlinable public var trailingZeroBitCount: Int {
        body.trailingZeroBitCount
    }
    
    @inlinable public var mostSignificantBit: Bool {
        body.mostSignificantBit
    }
    
    @inlinable public var leastSignificantBit: Bool {
        body.leastSignificantBit
    }
    
    @inlinable public var mostSignificantWord: UInt {
        body.mostSignificantWord
    }
    
    @inlinable public var leastSignificantWord: UInt {
        body.leastSignificantWord
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func withUnsafeTwosComplementWords<T>(
    _ operation: (Body.Reader) throws -> T) rethrows -> T {
        try body.withUnsafeTwosComplementWords(operation)
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableTwosComplementWords<T>(
    _ operation: (Body.Mutator) throws -> T) rethrows -> T {
        try body.withUnsafeMutableTwosComplementWords(operation)
    }
    
    @_transparent @usableFromInline static func fromUnsafeUninitializedTwosComplementWords(
    _ operation: (Body.Mutator) throws -> Void) rethrows -> Self {
        Self(bitPattern: try Body.fromUnsafeUninitializedTwosComplementWords(operation))
    }
}
