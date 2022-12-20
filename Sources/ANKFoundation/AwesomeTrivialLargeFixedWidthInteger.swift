//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Trivial
//*============================================================================*

/// An awesome large fixed-width integer with trivial implementation.
///
/// - `Int`
/// - `Int64`
/// - `UInt`
/// - `UInt64`
///
public protocol AwesomeTrivialLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger { }

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeTrivialLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public init(repeating word: UInt) {
        self = withUnsafeTemporaryAllocation(of: Self.self, capacity: 1) { BUFFER in
        UnsafeMutableRawBufferPointer(BUFFER).assumingMemoryBound(to: UInt.self).assign(repeating: word)
        return BUFFER.baseAddress.unsafelyUnwrapped.pointee }
    }
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Trivial x Swift
//*============================================================================*

extension Int:    AwesomeTrivialLargeFixedWidthInteger,   AwesomeSignedLargeFixedWidthInteger { }
extension Int64:  AwesomeTrivialLargeFixedWidthInteger,   AwesomeSignedLargeFixedWidthInteger { }
extension UInt:   AwesomeTrivialLargeFixedWidthInteger, AwesomeUnsignedLargeFixedWidthInteger { }
extension UInt64: AwesomeTrivialLargeFixedWidthInteger, AwesomeUnsignedLargeFixedWidthInteger { }
