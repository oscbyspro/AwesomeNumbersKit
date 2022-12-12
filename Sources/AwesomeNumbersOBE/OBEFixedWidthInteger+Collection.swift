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
// MARK: * OBE x Fixed Width Integer x Collection
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var count: Int {
        Body.count
    }
    
    @inlinable static var startIndex: Int {
        Body.startIndex
    }
    
    @inlinable static var endIndex: Int {
        Body.endIndex
    }
    
    @inlinable static var firstIndex: Int {
        Body.firstIndex
    }
    
    @inlinable static var lastIndex: Int {
        Body.lastIndex
    }
    
    @inlinable static var indices: Range<Int> {
        Body.indices
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func withUnsafeTwosComplementWords<T>(
    _ operation: (Body.UnsafeLittleEndianReader) throws -> T) rethrows -> T {
        try body.withUnsafeTwosComplementWords(operation)
    }
    
    @_transparent @usableFromInline mutating func withUnsafeMutableTwosComplementWords<T>(
    _ operation: (Body.UnsafeLittleEndianMutator) throws -> T) rethrows -> T {
        try body.withUnsafeMutableTwosComplementWords(operation)
    }
    
    @_transparent @usableFromInline static func fromUnsafeUninitializedTwosComplementWords(
    _ operation: (Body.UnsafeLittleEndianMutator) throws -> Void) rethrows -> Self {
        Self(bitPattern: try Body.fromUnsafeUninitializedTwosComplementWords(operation))
    }
}
