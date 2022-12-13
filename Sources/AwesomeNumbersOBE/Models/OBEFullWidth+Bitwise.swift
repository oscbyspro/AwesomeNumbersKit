//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Full Width x Bitwise
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static prefix func ~(x: Self) -> Self {
        var result = Self.uninitialized()
        for index in Self.indices {
            result[unchecked: index] = ~x[unchecked: index]
        }
        
        return result
    }
    
    @inlinable static func &=(lhs: inout Self, rhs: Self) {
        for index in Self.indices {
            lhs[unchecked: index] &= rhs[unchecked: index]
        }
    }
    
    @inlinable static func &(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs &= rhs; return lhs
    }
    
    @inlinable static func |=(lhs: inout Self, rhs: Self) {
        for index in Self.indices {
            lhs[unchecked: index] |= rhs[unchecked: index]
        }
    }
    
    @inlinable static func |(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs |= rhs; return lhs
    }
    
    @inlinable static func ^=(lhs: inout Self, rhs: Self) {
        for index in Self.indices {
            lhs[unchecked: index] ^= rhs[unchecked: index]
        }
    }
    
    @inlinable static func ^(lhs: Self, rhs: Self) -> Self {
        var lhs = lhs; lhs ^= rhs; return lhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public var byteSwapped: Self {
        var result = Self.uninitialized()
        for index in Self.indices {
            result[unchecked: Self.lastIndex - index] = self[unchecked: index].byteSwapped
        }
        
        return result
    }
}
