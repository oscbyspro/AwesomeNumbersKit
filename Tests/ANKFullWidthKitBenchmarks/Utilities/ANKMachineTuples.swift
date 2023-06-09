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
// MARK: * ANK x Machine Tuples
//*============================================================================*

/// A 128-bit pattern, split into `UInt64` words.
typealias ANK128X64 = (UInt64, UInt64)

/// A 128-bit pattern, split into `UInt32` words.
typealias ANK128X32 = (UInt32, UInt32, UInt32, UInt32)

/// A 192-bit pattern, split into `UInt64` words.
typealias ANK192X64 = (UInt64, UInt64, UInt64)

/// A 192-bit pattern, split into `UInt32` words.
typealias ANK192X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)

/// A 256-bit pattern, split into `UInt64` words.
typealias ANK256X64 = (UInt64, UInt64, UInt64, UInt64)

/// A 256-bit pattern, split into `UInt32` words.
typealias ANK256X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)

//*============================================================================*
// MARK: * ANK x Machine Tuples x Full Width
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    init(x64: ANK128X64) where BitPattern == UInt128 {
        #if _endian(big)
        self = Swift.unsafeBitCast((x64.1, x64.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast((x64), to: Self.self)
        #endif
    }
    
    init(x32: ANK128X64) where BitPattern == UInt128 {
        #if _endian(big)
        self = Swift.unsafeBitCast((x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast((x32), to: Self.self)
        #endif
    }
    
    init(x64: ANK192X64) where Magnitude == ANKUInt192 {
        #if _endian(big)
        self = unsafeBitCast(ANK192X64(x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    init(x32: ANK192X32) where Magnitude == ANKUInt192 {
        #if _endian(big)
        self = unsafeBitCast(ANK192X32(x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = unsafeBitCast(x32, to: Self.self)
        #endif
    }
    
    init(x64: ANK256X64) where Magnitude == ANKUInt256 {
        #if _endian(big)
        self = unsafeBitCast(ANK256X64(x64.3, x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    init(x32: ANK256X32) where Magnitude == ANKUInt256 {
        #if _endian(big)
        self = unsafeBitCast(ANK256X32(x32.7, x32.6, x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = unsafeBitCast(x32, to: Self.self)
        #endif
    }
}
