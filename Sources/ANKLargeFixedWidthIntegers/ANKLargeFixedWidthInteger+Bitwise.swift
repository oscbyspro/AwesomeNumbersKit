//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Bitwise
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static prefix func ~(x: Self) -> Self {
        Self(bitPattern: ~x.body)
    }
    
    @_transparent public static func &=(lhs: inout Self, rhs: Self) {
        lhs.body &= rhs.body
    }
    
    @_transparent public static func |=(lhs: inout Self, rhs: Self) {
        lhs.body |= rhs.body
    }
    
    @_transparent public static func ^=(lhs: inout Self, rhs: Self) {
        lhs.body ^= rhs.body
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public var byteSwapped: Self {
        Self(bitPattern: body.byteSwapped)
    }
}
