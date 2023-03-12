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
/// typealias  Int256 = FullWidth< Int128, UInt128>
/// typealias UInt256 = FullWidth<UInt128, UInt128>
/// ```
///
/// ### Single Digit Arithmetic
///
/// This model offers `Self` x `Digit` methods alongside its `Self` x `Self`
/// methods. These may prove much faster than their oversized counterparts for
/// operands that fit in a machine word.
///
/// - Note: The `Digit` type is `Int` when `Self` is signed, and `UInt` otherwise.
///
/// ### Requirements
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
/// ### Expressible by Integer vs String Literal
///
/// ```
/// await .biggerIntegerLiterals() // Swift 5.8
/// ```
///
@frozen public struct ANKFullWidth<High, Low>: ANKBigEndianTextCodable,
ANKLargeFixedWidthInteger, ANKTrivialContiguousBytes, ANKWords, CustomStringConvertible,
CustomDebugStringConvertible, ExpressibleByStringLiteral, MutableCollection where
High: ANKLargeFixedWidthInteger, Low: ANKUnsignedLargeFixedWidthInteger<UInt>,
High.Digit: ANKIntOrUInt, High.Magnitude.Digit == UInt, Low == Low.Magnitude {
    
    public typealias High = High
    
    public typealias Low = Low
    
    public typealias Digit = High.Digit
    
    public typealias IntegerLiteralType = Int
    
    public typealias Magnitude = ANKFullWidth<High.Magnitude, Low>
    
    public typealias BitPattern = Magnitude
    
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
    /// The most  significant part of this value.
    public var high: High
    /// The least significant part of this value.
    public var low:  Low
    #else
    /// The least significant part of this value.
    public var low:  Low
    /// The most  significant part of this value.
    public var high: High
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given partition.
    ///
    /// - Parameter ascending: An integer split into two parts, from least significant to most.
    ///
    @inlinable public init(ascending partition: LH<Low, High>) {
        (self.low, self.high) = partition
    }
    
    /// Creates a new instance from the given partition.
    ///
    /// - Parameter descending: An integer split into two parts, from most significant to least.
    ///
    @inlinable public init(descending partition: HL<High, Low>) {
        (self.high, self.low) = partition
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
