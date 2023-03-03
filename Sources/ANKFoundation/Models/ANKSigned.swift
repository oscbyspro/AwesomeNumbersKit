//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Signed
//*============================================================================*

/// A decorative, width agnostic, sign-and-magnitude, numeric integer.
///
/// It stores a sign and a magnitude and has sign-and-magnitude semantics. The
/// sign bit is treated as separate, meaning that overflow does not affect it.
///
/// ### Positive & Negative Zero
///
/// Zero is signed and can therefore have either a positive or negative sign.
/// Both representations are `==` to each other and have the same `hashValue`.
/// This is enables sign transformations such as ``sign``.``ANKSign/toggle()``
/// when ``magnitude``.``ANKBinaryInteger/isZero``.
///
/// - use ``isLessThanZero`` to check if the integer is `negative`
/// - use ``isMoreThanZero`` to check if the integer is `positive`
///
/// ### Single Digit Arithmetic
///
/// This model offers `Self` x `Digit` methods alongside its `Self` x `Self`
/// methods. These may prove much faster than their oversized counterparts for
/// operands that fit in a machine word.
///
/// - Note: The `Digit` type is `ANKSigned<Magnitude.Digit>` when it exists.
///
/// ### Expressible by Integer vs String Literal
///
/// ```
/// await .biggerIntegerLiterals() // Swift 5.8
/// ```
///
@frozen public struct ANKSigned<Magnitude>: Comparable, Hashable where Magnitude: ANKUnsignedInteger, Magnitude == Magnitude.Magnitude {
    
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
    public var sign: ANKSign
    
    /// The magnitude of this value.
    public var magnitude: Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance with a positive zero value.
    @inlinable public init() {
        self.init(Magnitude(), as: ANKSign.plus)
    }
    
    /// Creates a new instance with the given sign and magnitude.
    @inlinable public init(_ magnitude: Magnitude, as sign: ANKSign) {
        self.sign = sign; self.magnitude = magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Normalization
    //=------------------------------------------------------------------------=
    
    /// Returns `true` for all values except negative zero where it returns `false`.
    @inlinable public var isNormal: Bool {
        self.sign == ANKSign.plus || !self.isZero
    }
    
    /// Returns the ``ANKSigned/sign`` when ``ANKSigned/isNormal``, and ``ANKSign/plus`` otherwise.
    @inlinable public var normalizedSign: ANKSign {
        self.isNormal ? self.sign : ANKSign.plus
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Comparison
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func ==(lhs: Self, rhs: Self) -> Bool {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            return lhs.isZero && rhs.isZero
        }
        //=--------------------------------------=
        return lhs.magnitude == rhs.magnitude
    }
    
    @inlinable public static func <(lhs: Self, rhs: Self) -> Bool {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            return (lhs.sign != ANKSign.plus) && !(lhs.isZero && rhs.isZero)
        }
        //=--------------------------------------=
        return (lhs.sign == ANKSign.plus) == (lhs.magnitude < rhs.magnitude)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns `1` if this value is positive, `-1` if it is negative, and `0` otherwise.
    @inlinable public func signum() -> Int {
        self.isZero ? 0 : self.sign == ANKSign.plus ? 1 : -1
    }
    
    /// Returns whether this value is equal to zero.
    @_transparent public var isZero: Bool {
        self.magnitude.isZero
    }
    
    /// Returns whether this value is less than zero.
    @inlinable public var isLessThanZero: Bool {
        self.sign != ANKSign.plus && !self.isZero
    }
    
    /// Returns whether this value is more than zero.
    @inlinable public var isMoreThanZero: Bool {
        self.sign == ANKSign.plus && !self.isZero
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(self.magnitude)
        hasher.combine(self.normalizedSign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// The minimum representable value in this type.
    @inlinable public static var min: Self {
        Self(Magnitude.max, as: ANKSign.minus)
    }
    
    /// The maximum representable value in this type.
    @inlinable public static var max: Self {
        Self(Magnitude.max, as: ANKSign.plus)
    }
}
