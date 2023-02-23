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
// MARK: * ANK x Full Width x Collection x Contiguous
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func withContiguousStorageIfAvailable<T>(
    _ body: (UnsafeBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        var base: Self { self.wordSwapped }
        #else
        var base: Self { self }
        #endif
        
        return try base.withUnsafeWords({ try body(UnsafeBufferPointer(start: $0.base, count: $0.count)) })
    }
    
    @inlinable public mutating func withContiguousMutableStorageIfAvailable<T>(
    _ body: (inout UnsafeMutableBufferPointer<UInt>) throws -> T) rethrows -> T? {
        #if _endian(big)
        self = self.wordSwapped; defer { self = self.wordSwapped }
        #endif
        
        return try self.withUnsafeMutableWords({ var x = UnsafeMutableBufferPointer(start: $0.base, count: $0.count); return try body(&x) })
    }
}
