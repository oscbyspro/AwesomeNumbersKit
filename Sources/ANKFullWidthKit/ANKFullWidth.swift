//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Full Width
//*============================================================================*

/// A composable, large, fixed-width, two's complement, binary integer.
///
/// ```swift
/// typealias  ANKInt256 = ANKFullWidth< ANKInt128, ANKUInt128>
/// typealias ANKUInt256 = ANKFullWidth<ANKUInt128, ANKUInt128>
/// ```
///
/// **Requirements**
///
/// It models a `UInt` digit collection. In practice this means:
///
/// ```
/// Low .bitWidth / UInt.bitWidth >= 1
/// High.bitWidth / UInt.bitWidth >= 1
///
/// Low .bitWidth % UInt.bitWidth == 0
/// High.bitWidth % UInt.bitWidth == 0
/// ```
///
/// **Fast Digit Arithmetic**
///
/// This model has a set of `Self` x `Digit` arithmetic methods in addition to its
/// `Self` x `Self` methods. These single-digit methods may prove much faster than
/// their oversized counterparts for operands that fit in a machine word.
///
/// Its `Digit` type is `Int` when `Self` is signed, and `UInt` otherwise.
///
/// **ExpressibleByStringLiteral vs ExpressibleByIntegerLiteral**
///
/// ```
/// await .biggerIntegerLiterals() // Swift 5.8
/// ```
///
@frozen public struct ANKFullWidth<High, Low>: ANKBigEndianTextCodable,
ANKContiguousBytes, ANKLargeFixedWidthInteger, ANKWords, CustomStringConvertible,
CustomDebugStringConvertible, ExpressibleByStringLiteral, MutableCollection where
High: ANKLargeFixedWidthInteger, Low: ANKUnsignedLargeFixedWidthInteger<UInt>,
High.Digit: ANKIntOrUInt, High.Magnitude.Digit == UInt, Low == Low.Magnitude {
    
    public typealias IntegerLiteralType = Int
    
    public typealias Digit = High.Digit
    
    public typealias BitPattern = Magnitude
    
    public typealias Magnitude = ANKFullWidth<High.Magnitude, Low>
    
    public typealias Plus1 = ANKFullWidth<Digit, Magnitude>
    
    public typealias DoubleWidth = ANKFullWidth<Self, Magnitude>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(descending: HL(High.min, Low.min))
    }
    
    @inlinable public static var max: Self {
        Self(descending: HL(High.max, Low.max))
    }
    
    @inlinable public static var zero: Self {
        Self()
    }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var high: High
    public var low:  Low
    #else
    public var low:  Low
    public var high: High
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(ascending  digits: LH<Low, High>) {
        (self.low, self.high) = digits
    }
    
    @inlinable public init(descending digits: HL<High, Low>) {
        (self.high, self.low) = digits
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init() {
        self.init(descending: HL(High(), Low()))
    }
    
    @inlinable public init(bit: Bool) {
        self.init(descending: HL(High(), Low(bit: bit)))
    }
    
    @inlinable public init(repeating bit: Bool) {
        self.init(bitPattern: bit ? Magnitude.max : Magnitude.min)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Bit Pattern
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bitPattern: BitPattern) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
    
    @_transparent public var bitPattern: BitPattern {
        return unsafeBitCast(self, to: BitPattern.self)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Conditional Conformances
//*============================================================================*

extension ANKFullWidth:   SignedNumeric where High:   SignedNumeric { }
extension ANKFullWidth:   SignedInteger where High:   SignedInteger { }
extension ANKFullWidth: UnsignedInteger where High: UnsignedInteger { }

extension ANKFullWidth:   ANKSignedInteger where High:   ANKSignedInteger { }
extension ANKFullWidth: ANKUnsignedInteger where High: ANKUnsignedInteger { }

extension ANKFullWidth:   ANKSignedFixedWidthInteger where High:   ANKSignedFixedWidthInteger { }
extension ANKFullWidth: ANKUnsignedFixedWidthInteger where High: ANKUnsignedFixedWidthInteger { }

extension ANKFullWidth:   ANKSignedLargeBinaryInteger where High:   ANKSignedLargeBinaryInteger { }
extension ANKFullWidth: ANKUnsignedLargeBinaryInteger where High: ANKUnsignedLargeBinaryInteger { }

extension ANKFullWidth:   ANKSignedLargeFixedWidthInteger where High:   ANKSignedLargeFixedWidthInteger { }
extension ANKFullWidth: ANKUnsignedLargeFixedWidthInteger where High: ANKUnsignedLargeFixedWidthInteger { }
