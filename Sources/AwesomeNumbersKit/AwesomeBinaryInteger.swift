//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome Binary Integer
//*============================================================================*

/// A BinaryInteger with additional requirements and capabilities.
///
/// All binary integers in AwesomeNumbersKit conform to AwesomeBinaryInteger.
///
public protocol AwesomeBinaryInteger: BinaryInteger where Magnitude: AwesomeUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var isZero: Bool { get }
    
    @inlinable var isLessThanZero: Bool { get }
}

//*============================================================================*
// MARK: * Awesome Binary Integer x Signed
//*============================================================================*

public protocol AwesomeSignedInteger: AwesomeBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * Awesome Binary Integer x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedInteger: AwesomeBinaryInteger, UnsignedInteger where Self == Magnitude { }
