//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Binary Integer x Large
//*============================================================================*

/// A large binary integer with additional requirements and capabilities.
public protocol ANKLargeBinaryInteger<Digit>: ANKBinaryInteger where Magnitude: ANKUnsignedLargeBinaryInteger {
    
    associatedtype Digit: ANKBinaryInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(digit: Digit)
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Addition
    //=------------------------------------------------------------------------=
    
    @inlinable static func +=(lhs: inout Self, rhs: Digit)

    @inlinable static func +(lhs: Self, rhs: Digit) -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Division
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
    // MARK: Transformations x Multiplication
    //=------------------------------------------------------------------------=
    
    @inlinable static func *=(lhs: inout Self, rhs: Digit)
    
    @inlinable static func *(lhs: Self, rhs: Digit) -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Subtraction
    //=------------------------------------------------------------------------=
    
    @inlinable static func -=(lhs: inout Self, rhs: Digit)

    @inlinable static func -(lhs: Self, rhs: Digit) -> Self
}

//=----------------------------------------------------------------------------=
// MARK: + Details where Digit == Self
//=----------------------------------------------------------------------------=

extension ANKLargeBinaryInteger where Digit == Self {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(digit: Digit) { self = digit }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol ANKSignedLargeBinaryInteger<Digit>: ANKLargeBinaryInteger,
ANKSignedInteger where Digit: ANKSignedInteger { }

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol ANKUnsignedLargeBinaryInteger<Digit>: ANKLargeBinaryInteger,
ANKUnsignedInteger where Digit: ANKUnsignedInteger { }
