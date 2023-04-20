//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Binary Integer
//*============================================================================*

/// An awesome binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKBinaryInteger: ANKBitPatternConvertible, BinaryInteger, Sendable where Magnitude: ANKUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit.
    ///
    /// ```swift
    /// Int8(bit: false) // Int8(0)
    /// Int8(bit: true ) // Int8(1)
    /// ```
    ///
    @inlinable init(bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns whether this value is equal to zero.
    @inlinable var isZero: Bool { get }
    
    /// Returns whether this value is less than zero.
    @inlinable var isLessThanZero: Bool { get }
    
    /// Returns whether this value is more than zero.
    @inlinable var isMoreThanZero: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns the most significant bit, in two's complement form.
    ///
    /// ```swift
    /// mostSignificantBit == words.last!.mostSignificantBit // true
    /// ```
    ///
    @inlinable var mostSignificantBit: Bool { get }
    
    /// Returns the least significant bit, in two's complement form.
    ///
    /// ```swift
    /// leastSignificantBit == words.first!.leastSignificantBit // true
    /// ```
    ///
    @inlinable var leastSignificantBit: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns whether this value is odd.
    @inlinable var isOdd: Bool { get }
    
    /// Returns whether this value is even.
    @inlinable var isEven: Bool { get }
    
    /// Returns whether this value is a power of `2`.
    @inlinable var isPowerOf2: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Division
    //=------------------------------------------------------------------------=
    
    /// Forms the quotient of this value divided by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is either truncated or,
    /// if undefined, this value.
    ///
    /// ```swift
    /// var a = Int8(-128); a.divideReportingOverflow(by:  3)) // a = Int8( -42); -> false
    /// var b = Int8(-128); b.divideReportingOverflow(by:  0)) // b = Int8(-128); -> true
    /// var c = Int8(-128); c.divideReportingOverflow(by: -1)) // c = Int8(-128); -> true
    /// ```
    ///
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool
    
    /// Returns the quotient of this value divided by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is either truncated or,
    /// if undefined, this value.
    ///
    /// ```swift
    /// Int8(-128).dividedReportingOverflow(by: Int8( 3)) // (partialValue: Int8( -42), overflow: false)
    /// Int8(-128).dividedReportingOverflow(by: Int8( 0)) // (partialValue: Int8(-128), overflow: true )
    /// Int8(-128).dividedReportingOverflow(by: Int8(-1)) // (partialValue: Int8(-128), overflow: true )
    /// ```
    ///
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self>
    
    /// Forms the remainder of this value divided by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is either the entire remainder or,
    /// if undefined, this value.
    ///
    /// ```swift
    /// var a = Int8(-128); a.formRemainderReportingOverflow(dividingBy:  3) // a = Int8(   2); -> false
    /// var b = Int8(-128); b.formRemainderReportingOverflow(dividingBy:  0) // b = Int8(-128); -> true
    /// var c = Int8(-128); c.formRemainderReportingOverflow(dividingBy: -1) // c = Int8(   0); -> true
    /// ```
    ///
    @inlinable mutating func formRemainderReportingOverflow(dividingBy divisor: Self) -> Bool
    
    /// Returns the remainder of this value divided by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is either the entire remainder or,
    /// if undefined, this value.
    ///
    /// ```swift
    /// Int8(-128).remainderReportingOverflow(dividingBy:  3) // (partialValue: Int8(   2), overflow: false)
    /// Int8(-128).remainderReportingOverflow(dividingBy:  0) // (partialValue: Int8(-128), overflow: true )
    /// Int8(-128).remainderReportingOverflow(dividingBy: -1) // (partialValue: Int8(   0), overflow: true )
    /// ```
    ///
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self>
    
    /// Returns the quotient and remainder of this value divided by the given value.
    ///
    /// ```swift
    /// Int8( 7).quotientAndRemainder(dividingBy: Int8( 3)) // (quotient: Int8( 2), remainder: Int8( 1))
    /// Int8( 7).quotientAndRemainder(dividingBy: Int8(-3)) // (quotient: Int8(-2), remainder: Int8( 1))
    /// Int8(-7).quotientAndRemainder(dividingBy: Int8( 3)) // (quotient: Int8(-2), remainder: Int8(-1))
    /// Int8(-7).quotientAndRemainder(dividingBy: Int8(-3)) // (quotient: Int8( 2), remainder: Int8(-1))
    /// ```
    ///
    @inlinable func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    /// Forms the two's complement of this value.
    @inlinable mutating func formTwosComplement()
    
    /// Returns the two's complement of this value.
    @inlinable func twosComplement() -> Self
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKBinaryInteger where Self: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isOdd: Bool {
        self.leastSignificantBit
    }
    
    @_transparent public var isEven: Bool {
        self.leastSignificantBit == false
    }
    
    @_transparent public var isPowerOf2: Bool {
        self.nonzeroBitCount == 1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Division
    //=------------------------------------------------------------------------=
    
    /// Forms the quotient of dividing `lhs` by `rhs`.
    ///
    /// ```swift
    /// var a = Int8( 7); a /= Int8( 3) // a = Int8( 2)
    /// var b = Int8( 7); b /= Int8(-3) // b = Int8(-2)
    /// var c = Int8(-7); c /= Int8( 3) // c = Int8(-2)
    /// var d = Int8(-7); d /= Int8(-3) // d = Int8( 2)
    /// ```
    ///
    @_transparent public static func /=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.divideReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    /// Returns the quotient of dividing `lhs` by `rhs`.
    ///
    /// ```swift
    /// Int8( 7) / Int8( 3) // Int8( 2)
    /// Int8( 7) / Int8(-3) // Int8(-2)
    /// Int8(-7) / Int8( 3) // Int8(-2)
    /// Int8(-7) / Int8(-3) // Int8( 2)
    /// ```
    ///
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    /// Forms the remainder of dividing `lhs` by `rhs`.
    ///
    /// ```swift
    /// var a = Int8( 7); a %= Int8( 3) // a = Int8( 1)
    /// var b = Int8( 7); b %= Int8(-3) // b = Int8( 1)
    /// var c = Int8(-7); c %= Int8( 3) // c = Int8(-1)
    /// var d = Int8(-7); d %= Int8(-3) // d = Int8(-1)
    /// ```
    ///
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow)
    }
    
    /// Returns the remainder of dividing `lhs` by `rhs`.
    ///
    /// ```swift
    /// Int8( 7) % Int8( 3) // Int8( 1)
    /// Int8( 7) % Int8(-3) // Int8( 1)
    /// Int8(-7) % Int8( 3) // Int8(-1)
    /// Int8(-7) % Int8(-3) // Int8(-1)
    /// ```
    ///
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
}

//*============================================================================*
// MARK: * ANK x Binary Integer x Signed
//*============================================================================*

/// An awesome, signed, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKSignedInteger: ANKBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * ANK x Binary Integer x Unsigned
//*============================================================================*

/// An awesome, unsigned, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKUnsignedInteger: ANKBinaryInteger, UnsignedInteger { }
