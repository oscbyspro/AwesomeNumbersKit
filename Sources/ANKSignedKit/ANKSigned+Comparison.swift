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
// MARK: * ANK x Full Width x Comparison
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public static func ==(lhs: Self, rhs: Self) -> Bool {
        if lhs.magnitude != rhs.magnitude { return false }
        if lhs.sign/*-*/ == rhs.sign/*-*/ { return true  }
        return lhs.magnitude.isZero && rhs.magnitude.isZero
    }
    
    @inlinable public static func <(lhs: Self, rhs: Self) -> Bool {
        //=--------------------------------------=
        if  lhs.sign != rhs.sign {
            return (lhs.sign != .plus) && !(lhs.isZero && rhs.isZero)
        }
        //=--------------------------------------=
        return (lhs.sign == .plus) == (lhs.magnitude < rhs.magnitude)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var isZero: Bool {
        self.magnitude.isZero
    }
    
    @inlinable public var isLessThanZero: Bool {
        self.sign == .minus && !self.magnitude.isZero
    }
    
    @inlinable public var isMoreThanZero: Bool {
        self.sign == .plus  && !self.magnitude.isZero
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public func hash(into hasher: inout Hasher) {
        hasher.combine(self.normalizedSign); hasher.combine(self.magnitude)
    }
}
