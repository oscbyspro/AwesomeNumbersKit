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

/// A decorative, size agnostic, width agnostic, sign-magnitude, integer.
///
/// ```
/// import ANKFoundation
/// import ANKSignedKit
/// ```
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
/// **Sign & Magnitude Semantics**
///
/// It models a sign decorated magnitude and has sign-magnitude semantics.
///
@frozen public struct ANKSigned<Magnitude> where Magnitude: ANKUnsignedInteger {
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    public var sign: ANKSign
    public var magnitude: Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init() {
        self.init(Magnitude(), as: ANKSign.plus)
    }
    
    @inlinable public init(_ magnitude: Magnitude, as sign: ANKSign) {
        self.sign = sign; self.magnitude = magnitude
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isZero: Bool {
        self.magnitude.isZero
    }
    
    @inlinable public var isLessThanZero: Bool {
        self.sign != ANKSign.plus && !self.magnitude.isZero
    }
    
    @inlinable public var isMoreThanZero: Bool {
        self.sign == ANKSign.plus && !self.magnitude.isZero
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Details x Normalization
    //=------------------------------------------------------------------------=
    
    /// - Returns: `true` for all values except negative zero where it returns `false`
    @inlinable public var isNormal: Bool {
        self.sign == .plus || !self.isZero
    }
    
    /// - Returns: `sign` for all values except negative zero where it returns `plus`
    @inlinable public var normalizedSign: ANKSign {
        self.isNormal ? self.sign : ANKSign.plus
    }
}
