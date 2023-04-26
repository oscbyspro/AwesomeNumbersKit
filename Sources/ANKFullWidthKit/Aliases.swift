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
// MARK: * ANK x Aliases
//*============================================================================*

/// A composable, large, fixed-width, two's complement, binary integer.
public typealias FullWidth<High, Low> = ANKFullWidth<High, Low> where
High: ANKFixedWidthInteger, High.Digit: ANKIntOrUInt,
Low: ANKFixedWidthInteger & ANKUnsignedInteger, Low.Digit == UInt

//*============================================================================*
// MARK: * ANK x Aliases x Integers x Signed
//*============================================================================*

/// A 128-bit signed integer value type.
public typealias Int128 = ANKInt128

/// A 192-bit signed integer value type.
public typealias Int192 = ANKInt192

/// A 256-bit signed integer value type.
public typealias Int256 = ANKInt256

/// A 384-bit signed integer value type.
public typealias Int384 = ANKInt384

/// A 512-bit signed integer value type.
public typealias Int512 = ANKInt512

/// A 1024-bit signed integer value type.
public typealias Int1024 = ANKInt1024

/// A 2048-bit signed integer value type.
public typealias Int2048 = ANKInt2048

/// A 4096-bit signed integer value type.
public typealias Int4096 = ANKInt4096

//*============================================================================*
// MARK: * ANK x Aliases x Integers x Unsigned
//*============================================================================*

/// A 128-bit unsigned integer value type.
public typealias UInt128 = ANKUInt128

/// A 192-bit unsigned integer value type.
public typealias UInt192 = ANKUInt192

/// A 256-bit unsigned integer value type.
public typealias UInt256 = ANKUInt256

/// A 384-bit unsigned integer value type.
public typealias UInt384 = ANKUInt384

/// A 512-bit unsigned integer value type.
public typealias UInt512 = ANKUInt512

/// A 1024-bit unsigned integer value type.
public typealias UInt1024 = ANKUInt1024

/// A 2048-bit unsigned integer value type.
public typealias UInt2048 = ANKUInt2048

/// A 4096-bit unsigned integer value type.
public typealias UInt4096 = ANKUInt4096
