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

@frozen public enum ANKSign: Equatable {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    case plus
    case minus
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ bit: Bool) {
        self = bit ? Self.minus : Self.plus
    }
    
    @inlinable public init(_ sign: FloatingPointSign) {
        self = sign == FloatingPointSign.plus ? Self.plus : Self.minus
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func toggle() {
        self = ~self
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func ~(x: Self) -> Self {
        x == self.plus ? self.minus : self.plus
    }
    
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        lhs = lhs & rhs
    }
    
    @inlinable public static func &(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : self.plus
    }
    
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        lhs = lhs | rhs
    }
    
    @inlinable public static func |(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : self.minus
    }
    
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        lhs = lhs ^ rhs
    }
    
    @inlinable public static func ^(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? self.plus : self.minus
    }
}
