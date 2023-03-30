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
/// ``ANKFullWidth`` is a generic model for working with fixed-width integers larger than 64
/// bits. Its bit width is the combined bit width of its ``ANKFullWidth/High-swift.typealias``
/// and ``ANKFullWidth/Low-swift.typealias`` parts. In this way, you may construct any integer
/// size that is a multiple of `UInt.bitWidth`.
///
/// ```swift
/// typealias  Int256 = FullWidth< Int128, UInt128>
/// typealias UInt256 = FullWidth<UInt128, UInt128>
/// ```
///
/// ### Trivial UInt Collection
///
/// ``ANKFullWidth`` models a `UInt` collection with inline storage. The bit width of
/// its ``ANKFullWidth/High-swift.typealias`` and ``ANKFullWidth/Low-swift.typealias``
/// parts must therefore be multiplies of `UInt.bitWidth`. This requirement makes it possible
/// to operate on its words directly. While ``ANKFullWidth`` conforms to the `Collection`
/// protocol, the best way to access these words is by using the following methods — based on
/// custom, endian-sensitive, pointers:
///
/// - ``ANKFullWidth/withUnsafeWords(_:)``
/// - ``ANKFullWidth/withUnsafeMutableWords(_:)``
/// - ``ANKFullWidth/fromUnsafeMutableWords(_:)``
///
/// ### Single Digit Arithmetic
///
/// Alongside its ordinary arithmetic operations, ``ANKFullWidth`` also offers single digit
/// operations. These methods are more efficient, but they can only be used on operands that
/// fit in a machine word. See the following for more details:
///
/// - ``ANKLargeBinaryInteger``
/// - ``ANKLargeFixedWidthInteger``
/// - ``ANKSignedLargeBinaryInteger``
/// - ``ANKSignedLargeFixedWidthInteger``
/// - ``ANKUnsignedLargeBinaryInteger``
/// - ``ANKUnsignedLargeFixedWidthInteger``
///
/// - Note: The `Digit` type is `Int` when `Self` is signed, and `UInt` otherwise.
///
/// ### Expressible by Integer vs String Literal
///
/// ```swift
/// await .biggerIntegerLiterals() // Swift 5.8
/// ```
///
@frozen public struct ANKFullWidth<High, Low>: ANKBigEndianTextCodable,
ANKLargeFixedWidthInteger, ANKTrivialContiguousBytes, ANKWords, CustomStringConvertible,
CustomDebugStringConvertible, ExpressibleByStringLiteral, MutableCollection where
High: ANKLargeFixedWidthInteger, Low: ANKUnsignedLargeFixedWidthInteger<UInt>,
High.Digit: ANKIntOrUInt, High.Magnitude.Digit == UInt, Low == Low.Magnitude {
    
    /// The most significant part of this type.
    public typealias High = High
    
    /// The least significant part of this type.
    public typealias Low = Low
    
    /// The digit of this type.
    public typealias Digit = High.Digit
    
    /// The integer literal used to create instance of this type.
    public typealias IntegerLiteralType = Int
    
    /// The magnitude of this type.
    public typealias Magnitude = ANKFullWidth<High.Magnitude, Low>
    
    /// The bit pattern of this type.
    public typealias BitPattern = Magnitude
    
    /// An integer type with one more ``Digit`` than this type.
    public typealias Plus1 = ANKFullWidth<Digit, Magnitude>
    
    /// An integer type with double the width of this type.
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
