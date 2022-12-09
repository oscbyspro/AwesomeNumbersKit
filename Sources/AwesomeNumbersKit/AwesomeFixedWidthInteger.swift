//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome Fixed Width Integer
//*============================================================================*

/// A FixedWidthInteger with additional requirements and capabilities.
///
/// All fixed width integers in AwesomeNumbersKit conform to AwesomeFixedWidthInteger.
///
public protocol AwesomeFixedWidthInteger: AwesomeBinaryInteger, FixedWidthInteger where
Magnitude: AwesomeUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ bit: Bool)
    
    @inlinable init(repeating bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var  mostSignificantBit: Bool { get }
    
    @inlinable var leastSignificantBit: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Self) -> Bool
    
    @inlinable mutating func multiplyFullWidth(by amount: Self) -> Self
}

//*============================================================================*
// MARK: * Awesome Fixed Width Integer x Signed
//*============================================================================*

public protocol AwesomeSignedFixedWidthInteger: AwesomeFixedWidthInteger, AwesomeSignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @inlinable mutating func negateReportingOverflow() -> Bool
    
    @inlinable func negatedReportingOverflow() -> PVO<Self>
}

//*============================================================================*
// MARK: * Awesome Fixed Width Integer x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedFixedWidthInteger: AwesomeFixedWidthInteger, AwesomeUnsignedInteger { }
