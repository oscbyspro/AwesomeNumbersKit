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

/// A `FixedWidthInteger` with additional requirements and capabilities.
///
/// All fixed-width integers in `AwesomeNumbersKit` conform to `ANKFixedWidthInteger`.
///
/// **Two's Complement Semantics**
///
/// Like `BinaryInteger`, all bitwise operations have two's complement semantics.
///
public protocol ANKFixedWidthInteger: FixedWidthInteger, ANKBinaryInteger where Magnitude: ANKUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance repeating the given bit in two's complement form.
    ///
    /// - Returns: `bit ? ~0 : 0`
    ///
    @inlinable init(repeating bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the given value to this value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// var a: Int8(126); a.addReportingOverflow(Int8(1)) // a = Int8( 127); -> false
    /// var b: Int8(127); b.addReportingOverflow(Int8(1)) // b = Int8(-128); -> true
    /// ```
    ///
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying this value by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is truncated.
    ///
    /// ```
    /// var a = Int8(11); a.multiplyReportingOverflow(by: Int8(4)) // a = Int8(44); -> false
    /// var b = Int8.max; b.multiplyReportingOverflow(by: Int8(4)) // b = Int8(-4); -> true
    /// ```
    ///
    @inlinable mutating func multiplyReportingOverflow(by amount: Self) -> Bool
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```
    /// var a = Int8(11); a.multiplyFullWidth(by: Int8(4)) // (high: Int8(0), low:  UInt8(44))
    /// var b = Int8.max; b.multiplyFullWidth(by: Int8(4)) // (high: Int8(1), low: ~UInt8( 3))
    /// ```
    ///
    @inlinable mutating func multiplyFullWidth(by amount: Self) -> Self
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=
    
    /// Forms the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred. In the case
    /// of overflow, the result is truncated.
    ///
    /// ```
    /// var a: Int8(-127); a.subtractReportingOverflow(1) // a = -128; -> false
    /// var b: Int8(-128); b.subtractReportingOverflow(1) // b =  127; -> true
    /// ```
    ///
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Signed
//*============================================================================*

public protocol ANKSignedFixedWidthInteger: ANKFixedWidthInteger, ANKSignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms a value with equal magnitude but opposite sign, and returns a
    /// value indicating whether overflow occurred. In the case of overflow,
    /// the result is truncated.
    ///
    /// ```
    /// var a: Int8(-127); a.negateReportingOverflow() // a = Int8( 127); -> false
    /// var b: Int8(-128); b.negateReportingOverflow() // b = Int8(-128); -> true
    /// ```
    ///
    @inlinable mutating func negateReportingOverflow() -> Bool
    
    /// Returns a value with equal magnitude but opposite sign, along with a
    /// value indicating whether overflow occurred. In the case of overflow,
    /// the result is truncated.
    ///
    /// ```
    /// Int8(-127).negatedReportingOverflow() // -> (partialValue: Int8( 127), overflow: false)
    /// Int8(-128).negatedReportingOverflow() // -> (partialValue: Int8(-128), overflow: true )
    /// ```
    ///
    @inlinable func negatedReportingOverflow() -> PVO<Self>
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Unsigned
//*============================================================================*

public protocol ANKUnsignedFixedWidthInteger: ANKFixedWidthInteger, ANKUnsignedInteger { }
