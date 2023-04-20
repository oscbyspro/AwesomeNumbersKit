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

/// An awesome, large, fixed-width, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKLargeFixedWidthInteger<Digit>: ANKFixedWidthInteger, ANKLargeBinaryInteger where
Digit: ANKFixedWidthInteger, Magnitude: ANKUnsignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the given value to this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int256(32); a.addReportingOverflow(Int(1)) // a = Int256(33); -> false
    /// var b: Int256.max; b.addReportingOverflow(Int(1)) // b = Int256.min; -> true
    /// ```
    ///
    @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the sum of adding the given value to this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(32).addingReportingOverflow(Int(1)) // (partialValue: Int256(33), overflow: false)
    /// Int256.max.addingReportingOverflow(Int(1)) // (partialValue: Int256.min, overflow: true )
    /// ```
    ///
    @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying this value by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a = Int256(11); a.multiplyReportingOverflow(by: Int(4)) // a = Int256(44); -> false
    /// var b = Int256.max; b.multiplyReportingOverflow(by: Int(4)) // b = Int256(-4); -> true
    /// ```
    ///
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool
    
    /// Returns the product of multiplying this value by the given value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(11).multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(44), overflow: false)
    /// Int256.max.multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(-4), overflow: true )
    /// ```
    ///
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self>
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```swift
    /// var a = Int256(11); a.multiplyFullWidth(by: Int(4)) // a = Int256(44); -> Int(0)
    /// var b = Int256.max; b.multiplyFullWidth(by: Int(4)) // b = Int256(-4); -> Int(1)
    /// ```
    ///
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit
    
    /// Returns the low and high part of multiplying this value by the given value.
    ///
    /// ```swift
    /// Int256(11).multipliedFullWidth(by: Int(4)) // (high: Int(0), low:  UInt256(44))
    /// Int256.max.multipliedFullWidth(by: Int(4)) // (high: Int(1), low: ~UInt256( 3))
    /// ```
    ///
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=

    /// Forms the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int256(33); a.subtractReportingOverflow(Int(1)) // a = Int256(32); -> false
    /// var b: Int256.min; b.subtractReportingOverflow(Int(1)) // b = Int256.max; -> true
    /// ```
    ///
    @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the difference of subtracting the given value from this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(33).subtractingReportingOverflow(Int(1)) // (partialValue: Int256(32), overflow: false)
    /// Int256.min.subtractingReportingOverflow(Int(1)) // (partialValue: Int256.max, overflow: true )
    /// ```
    ///
    @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding `rhs` to `lhs`.
    ///
    /// ```swift
    /// var a = Int256(1); a += Int(2) // a = Int256(3)
    /// var b = Int256(2); b += Int(3) // b = Int256(5)
    /// var c = Int256(3); c += Int(4) // c = Int256(7)
    /// var d = Int256(4); d += Int(5) // d = Int256(9)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func +=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.addReportingOverflow(rhs)
        precondition(!overflow)
    }
    
    /// Returns the sum of adding `rhs` to `lhs`.
    ///
    /// ```swift
    /// Int256(1) + Int(2) // Int256(3)
    /// Int256(2) + Int(3) // Int256(5)
    /// Int256(3) + Int(4) // Int256(7)
    /// Int256(4) + Int(5) // Int256(9)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func +(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    /// Forms the truncated sum of adding `rhs` to `lhs`.
    ///
    /// ```swift
    /// var a: Int256(32); a &+= Int(1) // a = Int256(33)
    /// var b: Int256.max; b &+= Int(1) // b = Int256.min
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &+=(lhs: inout Self, rhs: Digit) {
        _ = lhs.addReportingOverflow(rhs)
    }
    
    /// Returns the truncated sum of adding `rhs` to `lhs`.
    ///
    /// ```swift
    /// Int256(32) &+ Int(1) // Int256(33)
    /// Int256.max &+ Int(1) // Int256.min
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &+(lhs: Self, rhs: Digit) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying `lhs` by `rhs`.
    ///
    /// ```swift
    /// var a = Int256(1); a *= Int(2) // a = Int256( 2)
    /// var b = Int256(2); b *= Int(3) // b = Int256( 6)
    /// var c = Int256(3); c *= Int(4) // c = Int256(12)
    /// var d = Int256(4); d *= Int(5) // d = Int256(20)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func *=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.multiplyReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    /// Returns the product of multiplying `lhs` by `rhs`.
    ///
    /// ```swift
    /// Int256(1) * Int(2) // Int256( 2)
    /// Int256(2) * Int(3) // Int256( 6)
    /// Int256(3) * Int(4) // Int256(12)
    /// Int256(4) * Int(5) // Int256(20)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func *(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    /// Forms the truncated product of multiplying `lhs` by `rhs`.
    ///
    /// ```swift
    /// var a = Int256(11); a &*= Int(4) // a = Int256(44)
    /// var b = Int256.max; b &*= Int(4) // b = Int256(-4)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &*=(lhs: inout Self, rhs: Digit) {
        _ = lhs.multiplyReportingOverflow(by: rhs)
    }
    
    /// Returns the truncated product of multiplying `lhs` by `rhs`.
    ///
    /// ```swift
    /// Int256(11) &* Int(4) // Int256(44)
    /// Int256.max &* Int(4) // Int256(-4)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &*(lhs: Self, rhs: Digit) -> Self {
        lhs.multipliedReportingOverflow(by: rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=
    
    /// Forms the difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// var a = Int256(3); a -= Int(2) // a = Int256(1)
    /// var b = Int256(5); b -= Int(3) // b = Int256(2)
    /// var c = Int256(7); c -= Int(4) // c = Int256(3)
    /// var d = Int256(9); d -= Int(5) // d = Int256(4)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func -=(lhs: inout Self, rhs: Digit) {
        let overflow: Bool = lhs.subtractReportingOverflow(rhs)
        precondition(!overflow)
    }
    
    /// Returns the difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// Int256(3) - Int(2) // Int256(1)
    /// Int256(5) - Int(3) // Int256(2)
    /// Int256(7) - Int(4) // Int256(3)
    /// Int256(9) - Int(5) // Int256(4)
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func -(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    /// Forms the truncated difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// var a: Int256(33); a &-= Int(1) // a = Int256(32)
    /// var b: Int256.min; b &-= Int(1) // b = Int256.max
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &-=(lhs: inout Self, rhs: Digit) {
        _ = lhs.subtractReportingOverflow(rhs)
    }
    
    /// Returns the truncated difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// Int256(33) &- Int(1) // Int256(32)
    /// Int256.min &- Int(1) // Int256.max
    /// ```
    ///
    @_disfavoredOverload @_transparent public static func &-(lhs: Self, rhs: Digit) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed
//*============================================================================*

/// An awesome, signed, large, fixed-width, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKSignedLargeFixedWidthInteger<Digit>: ANKLargeFixedWidthInteger,
ANKSignedFixedWidthInteger, ANKSignedLargeBinaryInteger where Digit: ANKSignedFixedWidthInteger { }

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned
//*============================================================================*

/// An awesome, unsigned, large, fixed-width, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKUnsignedLargeFixedWidthInteger<Digit>: ANKLargeFixedWidthInteger,
ANKUnsignedFixedWidthInteger, ANKUnsignedLargeBinaryInteger where Digit: ANKUnsignedFixedWidthInteger { }
