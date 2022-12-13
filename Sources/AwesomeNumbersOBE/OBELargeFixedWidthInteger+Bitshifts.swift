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
// MARK: * OBE x Fixed Width Integer x Large x Bitshifts x L
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.body <<= rhs
    }

    @inlinable public static func <<(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs.body << rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func <<=(lhs: inout Self, rhs: Int) {
        lhs.body <<= rhs
    }
    
    @inlinable public static func <<(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body << rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Bitshifts x R
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.body >>= rhs
    }
    
    @inlinable public static func >>(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs.body >> rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func >>=(lhs: inout Self, rhs: Int) {
        lhs.body >>= rhs
    }
    
    @inlinable public static func >>(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body >> rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Bitrotations x L
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.body &<<= rhs
    }
    
    @inlinable public static func &<<(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs.body &<< rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &<<=(lhs: inout Self, rhs: Int) {
        lhs.body &<<= rhs
    }

    @inlinable public static func &<<(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body &<< rhs)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Large x Bitrotations x R
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x some Binary Integer
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: some BinaryInteger) {
        lhs.body &>>= rhs
    }
    
    @inlinable public static func &>>(lhs: Self, rhs: some BinaryInteger) -> Self {
        Self(bitPattern: lhs.body &>> rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Int
    //=------------------------------------------------------------------------=
    
    @inlinable public static func &>>=(lhs: inout Self, rhs: Int) {
        lhs.body &>>= rhs
    }

    @inlinable public static func &>>(lhs: Self, rhs: Int) -> Self {
        Self(bitPattern: lhs.body &>> rhs)
    }
}
