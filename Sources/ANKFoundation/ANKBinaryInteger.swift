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

/// A `BinaryInteger` with additional requirements and capabilities.
///
/// All binary integers in `AwesomeNumbersKit` conform to `ANKBinaryInteger`.
///
/// **Two's Complement Semantics**
///
/// Like `BinaryInteger`, all bitwise operations have two's complement semantics.
///
public protocol ANKBinaryInteger: BinaryInteger, ANKBitPatternConvertible where Magnitude: ANKUnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit.
    ///
    /// - Returns: `bit ? 1 : 0`
    ///
    @inlinable init(bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns whether this value is equal to zero.
    ///
    /// - Returns: `self == 0`
    ///
    @inlinable var isZero: Bool { get }
    
    /// Returns whether this value is less than zero.
    ///
    /// - Returns: `self < 0`
    ///
    @inlinable var isLessThanZero: Bool { get }
    
    /// Returns whether this value is more than zero.
    ///
    /// - Returns: `self > 0`
    ///
    @inlinable var isMoreThanZero: Bool { get }
    
    /// Returns the most significant bit in two's complement form.
    ///
    /// - Note: If the value is signed, this is equivalent to `self.isLessThanZero`.
    ///
    /// - Returns: `self >> (self.bitWidth - 1) == 1`
    ///
    @inlinable var mostSignificantBit:  Bool { get }
    
    /// Returns the least significant bit in two's complement form.
    ///
    /// - Note: It returns `true` if the value is odd and `false` if the value is even.
    ///
    /// - Returns: `self & 1 == 1`
    ///
    @inlinable var leastSignificantBit: Bool { get }
    
    /// Returns whether this value is a power of `2`.
    ///
    /// - Returns: `self.nonzeroBitCount == 1`
    ///
    @inlinable var isPowerOf2: Bool { get }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the quotient of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either truncated or, if undefined, this value.
    ///
    /// ```
    /// var a = Int(-128); a.divideReportingOverflow(by: 2) // a =  -64; -> false
    /// var b = Int(-128); b.divideReportingOverflow(by: 2) // b = -128; -> true
    /// var c = Int(-128); c.divideReportingOverflow(by: 2) // c = -128; -> true
    /// ```
    ///
    @inlinable mutating func divideReportingOverflow(by divisor: Self) -> Bool
    
    /// Returns the quotient of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either truncated or, if undefined, this value.
    ///
    /// ```
    /// Int8(-128).dividedReportingOverflow(by:  3) // (partialValue:  -42, overflow: false)
    /// Int8(-128).dividedReportingOverflow(by:  0) // (partialValue: -128, overflow: true )
    /// Int8(-128).dividedReportingOverflow(by: -1) // (partialValue: -128, overflow: true )
    /// ```
    ///
    @inlinable func dividedReportingOverflow(by divisor: Self) -> PVO<Self>
    
    /// Forms the remainder of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either the entire remainder or, if undefined,
    /// this value.
    ///
    /// ```
    /// var a = Int8(-128); a.formRemainderReportingOverflow(dividingBy:  3) // a =  002; -> false
    /// var b = Int8(-128); b.formRemainderReportingOverflow(dividingBy:  0) // b = -128; -> true
    /// var c = Int8(-128); c.formRemainderReportingOverflow(dividingBy: -1) // c =  000; -> true
    /// ```
    ///
    @inlinable mutating func formRemainderReportingOverflow(dividingBy divisor: Self) -> Bool
    
    /// Returns the remainder of this value divided by the given value, and
    /// returns a value indicating whether overflow occurred. In the case of
    /// overflow, the result is either the entire remainder or, if undefined,
    /// this value.
    ///
    /// ```
    /// Int8(-128).remainderReportingOverflow(dividingBy:  3) // (partialValue:  002, overflow: false)
    /// Int8(-128).remainderReportingOverflow(dividingBy:  0) // (partialValue: -128, overflow: true )
    /// Int8(-128).remainderReportingOverflow(dividingBy: -1) // (partialValue:  000, overflow: true )
    /// ```
    ///
    @inlinable func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self>
    
    /// Returns the quotient and remainder of this value divided by the given value.
    ///
    /// ```
    /// Int8( 7).quotientAndRemainder(dividingBy:  3) // (quotient:  2, remainder:  1)
    /// Int8( 7).quotientAndRemainder(dividingBy: -3) // (quotient: -2, remainder:  1)
    /// Int8(-7).quotientAndRemainder(dividingBy:  3) // (quotient: -2, remainder: -1)
    /// Int8(-7).quotientAndRemainder(dividingBy: -3) // (quotient:  2, remainder: -1)
    /// ```
    ///
    @inlinable func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Two's Complement
    //=------------------------------------------------------------------------=
    
    /// Forms the two's complement of this value.
    ///
    /// - Returns: `self = ~self &+ 1`
    ///
    @inlinable mutating func formTwosComplement()
    
    /// Creates the two's complement of this value.
    ///
    /// - Returns: `~self &+ 1`
    ///
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

public protocol ANKSignedInteger: ANKBinaryInteger, SignedInteger { }

//*============================================================================*
// MARK: * ANK x Binary Integer x Unsigned
//*============================================================================*

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
