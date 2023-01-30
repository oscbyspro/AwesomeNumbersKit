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
// MARK: * ANK x (U)Int512
//*============================================================================*

public typealias  ANKInt512 = ANKFullWidth< ANKInt256, ANKUInt256>
public typealias ANKUInt512 = ANKFullWidth<ANKUInt256, ANKUInt256>

//*============================================================================*
// MARK: * ANK x (U)Int512 x X(32/64)
//*============================================================================*

extension ANKFullWidth where Magnitude == ANKUInt512 {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x64: A tuple of `UInt64` words, from least significant to most.
    ///
    @_transparent public init(x64: ANK512X64) {
        #if _endian(big)
        self = unsafeBitCast(ANK512X64(
        x64.7,  x64.6,  x64.5,  x64.4,  x64.3,  x64.2,  x64.1,  x64.0), to: Self.self)
        #else
        self = unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    /// Creates a new instance from the given tuple.
    ///
    /// - Parameter x32: A tuple of `UInt32` words, from least significant to most.
    ///
    @_transparent public init(x32: ANK512X32) {
        #if _endian(big)
        self = unsafeBitCast(ANK512X32(
        x32.15, x32.14, x32.13, x32.12, x32.11, x32.10, x32.9,  x32.8,
        x32.7,  x32.6,  x32.5,  x32.4,  x32.3,  x32.2,  x32.1,  x32.0), to: Self.self)
        #else
        self = unsafeBitCast(x32, to: Self.self)
        #endif
    }
}

//*============================================================================*
// MARK: * ANK x (U)Int512 x Tuples
//*============================================================================*

public typealias ANK512X64 = (
UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64, UInt64)

public typealias ANK512X32 = (
UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32,
UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
