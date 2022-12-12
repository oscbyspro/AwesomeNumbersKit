//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width Digits x Bitwise
//*============================================================================*

extension OBEFullWidthMutator {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &=(lhs: Self, rhs: Reader) {
        for index in  lhs.indices { lhs[index] &= rhs[index] }
    }
    
    @inlinable public static func |=(lhs: Self, rhs: Reader) {
        for index in  lhs.indices { lhs[index] |= rhs[index] }
    }
    
    @inlinable public static func ^=(lhs: Self, rhs: Reader) {
        for index in  lhs.indices { lhs[index] ^= rhs[index] }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func bitInvert() {
        for index in self.indices { self[index] = ~self[index] }
    }
}
