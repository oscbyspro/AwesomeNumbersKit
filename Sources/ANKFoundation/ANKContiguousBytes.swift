//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Contiguous Bytes
//*============================================================================*

/// A type that offers direct access to the contents of its underlying bytes.
public protocol ANKContiguousBytes {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Calls the given closure with direct access to the underlying bytes of this value.
    ///
    /// ```
    /// UInt256(1).bigEndian.withUnsafeBytes({ data += $0 })
    /// ```
    ///
    @inlinable func withUnsafeBytes<T>(_ body: (UnsafeRawBufferPointer) throws -> T) rethrows -> T
}
