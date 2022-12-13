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
// MARK: * OBE x Full Width x Comparisons
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.low == rhs.low && lhs.high == rhs.high
    }
    
    @inlinable static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.high < rhs.high ? true : lhs.high > rhs.high ? false : lhs.low < rhs.low
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Comparisons
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var isSigned: Bool {
        High.isSigned
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var isZero: Bool {
        low.isZero && high.isZero
    }
    
    @_transparent @usableFromInline var isLessThanZero: Bool {
        high.isLessThanZero
    }
}
