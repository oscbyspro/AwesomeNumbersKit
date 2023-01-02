//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Fixed Width Integer
//*============================================================================*

/// A fixed-width integer with additional requirements and capabilities.
///
/// All fixed width integers in `AwesomeNumbersKit` conform to `ANKFixedWidthInteger`.
///
public protocol ANKFixedWidthInteger: FixedWidthInteger, ANKBinaryInteger where Magnitude: ANKUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
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
// MARK: * ANK x Fixed Width Integer x Signed
//*============================================================================*

public protocol ANKSignedFixedWidthInteger: ANKFixedWidthInteger, ANKSignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func negateReportingOverflow() -> Bool
    
    @inlinable func negatedReportingOverflow() -> PVO<Self>
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Unsigned
//*============================================================================*

public protocol ANKUnsignedFixedWidthInteger: ANKFixedWidthInteger, ANKUnsignedInteger { }
