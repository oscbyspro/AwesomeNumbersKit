//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitwise
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func ~(x: Self) -> Self {
        Self(bitPattern: ~x.body)
    }
    
    @inlinable public static func &=(lhs: inout Self, rhs: Self) {
        lhs.body &= rhs.body
    }
    
    @inlinable public static func |=(lhs: inout Self, rhs: Self) {
        lhs.body |= rhs.body
    }
    
    @inlinable public static func ^=(lhs: inout Self, rhs: Self) {
        lhs.body ^= rhs.body
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public var byteSwapped: Self {
        let high = Self.reinterpret(self.low .byteSwapped)
        let low  = Self.reinterpret(self.high.byteSwapped)
        return Self(descending:(high, low))
    }
}
