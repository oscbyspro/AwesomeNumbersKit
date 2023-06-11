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
// MARK: * ANK x Signed
//*============================================================================*

/// A decorative, width agnostic, sign-and-magnitude, numeric integer.
///
/// ```swift
/// typealias Magnitude = UInt
/// let min = ANKSigned(Magnitude.max, as: FloatingPointSign.minus)
/// let max = ANKSigned(Magnitude.max, as: FloatingPointSign.plus )
/// ```
///
/// ### Sign & Magnitude
///
/// ``ANKSigned`` models a sign and a magnitude that are independent of each other,
/// meaning that the sign is unaffected by fixed-width integer overflow. The following
/// illustrates its behavior:
///
/// ```swift
/// ANKSigned<UInt8>(255, as: FloatingPointSign.plus ) &+ 1 // +T.zero
/// ANKSigned<UInt8>(255, as: FloatingPointSign.minus) &- 1 // -T.zero
/// ```
///
/// ### Positive Zero & Negative Zero
///
/// Zero is signed, meaning that it can be either positive or negative. These values
/// are comparatively equal and have the same `hashValue`. This makes it possible to
/// toggle the sign without checking for zero.
///
/// - use ``isLessThanZero`` to check if a value is `negative` and non-zero
/// - use ``isMoreThanZero`` to check if a value is `positive` and non-zero
///
/// ### Single Digit Arithmetic
///
/// Alongside its ordinary arithmetic operations, ``ANKSigned`` also offers single digit
/// operations. These methods are more efficient, but they can only be used on operands that
/// fit in a machine word. See the following for more details:
///
/// - ``ANKBinaryInteger``
/// - ``ANKFixedWidthInteger``
///
/// - Note: The `Digit` type is `ANKSigned<Magnitude.Digit>`.
///
@frozen public struct ANKSigned<Magnitude>: Comparable, Hashable, LosslessStringConvertible,
Sendable, SignedNumeric where Magnitude: ANKUnsignedInteger {
    
    public typealias Sign  = FloatingPointSign
    
    public typealias Digit = ANKSigned<Magnitude.Digit>
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// The positive zero value.
    ///
    /// Positive and negative zero are equal and have the same `hashValue`.
    ///
    @inlinable public static var zero: Self {
        Self()
    }
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    /// The sign of this value.
    public var sign: Sign
    
    /// The magnitude of this value.
    public var magnitude: Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance with a positive zero value.
    @inlinable public init() {
        self.init(Magnitude.zero, as: Sign.plus)
    }
    
    /// Creates a new instance with the given sign and magnitude.
    @inlinable public init(_ magnitude: Magnitude, as sign: Sign) {
        self.sign = sign; self.magnitude = magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Normalization
    //=------------------------------------------------------------------------=
    
    /// Returns `true` for all values except negative zero where it returns `false`.
    @inlinable public var isNormal: Bool {
        self.sign == Sign.plus || !self.isZero
    }
    
    /// Returns the ``ANKSigned/sign`` when ``ANKSigned/isNormal``, and `plus` otherwise.
    @inlinable public var normalizedSign: Sign {
        self.isNormal ? self.sign : Sign.plus
    }
}
