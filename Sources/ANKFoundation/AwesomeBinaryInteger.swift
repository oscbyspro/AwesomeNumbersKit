//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Binary Integer
//*============================================================================*

/// A BinaryInteger with additional requirements and capabilities.
///
/// All binary integers in AwesomeNumbersKit conform to AwesomeBinaryInteger.
///
public protocol AwesomeBinaryInteger: BinaryInteger where Magnitude: AwesomeUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var isZero: Bool { get }
    
    @inlinable var isLessThanZero: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool
    
    @inlinable mutating func divideReportingRemainder(dividingBy divisor: Self) -> Self
    
    @inlinable mutating func formRemainderReportingQuotient(dividingBy divisor: Self) -> Self
}

//*============================================================================*
// MARK: * Awesome Binary Integer x Signed
//*============================================================================*

public protocol AwesomeSignedInteger: AwesomeBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * Awesome Binary Integer x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedInteger: AwesomeBinaryInteger, UnsignedInteger { }
