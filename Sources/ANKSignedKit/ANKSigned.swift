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
/// Zero is signed and can therefore have either a positive or negative sign.
/// Both representations are `==` to each other and have the same `hashValue`.
/// This is deliberate and enables sign transformations such as `sign.toggle()`
/// when `magnitude.isZero`.
///
/// - use `isLessThanZero` to check if the integer is negative
/// - use `isMoreThanZero` to check if the integer is positive
/// - the integer literal `-0` creates a positive zero because: `Swift`
///
/// **Two's Complement Semantics**
///
/// Since it conforms to `(ANK)BinaryInteger`, all its related bitwise operations
/// have two's complement semantics. All operations with sign-magnitude semantics
/// are distinct from those provided by `(ANK)BinaryInteger`.
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
        self.init(Magnitude(), as: ANKSign.plus)
    }
    
    @inlinable public init(bit: Bool) {
        self.init(Magnitude(bit: bit), as: ANKSign.plus)
    }
    
    @inlinable public init(_ magnitude: Magnitude, as sign: ANKSign) {
        self.sign = sign; self.magnitude = magnitude
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
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(repeating bit: Bool) where Magnitude: ANKFixedWidthInteger {
        self.init(Magnitude(bit: bit), as: ANKSign(bit))
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Conditional Conformances
//*============================================================================*

extension ANKSigned: FixedWidthInteger where Magnitude: FixedWidthInteger { }
extension ANKSigned: LosslessStringConvertible where Magnitude: FixedWidthInteger { }
extension ANKSigned: ANKFixedWidthInteger where Magnitude: ANKFixedWidthInteger { }
