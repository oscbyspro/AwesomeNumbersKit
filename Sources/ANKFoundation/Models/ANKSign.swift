//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Sign
//*============================================================================*

/// The sign of a numeric value.
///
/// Bitwise operations assume that `plus` equals `0` and `minus` equals `1`.
///
@frozen public enum ANKSign: CustomStringConvertible, Equatable {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    case plus
    case minus
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit.
    ///
    /// - Returns: `bit ? Self.minus : Self.plus`
    ///
    @inlinable public init(_ bit: Bool) {
        self = bit ? Self.minus : Self.plus
    }
    
    /// Creates a new instance from the given sign.
    ///
    /// - Returns: `sign == FloatingPointSign.plus ? Self.plus : Self.minus`
    ///
    @inlinable public init(_ sign: FloatingPointSign) {
        self = sign == FloatingPointSign.plus ? Self.plus : Self.minus
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var description: String {
        self == Self.plus ? "+" : "-"
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Toggles this variable’s value.
    ///
    /// Use this method to toggle from `plus` to `minus` or from `minus` to `plus`.
    ///
    @inlinable public mutating func toggle() {
        self = ~self
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Bitwise
//=----------------------------------------------------------------------------=

extension ANKSign {

    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the inverse of the given value.
    @inlinable public static prefix func ~(x: Self) -> Self {
        x == self.plus ? self.minus : self.plus
    }
    
    /// Forms `minus` if both values equal `minus`, and `plus` otherwise.
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }
    
    /// Returns `minus` if both values equal `minus`, and `plus` otherwise.
    @inlinable public static func &(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : self.plus
    }
    
    /// Forms `minus` if one, or both, values equal `minus`, and `plus` otherwise.
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }
    
    /// Returns `minus` if one, or both, values equal `minus`, and `plus` otherwise.
    @inlinable public static func |(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : self.minus
    }
    
    /// Forms `minus` if one value equals `minus`, and `plus` otherwise.
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }
    
    /// Returns `minus` if one value equals `minus`, and `plus` otherwise.
    @inlinable public static func ^(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? self.plus : self.minus
    }
}
