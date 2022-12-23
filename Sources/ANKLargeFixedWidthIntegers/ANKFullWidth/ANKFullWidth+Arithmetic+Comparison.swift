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
// MARK: * ANK x Full Width x Comparisons
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static var isSigned: Bool {
        High.isSigned
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.low == rhs.low && lhs.high == rhs.high
    }
    
    @inlinable static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.high < rhs.high ? true : lhs.high > rhs.high ? false : lhs.low < rhs.low
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var isZero: Bool {
        self.low.isZero && self.high.isZero
    }
    
    @_transparent @usableFromInline var isLessThanZero: Bool {
        self.high.isLessThanZero
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable func hash(into hasher: inout Hasher) {
        hasher.combine(self.low); hasher.combine(self.high)
    }
}
