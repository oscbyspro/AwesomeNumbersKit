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
// MARK: * ANK x Full Width x Bitwise x Logic
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static prefix func ~(x: Self) -> Self {
        Self(descending:(~x.high, ~x.low))
    }
    
    @inlinable static func &=(lhs: inout Self, rhs: Self) {
        lhs.low &= rhs.low; lhs.high &= rhs.high
    }
    
    @inlinable static func |=(lhs: inout Self, rhs: Self) {
        lhs.low |= rhs.low; lhs.high |= rhs.high
    }
    
    @inlinable static func ^=(lhs: inout Self, rhs: Self) {
        lhs.low ^= rhs.low; lhs.high ^= rhs.high
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable var byteSwapped: Self {
        Self.fromUnsafeTemporaryWords { NEXT in
        self.withUnsafeWords { SELF in
        for index in Self.indices {
            let word = SELF[unchecked:  index].byteSwapped
            NEXT[unchecked: SELF.lastIndex - index] = word
        }}}
    }
}
