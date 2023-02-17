//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Unsafe Raw Integer
//*============================================================================*

/// An awesome binary integer, which value is its in-memory representation.
///
/// Integers conforming to this protocol have access to the following semantic methods:
///
/// - `withUnsafeBytes(_:)`
/// - `withUnsafeMutableBytes(_:)`
/// - `fromUnsafeMutableBytes(_:)`
///
public protocol ANKUnsafeRawInteger: ANKFixedWidthInteger, ANKMutableContiguousBytes { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKUnsafeRawInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// Calls the given closure with read-only access to this value's data.
    ///
    /// ```
    /// UInt256(1).bigEndian.withUnsafeBytes({ data += $0 })
    /// ```
    ///
    @_transparent public func withUnsafeBytes<T>(_ body: (UnsafeRawBufferPointer) throws -> T) rethrows -> T {
        try Swift.withUnsafeBytes(of: self, body)
    }
    
    /// Calls the given closure with read-write access to this value's data.
    ///
    /// ```
    /// var x = UInt256(1).bigEndian; x.withUnsafeMutableBytes({ _ in })
    /// ```
    ///
    @_transparent public mutating func withUnsafeMutableBytes<T>(_ body: (UnsafeMutableRawBufferPointer) throws -> T) rethrows -> T {
        try Swift.withUnsafeMutableBytes(of: &self, body)
    }
    
    /// Creates a new instance from a temporary allocation.
    ///
    /// ```
    /// UInt256.fromUnsafeMutableBytes({ _ in }).bigEndian
    /// ```
    ///
    @_transparent public static func fromUnsafeMutableBytes(_ body: (UnsafeMutableRawBufferPointer) throws -> Void) rethrows -> Self {
        try Swift.withUnsafeTemporaryAllocation(byteCount: MemoryLayout<Self>.size, alignment: MemoryLayout<Self>.alignment) { BYTES in
            try body(BYTES); return BYTES.load(as: Self.self)
        }
    }
}
