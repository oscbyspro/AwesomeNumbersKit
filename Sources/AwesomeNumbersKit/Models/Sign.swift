//=----------------------------------------------------------------------------=
// This source file is part of the ExtraLargeNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Sign
//*============================================================================*

@frozen public enum Sign: Equatable {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    case plus
    case minus
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_ bit: Bool) {
        self = bit ? .minus : .plus
    }
    
    @inlinable public init(_ sign: FloatingPointSign) {
        self = sign == .plus ? .plus : .minus
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func toggle() {
        self = ~self
    }
    
    @inlinable public static prefix func ~(x: Self) -> Self {
        x == .plus ? .minus : .plus
    }
    
    @inlinable public static func &(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : .plus
    }
    
    @inlinable public static func |(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? lhs : .minus
    }
    
    @inlinable public static func ^(lhs: Self, rhs: Self) -> Self {
        lhs == rhs ? .plus : .minus
    }
}
