//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFullWidthKit

//*============================================================================*
// MARK: * ANK x [U]Int256
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt256 {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x64: A tuple of `UInt64` words, from least significant to most.
    ///
    @_transparent public init(x64: ANK256X64) {
        #if _endian(big)
        self = unsafeBitCast(ANK256X64(x64.3, x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x32: A tuple of `UInt32` words, from least significant to most.
    ///
    @_transparent public init(x32: ANK256X32) {
        #if _endian(big)
        self = unsafeBitCast(ANK256X32(x32.7, x32.6, x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = unsafeBitCast(x32, to: Self.self)
        #endif
    }
}

//*============================================================================*
// MARK: * ANK x [U]Int256 x Patterns
//*============================================================================*

/// A 256-bit pattern, split into `UInt64` words.
public typealias ANK256X64 = (UInt64, UInt64, UInt64, UInt64)

/// A 256-bit pattern, split into `UInt32` words.
public typealias ANK256X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
