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
public protocol AwesomeFixedWidthInteger: AwesomeBinaryInteger, FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool
    
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool
}
