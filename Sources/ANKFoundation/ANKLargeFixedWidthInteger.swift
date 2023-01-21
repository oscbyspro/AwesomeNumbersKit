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
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=

    /// Forms the truncated sum of adding `rhs` to `lhs`.
    ///
    /// ```
    /// var a: Int256.max - Int256(1); a &+= Int(1) // a = Int256.max
    /// var b: Int256.max - Int256(0); b &+= Int(1) // b = Int256.min
    /// ```
    ///
    @inlinable static func &+=(lhs: inout Self, rhs: Digit)

    /// Returns the truncated sum of adding `rhs` to `lhs`.
    ///
    /// ```
    /// (Int256.max - Int256(1)) &+ Int(1) // Int256.max
    /// (Int256.max - Int256(0)) &+ Int(1) // Int256.min
    /// ```
    ///
    @inlinable static func &+(lhs: Self, rhs: Digit) -> Self
    
    /// Forms the sum of adding the given value to this value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// var a: Int256.max - Int256(1); a.addReportingOverflow(Int(1)) // a = Int256.max; -> false
    /// var b: Int256.max - Int256(0); b.addReportingOverflow(Int(1)) // b = Int256.min; -> true
    /// ```
    ///
    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the sum of adding the given value to this value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// (Int256.max - Int256(1)).addingReportingOverflow(Int(1)) // (partialValue: Int256.max, overflow: false)
    /// (Int256.max - Int256(0)).addingReportingOverflow(Int(1)) // (partialValue: Int256.min, overflow: true )
    /// ```
    ///
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying this value by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// var a = Int256(11); a.multiplyReportingOverflow(by: Int(4)) // a = Int256(44); -> false
    /// var b = Int256.max; b.multiplyReportingOverflow(by: Int(4)) // b = Int256(-4); -> true
    /// ```
    ///
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool
    
    /// Returns the product of multiplying this value by the given value,
    /// along with a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// Int256(11).multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(44), overflow: false)
    /// Int256.max.multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(-4), overflow: true )
    /// ```
    ///
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self>
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```
    /// var a = Int256(11); a.multiplyFullWidth(by: Int(4)) // a = Int256(44); -> Int(0)
    /// var b = Int256.max; b.multiplyFullWidth(by: Int(4)) // b = Int256(-4); -> Int(1)
    /// ```
    ///
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit
    
    /// Returns the low and high part of multiplying this value by the given value.
    ///
    /// ```
    /// Int256(11).multipliedFullWidth(by: Int(4)) // (high: Int(0), low:  UInt256(44))
    /// Int256.max.multipliedFullWidth(by: Int(4)) // (high: Int(1), low: ~UInt256( 3))
    /// ```
    ///
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=
    
    /// Forms the truncated difference of subtracting `rhs` from `lhs`.
    ///
    /// ```
    /// var a: Int256.min + Int256(1); a &-= Int(1) // a = Int256.min
    /// var b: Int256.min + Int256(0); b &-= Int(1) // b = Int256.max
    /// ```
    ///
    @inlinable static func &-=(lhs: inout Self, rhs: Digit)
    
    /// Returns the truncated difference of subtracting `rhs` from `lhs`.
    ///
    /// ```
    /// (Int256.min + Int256(1)) &- Int(1) // Int256.min
    /// (Int256.min + Int256(0)) &- Int(1) // Int256.max
    /// ```
    ///
    @inlinable static func &-(lhs: Self, rhs: Digit) -> Self

    /// Forms the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred. In the case
    /// of overflow, the result is truncated.
    ///
    /// ```
    /// var a: Int256.min + Int256(1); a.subtractReportingOverflow(Int(1)) // a = Int256.min; -> false
    /// var b: Int256.min + Int256(0); b.subtractReportingOverflow(Int(1)) // b = Int256.max; -> true
    /// ```
    ///
    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred. In the case
    /// of overflow, the result is truncated.
    ///
    /// ```
    /// (Int256.min + Int256(1)).subtractingReportingOverflow(Int(1)) // (partialValue: Int256.min, overflow: false)
    /// (Int256.min + Int256(0)).subtractingReportingOverflow(Int(1)) // (partialValue: Int256.max, overflow: true )
    /// ```
    ///
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
