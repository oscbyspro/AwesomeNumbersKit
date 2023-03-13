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
// MARK: * ANK x [U]Int384
//*============================================================================*

/// A 384-bit signed integer value type.
public typealias ANKInt384 = ANKFullWidth<ANKInt128, ANKUInt256>

/// A 384-bit unsigned integer value type.
public typealias ANKUInt384 = ANKFullWidth<ANKUInt128, ANKUInt256>

//*============================================================================*
// MARK: * ANK x [U]Int384 x (32/64)
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt384 {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x64: A tuple of `UInt64` words, from least significant to most.
    ///
    @_transparent public init(x64: ANK384X64) {
        #if _endian(big)
        self = unsafeBitCast(ANK384X64(x64.5, x64.4, x64.3, x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x32: A tuple of `UInt32` words, from least significant to most.
    ///
    @_transparent public init(x32: ANK384X32) {
        #if _endian(big)
        self = unsafeBitCast(ANK384X32(x32.11, x32.10, x32.9, x32.8, x32.7, x32.6, x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = unsafeBitCast(x32, to: Self.self)
        #endif
    }
}

//*============================================================================*
// MARK: * ANK x [U]Int384 x Patterns
//*============================================================================*

/// A 384-bit pattern, split into `UInt64` words.
public typealias ANK384X64 = (UInt64, UInt64, UInt64, UInt64, UInt64, UInt64)

/// A 384-bit pattern, split into `UInt32` words.
public typealias ANK384X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
