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

/// An awesome, fixed-width, binary integer.
///
/// ### Two's Complement
///
/// Like `BinaryInteger`, it has [two's complement][2s] semantics.
///
/// - The two's complement representation of `+0` is an infinite sequence of `0s`.
/// - The two's complement representation of `-1` is an infinite sequence of `1s`.
///
/// [2s]: https://en.wikipedia.org/wiki/Two%27s_complement
///
public protocol ANKFixedWidthInteger: ANKBinaryInteger, FixedWidthInteger where Digit: ANKFixedWidthInteger,
Magnitude: ANKFixedWidthInteger, Magnitude.BitPattern == BitPattern {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance repeating the given bit, in two's complement form.
    ///
    /// ```swift
    /// Int8(repeating: false) // Int8( 0)
    /// Int8(repeating: true ) // Int8(-1)
    /// ```
    ///
    @inlinable init(repeating bit: Bool)
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding the given value to this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int8(126); a.addReportingOverflow(Int8(1)) // a = Int8( 127); -> false
    /// var b: Int8(127); b.addReportingOverflow(Int8(1)) // b = Int8(-128); -> true
    /// ```
    ///
    @inlinable mutating func addReportingOverflow(_ amount: Self) -> Bool
    
    /// Forms the sum of adding the given value to this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int256(32); a.addReportingOverflow(Int(1)) // a = Int256(33); -> false
    /// var b: Int256.max; b.addReportingOverflow(Int(1)) // b = Int256.min; -> true
    /// ```
    ///
    @_disfavoredOverload @inlinable mutating func addReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the sum of adding the given value to this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(32).addingReportingOverflow(Int256(1)) // (partialValue: Int256(33), overflow: false)
    /// Int256.max.addingReportingOverflow(Int256(1)) // (partialValue: Int256.min, overflow: true )
    /// ```
    ///
    @inlinable func addingReportingOverflow(_ amount: Self) -> PVO<Self>
    
    /// Returns the sum of adding the given value to this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(32).addingReportingOverflow(Int(1)) // (partialValue: Int256(33), overflow: false)
    /// Int256.max.addingReportingOverflow(Int(1)) // (partialValue: Int256.min, overflow: true )
    /// ```
    ///
    @_disfavoredOverload @inlinable func addingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=
    
    /// Forms the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int8(-127); a.subtractReportingOverflow(1) // a = -128; -> false
    /// var b: Int8(-128); b.subtractReportingOverflow(1) // b =  127; -> true
    /// ```
    ///
    @inlinable mutating func subtractReportingOverflow(_ amount: Self) -> Bool
    
    /// Forms the difference of subtracting the given value from this value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a: Int256(33); a.subtractReportingOverflow(Int(1)) // a = Int256(32); -> false
    /// var b: Int256.min; b.subtractReportingOverflow(Int(1)) // b = Int256.max; -> true
    /// ```
    ///
    @_disfavoredOverload @inlinable mutating func subtractReportingOverflow(_ amount: Digit) -> Bool
    
    /// Returns the difference of subtracting the given value from this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(33).subtractingReportingOverflow(Int256(1)) // (partialValue: Int256(32), overflow: false)
    /// Int256.min.subtractingReportingOverflow(Int256(1)) // (partialValue: Int256.max, overflow: true )
    /// ```
    ///
    @inlinable func subtractingReportingOverflow(_ amount: Self) -> PVO<Self>
    
    /// Returns the difference of subtracting the given value from this value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(33).subtractingReportingOverflow(Int(1)) // (partialValue: Int256(32), overflow: false)
    /// Int256.min.subtractingReportingOverflow(Int(1)) // (partialValue: Int256.max, overflow: true )
    /// ```
    ///
    @_disfavoredOverload @inlinable func subtractingReportingOverflow(_ amount: Digit) -> PVO<Self>
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying this value by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a = Int8(11); a.multiplyReportingOverflow(by: Int8(4)) // a = Int8(44); -> false
    /// var b = Int8.max; b.multiplyReportingOverflow(by: Int8(4)) // b = Int8(-4); -> true
    /// ```
    ///
    @inlinable mutating func multiplyReportingOverflow(by amount: Self) -> Bool
    
    /// Forms the product of multiplying this value by the given value,
    /// and returns a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// var a = Int256(11); a.multiplyReportingOverflow(by: Int(4)) // a = Int256(44); -> false
    /// var b = Int256.max; b.multiplyReportingOverflow(by: Int(4)) // b = Int256(-4); -> true
    /// ```
    ///
    @_disfavoredOverload @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool
    
    /// Returns the product of multiplying this value by the given value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(11).multipliedReportingOverflow(by: Int256(4)) // (partialValue: Int256(44), overflow: false)
    /// Int256.max.multipliedReportingOverflow(by: Int256(4)) // (partialValue: Int256(-4), overflow: true )
    /// ```
    ///
    @inlinable func multipliedReportingOverflow(by amount: Self) -> PVO<Self>
    
    /// Returns the product of multiplying this value by the given value,
    /// along with a value indicating whether overflow occurred.
    /// In the case of overflow, the result is truncated.
    ///
    /// ```swift
    /// Int256(11).multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(44), overflow: false)
    /// Int256.max.multipliedReportingOverflow(by: Int(4)) // (partialValue: Int256(-4), overflow: true )
    /// ```
    ///
    @_disfavoredOverload @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self>
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```swift
    /// var a = Int8(11); a.multiplyFullWidth(by: Int8(4)) // a = Int8(44); -> Int8(0)
    /// var b = Int8.max; b.multiplyFullWidth(by: Int8(4)) // b = Int8(-4); -> Int8(1)
    /// ```
    ///
    @inlinable mutating func multiplyFullWidth(by amount: Self) -> Self
    
    /// Forms the low part of multiplying this value by the given value,
    /// and returns the high.
    ///
    /// ```swift
    /// var a = Int256(11); a.multiplyFullWidth(by: Int(4)) // a = Int256(44); -> Int(0)
    /// var b = Int256.max; b.multiplyFullWidth(by: Int(4)) // b = Int256(-4); -> Int(1)
    /// ```
    ///
    @_disfavoredOverload @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit
    
    /// Returns the low and high part of multiplying this value by the given value.
    ///
    /// ```swift
    /// Int256(11).multipliedFullWidth(by: Int256(4)) // (high: Int(0), low:  UInt256(44))
    /// Int256.max.multipliedFullWidth(by: Int256(4)) // (high: Int(1), low: ~UInt256( 3))
    /// ```
    ///
    @inlinable func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude>
    
    /// Returns the low and high part of multiplying this value by the given value.
    ///
    /// ```swift
    /// Int256(11).multipliedFullWidth(by: Int(4)) // (high: Int(0), low:  UInt256(44))
    /// Int256.max.multipliedFullWidth(by: Int(4)) // (high: Int(1), low: ~UInt256( 3))
    /// ```
    ///
    @_disfavoredOverload @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude>
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns whether this value is a power of `2`.
    @_transparent public var isPowerOf2: Bool {
        self.nonzeroBitCount == 1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Addition
    //=------------------------------------------------------------------------=
    
    /// Forms the sum of adding `rhs` to `lhs`.
    ///
    /// ```swift
    /// var a = Int8(1); a += Int8(2) // a = Int8(3)
    /// var b = Int8(2); b += Int8(3) // b = Int8(5)
    /// var c = Int8(3); c += Int8(4) // c = Int8(7)
    /// var d = Int8(4); d += Int8(5) // d = Int8(9)
    /// ```
    ///
    @_transparent public static func +=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.addReportingOverflow(rhs)
        precondition(!overflow)
    }
    
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
    /// Int8(1) + Int8(2) // Int8(3)
    /// Int8(2) + Int8(3) // Int8(5)
    /// Int8(3) + Int8(4) // Int8(7)
    /// Int8(4) + Int8(5) // Int8(9)
    /// ```
    ///
    @_transparent public static func +(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.addingReportingOverflow(rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
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
    /// var a: Int8(126); a &+= Int8(1) // a = Int8( 127)
    /// var b: Int8(127); b &+= Int8(1) // b = Int8(-128)
    /// ```
    ///
    @_transparent public static func &+=(lhs: inout Self, rhs: Self) {
        _ = lhs.addReportingOverflow(rhs)
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
    /// Int8(126) &+ Int8(1) // Int8( 127)
    /// Int8(127) &+ Int8(1) // Int8(-128)
    /// ```
    ///
    @_transparent public static func &+(lhs: Self, rhs: Self) -> Self {
        lhs.addingReportingOverflow(rhs).partialValue
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
    // MARK: Details x Subtraction
    //=------------------------------------------------------------------------=
    
    /// Forms the difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// var a = Int8(3); a -= Int8(2) // a = Int8(1)
    /// var b = Int8(5); b -= Int8(3) // b = Int8(2)
    /// var c = Int8(7); c -= Int8(4) // c = Int8(3)
    /// var d = Int8(9); d -= Int8(5) // d = Int8(4)
    /// ```
    ///
    @_transparent public static func -=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.subtractReportingOverflow(rhs)
        precondition(!overflow)
    }
    
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
    /// Int8(3) - Int8(2) // Int8(1)
    /// Int8(5) - Int8(3) // Int8(2)
    /// Int8(7) - Int8(4) // Int8(3)
    /// Int8(9) - Int8(5) // Int8(4)
    /// ```
    ///
    @_transparent public static func -(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.subtractingReportingOverflow(rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
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
    /// var a: Int8(-127); a &-= Int8(1) // a = Int8(-128)
    /// var b: Int8(-128); b &-= Int8(1) // b = Int8( 127)
    /// ```
    ///
    @_transparent public static func &-=(lhs: inout Self, rhs: Self) {
        _ = lhs.subtractReportingOverflow(rhs)
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
    
    /// Forms the truncated difference of subtracting `rhs` from `lhs`.
    ///
    /// ```swift
    /// Int8(-127) &- Int8(1) // Int8(-128)
    /// Int8(-128) &- Int8(1) // Int8( 127)
    /// ```
    ///
    @_transparent public static func &-(lhs: Self, rhs: Self) -> Self {
        lhs.subtractingReportingOverflow(rhs).partialValue
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
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Multiplication
    //=------------------------------------------------------------------------=
    
    /// Forms the product of multiplying `lhs` by `rhs`.
    ///
    /// ```swift
    /// var a = Int8(1); a *= Int8(2) // a = Int8( 2)
    /// var b = Int8(2); b *= Int8(3) // b = Int8( 6)
    /// var c = Int8(3); c *= Int8(4) // c = Int8(12)
    /// var d = Int8(4); d *= Int8(5) // d = Int8(20)
    /// ```
    ///
    @_transparent public static func *=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.multiplyReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
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
    /// Int8(1) * Int8(2) // Int8( 2)
    /// Int8(2) * Int8(3) // Int8( 6)
    /// Int8(3) * Int8(4) // Int8(12)
    /// Int8(4) * Int8(5) // Int8(20)
    /// ```
    ///
    @_transparent public static func *(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
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
    /// var a = Int8(11); a &*= Int8(4) // a = Int8(44)
    /// var b = Int8.max; b &*= Int8(4) // b = Int8(-4)
    /// ```
    ///
    @_transparent public static func &*=(lhs: inout Self, rhs: Self) {
        _ = lhs.multiplyReportingOverflow(by: rhs)
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
    /// Int8(11) &* Int8(4) // Int8(44)
    /// Int8.max &* Int8(4) // Int8(-4)
    /// ```
    ///
    @_transparent public static func &*(lhs: Self, rhs: Self) -> Self {
        lhs.multipliedReportingOverflow(by: rhs).partialValue
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
}

//=----------------------------------------------------------------------------=
// MARK: + Details x Sign & Magnitude
//=----------------------------------------------------------------------------=

extension ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
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
        let isLessThanZero = source.isLessThanZero
        if  Self.isSigned  {
            self.init(bitPattern: source.magnitude)
            if  isLessThanZero {  self.formTwosComplement()  }
            if  isLessThanZero != self.isLessThanZero { return nil }
        }   else {
            if  isLessThanZero {  return nil  }
            self.init(bitPattern: source.magnitude)
        }
    }
    
    /// Creates a new instance with the representable value closest to the given integer.
    ///
    /// If the value passed as source is greater than the maximum representable value,
    /// the result is this type’s max value. If value passed as source is less than the
    /// smallest representable value, the result is this type’s min value.
    ///
    @inlinable public init(clamping source: ANKSigned<Magnitude>) {
        if  Self.isSigned {
            let isLessThanZero =  source.isLessThanZero
            self.init(bitPattern: source.magnitude)
            if  isLessThanZero {  self.formTwosComplement()  }
            if  isLessThanZero != self.isLessThanZero { self = isLessThanZero ? Self.min : Self.max }
        }   else {
            self.init(bitPattern: source.sign.bit ? Magnitude() : source.magnitude)
        }
    }
    
    /// Creates a new instance from the two's complement bit pattern of the given integer.
    ///
    /// - The two's complement representation of `+0` is an infinite sequence of `0s`.
    /// - The two's complement representation of `-1` is an infinite sequence of `1s`.
    ///
    @inlinable public init(truncatingIfNeeded source: ANKSigned<Magnitude>) {
        self.init(bitPattern: source.magnitude)
        if  source.sign.bit { self.formTwosComplement() }
    }
}
