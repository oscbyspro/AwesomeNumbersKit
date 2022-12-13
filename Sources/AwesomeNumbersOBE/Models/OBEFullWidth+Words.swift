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
// MARK: * OBE x Full Width x Words
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var bitWidth: Int {
        MemoryLayout<Self>.stride * 8
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Words
//*============================================================================*

extension OBEFullWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var mostSignificantBit: Bool {
        high.mostSignificantBit
    }
    
    @inlinable var leastSignificantBit: Bool {
        low.leastSignificantBit
    }
    
    @inlinable var nonzeroBitCount: Int {
        low.nonzeroBitCount &+ high.nonzeroBitCount
    }
    
    @inlinable var leadingZeroBitCount: Int {
        high.isZero ? High.bitWidth &+ low.leadingZeroBitCount : high.leadingZeroBitCount
    }
    
    @inlinable var trailingZeroBitCount: Int {
        low.isZero ? Low.bitWidth &+ high.trailingZeroBitCount : low.trailingZeroBitCount
    }
}
