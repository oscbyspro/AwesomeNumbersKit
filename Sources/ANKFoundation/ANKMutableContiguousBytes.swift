//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Contiguous Bytes x Mutable
//*============================================================================*

/// A type that offers read-write access to its data.
public protocol ANKMutableContiguousBytes: ANKContiguousBytes {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Calls the given closure with read-write access to this value's data.
    ///
    /// ```
    /// var x = UInt256(1).bigEndian; x.withUnsafeMutableBytes({ _ in })
    /// ```
    ///
    @inlinable mutating func withUnsafeMutableBytes<T>(_ body: (UnsafeMutableRawBufferPointer) throws -> T) rethrows -> T
}
