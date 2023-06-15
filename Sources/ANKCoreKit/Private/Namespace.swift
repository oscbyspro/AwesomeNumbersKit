//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Namespace
//*============================================================================*

/// A namespace for `AwesomeNumbersKit` development.
///
/// - Warning: Do not use this namespace outside of `AwesomeNumbersKit` development.
///
@frozen public enum ANK {
    
    //=------------------------------------------------------------------------=
    // MARK: Aliases
    //=------------------------------------------------------------------------=
    
    /// The sign of a numeric value.
    public typealias Sign = FloatingPointSign

    /// An unsafe pointer to a collection of `UTF-8` code points.
    public typealias UnsafeUTF8 = UnsafeBufferPointer<UInt8>
    
    /// An unsafe pointer to a mutable collection of `UTF-8` code points.
    public typealias UnsafeMutableUTF8 = UnsafeMutableBufferPointer<UInt8>
    
    /// An unsafe pointer to a collection of `UInt` machine words.
    public typealias UnsafeWords = UnsafeBufferPointer<UInt>
    
    /// An unsafe pointer to a mutable collection of `UInt` machine words.
    public typealias UnsafeMutableWords = UnsafeMutableBufferPointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Aliases x Tuples
    //=------------------------------------------------------------------------=
    
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
