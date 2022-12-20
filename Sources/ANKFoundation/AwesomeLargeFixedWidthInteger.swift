//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large
//*============================================================================*

/// A large fixed-width integer with additional requirements and capabilities.
///
/// ```
/// self.bitWidth / UInt.bitWidth >= 1
/// self.bitWidth % UInt.bitWidth == 0
/// ```
/// 
public protocol AwesomeLargeFixedWidthInteger: AwesomeFixedWidthInteger,
AwesomeLargeBinaryInteger where Magnitude: AwesomeUnsignedLargeFixedWidthInteger {
    
    associatedtype Digit: AwesomeEitherIntOrUInt
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(repeating word: UInt)
    
    #warning("TODO............................................................")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Digit)

    @inlinable static func +(lhs: Self, rhs: Digit) -> Self

//    @inlinable static func &+=(lhs: inout Self, rhs: Digit)
//
//    @inlinable static func &+(lhs: Self, rhs: Digit) -> Self

    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool
    
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    #warning("TODO............................................................")
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Digit)

    @inlinable static func -(lhs: Self, rhs: Digit) -> Self

//    @inlinable static func &-=(lhs: inout Self, rhs: Digit)
//    
//    @inlinable static func &-(lhs: Self, rhs: Digit) -> Self

    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool

    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self>
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol AwesomeSignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeSignedFixedWidthInteger, AwesomeSignedLargeBinaryInteger where Digit == Int { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedLargeFixedWidthInteger: AwesomeLargeFixedWidthInteger,
AwesomeUnsignedFixedWidthInteger, AwesomeUnsignedLargeBinaryInteger where Digit == UInt { }
