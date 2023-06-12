//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Tuples
//*============================================================================*

extension ANK {
    
    /// A 128-bit pattern, split into `UInt64` words.
    public typealias U128X64 = (UInt64, UInt64)

    /// A 128-bit pattern, split into `UInt32` words.
    public typealias U128X32 = (UInt32, UInt32, UInt32, UInt32)

    /// A 192-bit pattern, split into `UInt64` words.
    public typealias U192X64 = (UInt64, UInt64, UInt64)

    /// A 192-bit pattern, split into `UInt32` words.
    public typealias U192X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)

    /// A 256-bit pattern, split into `UInt64` words.
    public typealias U256X64 = (UInt64, UInt64, UInt64, UInt64)

    /// A 256-bit pattern, split into `UInt32` words.
    public typealias U256X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
    
    /// A 384-bit pattern, split into `UInt64` words.
    public typealias U384X64 = (UInt64, UInt64, UInt64, UInt64, UInt64, UInt64)

    /// A 384-bit pattern, split into `UInt32` words.
    public typealias U384X32 = (UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32, UInt32)
}
