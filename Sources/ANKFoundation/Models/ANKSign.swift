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
@frozen public enum ANKSign: CustomStringConvertible, Hashable {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    /// The sign of a positive value.
    case plus
    
    /// The sign of a negative value.
    case minus
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    /// Creates a new instance from the given bit.
    @_transparent public init(_ bit: Bool) {
        self = unsafeBitCast(bit, to: Self.self)
    }
    
    /// Creates a new instance from the given sign.
    @_transparent public init(_ sign: FloatingPointSign) {
        self = unsafeBitCast(sign, to: Self.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var description: String {
        self == Self.plus ? "+" : "-"
    }
    
    /// The in-memory representation of this value.
    ///
    /// ```swift
    /// plus  // 0x00
    /// minus // 0x01
    /// ```
    ///
    @_transparent @usableFromInline var data: UInt8 {
        unsafeBitCast(self, to: UInt8.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Forms the opposite sign.
    ///
    /// Use this method to toggle from ``ANKSign/plus`` to ``ANKSign/minus`` or from ``ANKSign/minus`` to ``ANKSign/plus``.
    /// 
    @_transparent public mutating func toggle() {
        self = ~self
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.data == rhs.data
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Bitwise
//=----------------------------------------------------------------------------=

extension ANKSign {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    /// Returns the opposite sign.
    @_transparent public static prefix func ~(x: Self) -> Self {
        x ^ minus
    }
    
    /// Forms ``ANKSign/minus`` if both signs are ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  & plus  // plus
    /// plus  & minus // plus
    /// minus & plus  // plus
    /// minus & minus // minus
    /// ```
    ///
    @_transparent public static func &=(lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }
    
    /// Returns ``ANKSign/minus`` if both signs are ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  & plus  // plus
    /// plus  & minus // plus
    /// minus & plus  // plus
    /// minus & minus // minus
    /// ```
    ///
    @_transparent public static func &(lhs: Self, rhs: Self) -> Self {
        unsafeBitCast(lhs.data & rhs.data, to: Self.self)
    }
    
    /// Forms ``ANKSign/minus`` if at least one sign is ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  | plus  // plus
    /// plus  | minus // minus
    /// minus | plus  // minus
    /// minus | minus // minus
    /// ```
    ///
    @_transparent public static func |=(lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }
    
    /// Returns ``ANKSign/minus`` if at least one sign is ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  | plus  // plus
    /// plus  | minus // minus
    /// minus | plus  // minus
    /// minus | minus // minus
    /// ```
    ///
    @_transparent public static func |(lhs: Self, rhs: Self) -> Self {
        unsafeBitCast(lhs.data | rhs.data, to: Self.self)
    }
    
    /// Forms ``ANKSign/minus`` if exactly one sign is ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  ^ plus  // plus
    /// plus  ^ minus // minus
    /// minus ^ plus  // minus
    /// minus ^ minus // plus
    /// ```
    ///
    @_transparent public static func ^=(lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }
    
    /// Returns ``ANKSign/minus`` if exactly one sign is ``ANKSign/minus``, and ``ANKSign/plus`` otherwise.
    ///
    /// ```swift
    /// plus  ^ plus  // plus
    /// plus  ^ minus // minus
    /// minus ^ plus  // minus
    /// minus ^ minus // plus
    /// ```
    ///
    @_transparent public static func ^(lhs: Self, rhs: Self) -> Self {
        unsafeBitCast(lhs.data ^ rhs.data, to: Self.self)
    }
}
