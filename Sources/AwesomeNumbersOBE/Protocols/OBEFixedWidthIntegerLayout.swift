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
// MARK: * OBE x Fixed Width Integer Layout
//*============================================================================*

/// A fixed width integer layout protocol.
///
/// - `Self.bitWidth = MemoryLayout<Self>.stride * 8 `
/// - `Self.bitWidth` must be an integer multiple of `UInt.bitWidth`
///
@usableFromInline protocol OBEFixedWidthIntegerLayout {
    
    typealias Reader  = OBEFixedWidthIntegerReader<Self>
    
    typealias Mutator = OBEFixedWidthIntegerMutator<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init()
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var bitWidth: Int  { get }
    
    @inlinable static var isSigned: Bool { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthIntegerLayout {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var bitWidth: Int {
        MemoryLayout<Self>.stride * 8
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
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: some WoRdS {
        OBEFixedWidthIntegerWords(self)
    }
    
    @inlinable func withUnsafeTwosComplementWords<T>(
    _ body: (Reader) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) { INTEGER in try body(Reader(INTEGER)) }
    }
    
    @inlinable mutating func withUnsafeMutableTwosComplementWords<T>(
    _ body: (Mutator) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { INTEGER in try body(Mutator(INTEGER)) }
    }
    
    @inlinable static func fromUnsafeUninitializedTwosComplementWords(
    _ body: (Mutator) throws -> Void) rethrows -> Self {
        var next = Self(); try next.withUnsafeMutableTwosComplementWords(body); return next
    }
}
