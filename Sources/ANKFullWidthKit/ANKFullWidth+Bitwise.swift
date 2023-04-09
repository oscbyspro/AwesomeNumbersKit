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
// MARK: * ANK x Full Width x Bitwise
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func ~(x: Self) -> Self {
        Self(descending: HL(~x.high, ~x.low))
    }
    
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        lhs.low  &= rhs.low
        lhs.high &= rhs.high
    }
    
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        lhs.low  |= rhs.low
        lhs.high |= rhs.high
    }
    
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        lhs.low  ^= rhs.low
        lhs.high ^= rhs.high
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public var byteSwapped: Self {
        self.withUnsafeWords { SELF in
            Self.fromUnsafeMutableWords { RESULT in
                for index in SELF.indices {
                    RESULT[RESULT.lastIndex &- index] = SELF[index].byteSwapped
                }
            }
        }
    }
    
    @inlinable var _wordSwapped: Self {
        self.withUnsafeWords { SELF in
            Self.fromUnsafeMutableWords { RESULT in
                for index in SELF.indices {
                    RESULT[RESULT.lastIndex &- index] = SELF[index]
                }
            }
        }
    }
}
