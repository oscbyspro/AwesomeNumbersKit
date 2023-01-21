//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large
//*============================================================================*

/// A large fixed-width integer with additional requirements and capabilities.
///
/// **Two's Complement Semantics**
///
/// Like `BinaryInteger`, all bitwise operations have two's complement semantics.
///
public protocol ANKLargeFixedWidthInteger<Digit>: ANKFixedWidthInteger, ANKLargeBinaryInteger where
Digit: ANKFixedWidthInteger, Magnitude: ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Addition
    //=------------------------------------------------------------------------=

    @inlinable static func &+=(lhs: inout Self, rhs: Digit)

    @inlinable static func &+(lhs: Self, rhs: Digit) -> Self
    
    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool
    
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying this value by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// var a: UInt8(15); a.multiplyFullWidth(by: 15) // a = 225; -> false
    /// var b: UInt8(16); b.multiplyFullWidth(by: 16) // b = 000; -> true
    /// ```
    ///
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool
    
    /// Returns the product of multiplying this value by the given value,
    /// along with a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// UInt8(15).multipliedReportingOverflow(by: 15) // -> (partialValue: 225, overflow: false)
    /// UInt8(16).multipliedReportingOverflow(by: 16) // -> (partialValue: 000, overflow: true )
    /// ```
    ///
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self>
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```
    /// var a: UInt8(15); a.multiplyFullWidth(by: 15) // a = 225; -> 0
    /// var b: UInt8(16); b.multiplyFullWidth(by: 16) // b = 000; -> 1
    /// ```
    ///
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit
    
    /// Returns the low and high part of multiplying this value by the given value.
    ///
    /// ```
    /// UInt8(15).multipliedFullWidth(by: 15) // (high: 0, low: 255)
    /// UInt8(16).multipliedFullWidth(by: 16) // (high: 1, low: 000)
    /// ```
    ///
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Subtraction
    //=------------------------------------------------------------------------=

    @inlinable static func &-=(lhs: inout Self, rhs: Digit)
    
    @inlinable static func &-(lhs: Self, rhs: Digit) -> Self

    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool

    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self>
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol ANKSignedLargeFixedWidthInteger<Digit>: ANKLargeFixedWidthInteger,
ANKSignedFixedWidthInteger, ANKSignedLargeBinaryInteger where Digit: ANKSignedFixedWidthInteger { }

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol ANKUnsignedLargeFixedWidthInteger<Digit>: ANKLargeFixedWidthInteger,
ANKUnsignedFixedWidthInteger, ANKUnsignedLargeBinaryInteger where Digit: ANKUnsignedFixedWidthInteger { }
