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
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKBinaryInteger: BinaryInteger, ANKBitPatternConvertible where Magnitude: ANKUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit.
    ///
    /// ```
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
    
    /// Forms the quotient of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either truncated or, if undefined, this value.
    ///
    /// ```
    /// var a = Int8(-128); a.divideReportingOverflow(by:  3)) // a = Int8( -42); -> false
    /// var b = Int8(-128); b.divideReportingOverflow(by:  0)) // b = Int8(-128); -> true
    /// var c = Int8(-128); c.divideReportingOverflow(by: -1)) // c = Int8(-128); -> true
    /// ```
    ///
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool
    
    /// Returns the quotient of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either truncated or, if undefined, this value.
    ///
    /// ```
    /// Int8(-128).dividedReportingOverflow(by: Int8( 3)) // (partialValue: Int8( -42), overflow: false)
    /// Int8(-128).dividedReportingOverflow(by: Int8( 0)) // (partialValue: Int8(-128), overflow: true )
    /// Int8(-128).dividedReportingOverflow(by: Int8(-1)) // (partialValue: Int8(-128), overflow: true )
    /// ```
    ///
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self>
    
    /// Forms the remainder of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either the entire remainder or, if undefined,
    /// this value.
    ///
    /// ```
    /// var a = Int8(-128); a.formRemainderReportingOverflow(dividingBy:  3) // a = Int8(   2); -> false
    /// var b = Int8(-128); b.formRemainderReportingOverflow(dividingBy:  0) // b = Int8(-128); -> true
    /// var c = Int8(-128); c.formRemainderReportingOverflow(dividingBy: -1) // c = Int8(   0); -> true
    /// ```
    ///
    @inlinable mutating func formRemainderReportingOverflow(dividingBy divisor: Self) -> Bool
    
    /// Returns the remainder of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either the entire remainder or, if undefined,
    /// this value.
    ///
    /// ```
    /// Int8(-128).remainderReportingOverflow(dividingBy:  3) // (partialValue: Int8(   2), overflow: false)
    /// Int8(-128).remainderReportingOverflow(dividingBy:  0) // (partialValue: Int8(-128), overflow: true )
    /// Int8(-128).remainderReportingOverflow(dividingBy: -1) // (partialValue: Int8(   0), overflow: true )
    /// ```
    ///
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self>
    
    /// Returns the quotient and remainder of this value divided by the given value.
    ///
    /// ```
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
    init(_ source: ANKSigned<Magnitude>)
    
    /// Creates a new instance from the given integer, if it is representable.
    ///
    /// If the value passed as source is not representable, the result is nil.
    ///
    init?(exactly source: ANKSigned<Magnitude>)
    
    /// Creates a new instance with the representable value closest to the given integer.
    ///
    /// If the value passed as source is greater than the maximum representable value,
    /// the result is this type’s max value. If value passed as source is less than the
    /// smallest representable value, the result is this type’s min value.
    ///
    init(clamping source: ANKSigned<Magnitude>)
    
    /// Creates a new instance from the two's complement bit pattern of the given integer.
    ///
    /// - The two's complement representation of `+0` contains an infinite number of `0s`.
    /// - The two's complement representation of `-1` contains an infinite number of `1s`.
    ///
    init(truncatingIfNeeded source: ANKSigned<Magnitude>)
}

//*============================================================================*
// MARK: * ANK x Binary Integer x Signed
//*============================================================================*

/// An awesome signed integer.
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKSignedInteger: ANKBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * ANK x Binary Integer x Unsigned
//*============================================================================*

/// An awesome unsigned integer.
///
/// Like `BinaryInteger`, its bitwise operations have two's complement semantics.
///
public protocol ANKUnsignedInteger: ANKBinaryInteger, UnsignedInteger { }

//*============================================================================*
// MARK: * ANK x Binary Integer x Defaults
//*============================================================================*
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
}

//=----------------------------------------------------------------------------=
// MARK: Details x Sign & Magnitude
//=----------------------------------------------------------------------------=

extension ANKBinaryInteger where Magnitude.BitPattern == BitPattern {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ source: ANKSigned<Magnitude>) {
        guard let value = Self(exactly: source) else {
            preconditionFailure("\(source) is not in \(Self.self)'s representable range")
        }
        
        self = value
    }
    
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
    
    @inlinable public init(clamping source: ANKSigned<Magnitude>) where Self: FixedWidthInteger {
        let sourceIsLessThanZero = source.isLessThanZero
        //=--------------------------------------=
        if  Self.isSigned {
            self.init(bitPattern: source.magnitude)
            if sourceIsLessThanZero {  self.formTwosComplement()  }
            if sourceIsLessThanZero != self.isLessThanZero { self = sourceIsLessThanZero ? .min : .max }
        //=--------------------------------------=
        }   else {
            if sourceIsLessThanZero {  self.init(); return }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    @inlinable public init(truncatingIfNeeded source: ANKSigned<Magnitude>) {
        let sourceIsLessThanZero = source.isLessThanZero
        self.init(bitPattern: source.magnitude)
        if  sourceIsLessThanZero { self.formTwosComplement() }
    }
}
