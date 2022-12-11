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
// MARK: * OBE x Fixed Width Integer x Bitshifts x L
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs._storage <<= rhs
    }

    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs._storage << rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Int) {
        lhs._storage <<= rhs
    }
    
    @inlinable public static func <<(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs._storage << rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitshifts x R
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs._storage >>= rhs
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs._storage >> rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Int) {
        lhs._storage >>= rhs
    }
    
    @inlinable public static func >>(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs._storage >> rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitrotations x L
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs._storage &<<= rhs
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs._storage &<< rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        lhs._storage &<<= rhs
    }

    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs._storage &<< rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Bitrotations x R
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs._storage &>>= rhs
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs._storage &>> rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        lhs._storage &>>= rhs
    }

    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs._storage &>> rhs)
    }
}
