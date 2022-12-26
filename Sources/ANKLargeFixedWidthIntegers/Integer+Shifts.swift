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
// MARK: * ANK x Integer x Bitwise x Shifts
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &<<=(lhs: inout Self, rhs: Self) {
        lhs.body &<<= rhs.body
    }
    
    @_transparent public static func &<<(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body &<< rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func &>>=(lhs: inout Self, rhs: Self) {
        lhs.body &>>= rhs.body
    }
    
    @_transparent public static func &>>(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body &>> rhs.body)
    }
}
