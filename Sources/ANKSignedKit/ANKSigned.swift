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
// MARK: * ANK x Signed
//*============================================================================*

/// A decorative, size agnostic, width agnostic, sign-magnitude, integer.
///
/// **Positive & Negative Zero**
///
/// Zero is signed can have therefore a positive or negative sign. Both
/// representations are `==` to each other and have the same `hashValue`.
/// This design is deliberate and allow you to perform transformations
/// such as `sign.toggle()` when `magnitude.isZero`.
///
/// - use `isLessThanZero` to check if the integer is negative
/// - use `isMoreThanZero` to check if the integer is positive
/// - the `-0` integer literal creates a positive zero value because `Swift`
///
@frozen public struct ANKSigned<Magnitude>: ANKSignedInteger where Magnitude: ANKUnsignedInteger, Magnitude.Magnitude == Magnitude {
    
    public typealias IntegerLiteralType = Int
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    #if _endian(big)
    public var sign: ANKSign
    public var magnitude: Magnitude
    #else
    public var magnitude: Magnitude
    public var sign: ANKSign
    #endif
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init() {
        self.sign = ANKSign.plus
        self.magnitude = Magnitude()
    }
    
    @inlinable public init(_ magnitude: Magnitude, as sign: ANKSign) {
        self.sign = sign
        self.magnitude = magnitude
    }
    
    @inlinable public init(bit: Bool) {
        self.sign = ANKSign.plus
        self.magnitude = Magnitude(bit: bit)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns `.plus` when `magnitude.isZero` and returns `sign` otherwise.
    @inlinable public var normalizedSign: ANKSign {
        self.magnitude.isZero ? ANKSign.plus : self.sign
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var min: Self {
        Self(Magnitude.max, as: ANKSign.minus)
    }
    
    @inlinable public static var max: Self {
        Self(Magnitude.max, as: ANKSign.plus)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Conditional Conformances
//*============================================================================*

extension ANKSigned: FixedWidthInteger, LosslessStringConvertible where Magnitude: FixedWidthInteger { }
