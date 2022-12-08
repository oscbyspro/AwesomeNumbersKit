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
    
    @inlinable static var count: Int {
        MemoryLayout<Self>.stride / MemoryLayout<UInt>.stride
    }
    
    @inlinable static var startIndex: Int {
        0
    }
    
    @inlinable static var endIndex: Int {
        count
    }
    
    @inlinable static var firstIndex: Int {
        0
    }
    
    @inlinable static var lastIndex: Int {
        count - 1
    }
    
    @inlinable static var indices: Range<Int> {
        0 ..< count
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: some WoRdS {
        OBEFixedWidthIntegerWords(self)
    }
    
    @inlinable func withUnsafeTwosComplementWords<T>(_ body: (Reader) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) { INTEGER in try body(Reader(INTEGER)) }
    }
    
    @inlinable mutating func withUnsafeMutableTwosComplementWords<T>(_ body: (Mutator) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { INTEGER in try body(Mutator(INTEGER)) }
    }
    
    @inlinable static func fromUnsafeUninitializedTwosComplementWords(_ body: (Mutator) throws -> Void) rethrows -> Self {
        var next = Self(); try next.withUnsafeMutableTwosComplementWords(body); return next
    }
}
