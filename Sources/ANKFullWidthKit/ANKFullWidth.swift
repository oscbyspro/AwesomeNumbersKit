//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width
//*============================================================================*

/// A composable, large, fixed-width, two's complement, binary integer.
///
/// ``ANKFullWidth`` is a generic model for working with fixed-width integers larger than 64
/// bits. Its bit width is the combined bit width of its ``ANKFullWidth/High-swift.typealias``
/// and ``ANKFullWidth/Low-swift.typealias`` components. In this way, you may construct any integer
/// size that is a multiple of `UInt.bitWidth`.
///
/// ```swift
/// typealias  Int256 = ANKFullWidth< Int128, UInt128>
/// typealias UInt256 = ANKFullWidth<UInt128, UInt128>
/// ```
///
/// ### Trivial UInt Collection
///
/// ``ANKFullWidth`` models a `UInt` collection with inline storage. The bit width of
/// its ``ANKFullWidth/High-swift.typealias`` and ``ANKFullWidth/Low-swift.typealias``
/// components must therefore be multiplies of `UInt.bitWidth`. This requirement makes it possible
/// to operate on its words directly. While ``ANKFullWidth`` conforms to the `Collection`
/// protocol, the best way to access these words is with the following methods:
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
/// - ``ANKBinaryInteger``
/// - ``ANKFixedWidthInteger``
///
/// - Note: The `Digit` type is `Int` when `Self` is signed, and `UInt` otherwise.
///
@frozen public struct ANKFullWidth<High, Low>:
ANKFixedWidthInteger, MutableCollection, RandomAccessCollection where
High: ANKFixedWidthInteger, High.Digit: ANKCoreInteger<UInt>,
Low: ANKFixedWidthInteger & ANKUnsignedInteger, Low.Digit == UInt {
    
    /// The most  significant component of this type.
    public typealias High = High
    
    /// The least significant component of this type.
    public typealias Low = Low
    
    /// The digit of this type.
    public typealias Digit = High.Digit
    
    /// The magnitude of this type.
    public typealias Magnitude = ANKFullWidth<High.Magnitude, Low>
    
    /// The bit pattern of this type.
    public typealias BitPattern = Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var isSigned: Bool {
        High.isSigned
    }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    /// The most  significant component of this value.
    public var high: High
    /// The least significant component of this value.
    public var low:  Low
    #else
    /// The least significant component of this value.
    public var low:  Low
    /// The most  significant component of this value.
    public var high: High
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers x Components
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given `low` component.
    ///
    /// - Parameter low:  The least significant component of this value.
    ///
    @inlinable public init(low: Low) {
        self.init(low: low, high: High.zero)
    }
    
    /// Creates a new instance from the given `low` and `high` components.
    ///
    /// - Parameter low:  The least significant component of this value.
    /// - Parameter high: The most  significant component of this value.
    ///
    @inlinable public init(low: Low, high: High) {
        self.init(ascending: LH(low: low,  high: high))
    }
    
    /// Creates a new instance from the given `low` and `high` components.
    ///
    /// - Parameter ascending: Both components of this value, from least significant to most.
    ///
    @inlinable public init(ascending components: LH<Low, High>) {
        (self.low, self.high) = components
    }
    
    /// Creates a new instance from the given `high` component.
    ///
    /// - Parameter high: The most  significant component of this value.
    ///
    @inlinable public init(high: High) {
        self.init(high: high, low: Low.zero)
    }
    
    /// Creates a new instance from the given `high` and `low` components.
    ///
    /// - Parameter high: The most  significant component of this value.
    /// - Parameter low:  The least significant component of this value.
    ///
    @inlinable public init(high: High, low:  Low) {
        self.init(descending: HL(high: high, low: low))
    }
    
    /// Creates a new instance from the given `high` and `low` components.
    ///
    /// - Parameter descending: Both components of this value, from most significant to least.
    ///
    @inlinable public init(descending components: HL<High, Low>) {
        (self.high, self.low) = components
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors x Components
    //=------------------------------------------------------------------------=
    
    /// The `low` and `high` components of this value.
    @inlinable public var ascending: LH<Low, High> {
        get { (low: self.low, high: self.high) }
        set { (self.low, self.high) = newValue }
    }
    
    /// The `high` and `low` components of this value.
    @inlinable public var descending: HL<High, Low> {
        get { (high: self.high, low: self.low) }
        set { (self.high, self.low) = newValue }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Conditional Conformances
//*============================================================================*

extension ANKFullWidth:   ANKSignedInteger,   SignedInteger, SignedNumeric where High:   ANKSignedInteger { }
extension ANKFullWidth: ANKUnsignedInteger, UnsignedInteger  /*---------*/ where High: ANKUnsignedInteger { }

//*============================================================================*
// MARK: * ANK x [U]Int64
//*============================================================================*

extension ANK {
    
    #if arch(i386) || arch(arm) || arch(arm64_32) || arch(wasm32) || arch(powerpc)
    
    /// A signed, 64-bit, integer.
    public typealias Int64 = ANKFullWidth<Int, UInt>
    
    /// An unsigned, 64-bit, integer.
    public typealias UInt64 = ANKFullWidth<UInt, UInt>
    
    #elseif arch(x86_64) || arch(arm64) || arch(powerpc64) || arch(powerpc64le) || arch(s390x)
    
    /// A signed, 64-bit, integer.
    public typealias Int64 = Int
    
    /// An unsigned, 64-bit, integer.
    public typealias UInt64 = UInt
    
    #else
        
    #error("ANKFullWidth can only be used on a 32-bit or 64-bit platform.")
        
    #endif
}

//*============================================================================*
// MARK: * ANK x [U]Int128
//*============================================================================*

/// A signed, 128-bit, integer.
public typealias Int128 = ANKFullWidth<ANK.Int64, ANK.UInt64>

/// An unsigned, 128-bit, integer.
public typealias UInt128 = ANKFullWidth<ANK.UInt64, ANK.UInt64>

//*============================================================================*
// MARK: * ANK x [U]Int128
//*============================================================================*

/// A signed, 192-bit, integer.
public typealias Int192 = ANKFullWidth<ANK.Int64, UInt128>

/// An unsigned, 192-bit, integer.
public typealias UInt192 = ANKFullWidth<ANK.UInt64, UInt128>

//*============================================================================*
// MARK: * ANK x [U]Int256
//*============================================================================*

/// A signed, 256-bit, integer.
public typealias Int256 = ANKFullWidth<Int128, UInt128>

/// An unsigned, 256-bit, integer.
public typealias UInt256 = ANKFullWidth<UInt128, UInt128>

//*============================================================================*
// MARK: * ANK x [U]Int384
//*============================================================================*

/// A signed, 384-bit, integer.
public typealias Int384 = ANKFullWidth<Int192, UInt192>

/// An unsigned, 384-bit, integer.
public typealias UInt384 = ANKFullWidth<UInt192, UInt192>

//*============================================================================*
// MARK: * ANK x [U]Int512
//*============================================================================*

/// A signed, 512-bit, integer.
public typealias Int512 = ANKFullWidth<Int256, UInt256>

/// A signed, 512-bit, integer.
public typealias UInt512 = ANKFullWidth<UInt256, UInt256>

//*============================================================================*
// MARK: * ANK x [U]Int1024
//*============================================================================*

/// A signed, 1024-bit, integer.
public typealias Int1024 = ANKFullWidth<Int512, UInt512>

/// An unsigned, 1024-bit, integer.
public typealias UInt1024 = ANKFullWidth<UInt512, UInt512>

//*============================================================================*
// MARK: * ANK x [U]Int2048
//*============================================================================*

/// A signed, 2048-bit, integer.
public typealias Int2048 = ANKFullWidth<Int1024, UInt1024>

/// An unsigned, 2048-bit, integer.
public typealias UInt2048 = ANKFullWidth<UInt1024, UInt1024>

//*============================================================================*
// MARK: * ANK x [U]Int4096
//*============================================================================*

/// A signed, 4096-bit, integer.
public typealias Int4096 = ANKFullWidth<Int2048, UInt2048>

/// An unsigned, 4096-bit, integer.
public typealias UInt4096 = ANKFullWidth<UInt2048, UInt2048>
