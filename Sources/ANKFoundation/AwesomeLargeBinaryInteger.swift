//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Binary Integer x Large
//*============================================================================*

/// A large binary integer with additional requirements and capabilities.
///
/// ```
/// self.bitWidth / UInt.bitWidth >= 1
/// self.bitWidth % UInt.bitWidth == 0
/// ```
/// 
public protocol AwesomeLargeBinaryInteger: AwesomeBinaryInteger where
Magnitude: AwesomeUnsignedLargeBinaryInteger {
    
    associatedtype Digit: AwesomeEitherIntOrUInt
    
    //=------------------------------------------------------------------------=
    // MARK: Addition
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Digit)

    @inlinable static func +(lhs: Self, rhs: Digit) -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Division
    //=------------------------------------------------------------------------=
    
    @inlinable static func /=(lhs: inout Self, rhs: Digit)
    
    @inlinable static func /(lhs: Self, rhs: Digit) -> Self
    
    @inlinable static func %=(lhs: inout Self, rhs: Digit)
    
    @inlinable static func %(lhs: Self, rhs: Digit) -> Digit
    
    @inlinable mutating func divideReportingOverflow(by divisor: Digit) -> Bool
    
    @inlinable func dividedReportingOverflow(by divisor: Digit) -> PVO<Self>
    
    @inlinable mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool
    
    @inlinable func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit>
    
    //=------------------------------------------------------------------------=
    // MARK: Subtraction
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Digit)

    @inlinable static func -(lhs: Self, rhs: Digit) -> Self
}

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol AwesomeSignedLargeBinaryInteger: AwesomeLargeBinaryInteger,
AwesomeSignedInteger where Digit == Int { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedLargeBinaryInteger: AwesomeLargeBinaryInteger,
AwesomeUnsignedInteger where Digit == UInt { }
