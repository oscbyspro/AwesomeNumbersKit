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
    
    /// Returns the most significant bit, in two's complement form.
    @inlinable var mostSignificantBit:  Bool { get }
    
    /// Returns the least significant bit, in two's complement form.
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
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given integer.
    ///
    /// If the value passed as source is not representable, an error may occur.
    ///
    @inlinable init(_ source: ANKSigned<Magnitude>)
    
    /// Creates a new instance from the given integer, if it is representable.
    ///
    /// If the value passed as source is not representable, the result is nil.
    ///
    @inlinable init?(exactly source: ANKSigned<Magnitude>)
    
    /// Creates a new instance with the representable value closest to the given integer.
    ///
    /// If the value passed as source is greater than the maximum representable value,
    /// the result is this type’s max value. If value passed as source is less than the
    /// smallest representable value, the result is this type’s min value.
    ///
    @inlinable init(clamping source: ANKSigned<Magnitude>)
    
    /// Creates a new instance from the two's complement bit pattern of the given integer.
    ///
    /// - The two's complement representation of `+0` is an infinite sequence of `0s`.
    /// - The two's complement representation of `-1` is an infinite sequence of `1s`.
    ///
    @inlinable init(truncatingIfNeeded source: ANKSigned<Magnitude>)
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

//=----------------------------------------------------------------------------=
// MARK: + Details where BitPattern is Magnitude.BitPattern
//=----------------------------------------------------------------------------=

extension ANKBinaryInteger where BitPattern == Magnitude.BitPattern {
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Sign & Magnitude
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given integer.
    ///
    /// If the value passed as source is not representable, an error may occur.
    ///
    @inlinable public init(_ source: ANKSigned<Magnitude>) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
    /// Creates a new instance from the given integer, if it is representable.
    ///
    /// If the value passed as source is not representable, the result is nil.
    ///
    @inlinable public init?(exactly source: ANKSigned<Magnitude>) {
        let sourceIsLessThanZero = source.isLessThanZero
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(bitPattern: source.magnitude)
            if sourceIsLessThanZero {  self.formTwosComplement()  }
            if sourceIsLessThanZero != self.isLessThanZero { return nil }
        //=--------------------------------------=
        }   else {
            if sourceIsLessThanZero {  return nil }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    /// Creates a new instance with the representable value closest to the given integer.
    ///
    /// If the value passed as source is greater than the maximum representable value,
    /// the result is this type’s max value. If value passed as source is less than the
    /// smallest representable value, the result is this type’s min value.
    ///
    @inlinable public init(clamping source: ANKSigned<Magnitude>) where Self: FixedWidthInteger {
        let sourceIsLessThanZero = source.isLessThanZero
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(bitPattern: source.magnitude)
            if sourceIsLessThanZero {  self.formTwosComplement()  }
            if sourceIsLessThanZero != self.isLessThanZero { self = sourceIsLessThanZero ? Self.min : Self.max }
        //=--------------------------------------=
        }   else {
            if sourceIsLessThanZero {  self.init(); return }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    /// Creates a new instance from the two's complement bit pattern of the given integer.
    ///
    /// - The two's complement representation of `+0` is an infinite sequence of `0s`.
    /// - The two's complement representation of `-1` is an infinite sequence of `1s`.
    ///
    @inlinable public init(truncatingIfNeeded source: ANKSigned<Magnitude>) {
        let sourceIsLessThanZero = source.isLessThanZero
        self.init(bitPattern: source.magnitude)
        if  sourceIsLessThanZero { self.formTwosComplement() }
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
