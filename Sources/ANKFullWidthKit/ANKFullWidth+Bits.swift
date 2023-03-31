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
// MARK: * ANK x Full Width x Bits
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var bitWidth: Int {
        High.bitWidth + Low.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var mostSignificantBit: Bool {
        self.high.mostSignificantBit
    }
    
    @_transparent public var leastSignificantBit: Bool {
        self.low.leastSignificantBit
    }
    
    @inlinable public var nonzeroBitCount: Int {
        self.low.nonzeroBitCount &+ self.high.nonzeroBitCount
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        self.high.isZero ? High.bitWidth &+ self.low.leadingZeroBitCount : self.high.leadingZeroBitCount
    }
    
    @inlinable public var trailingZeroBitCount: Int {
        self.low.isZero ? Low.bitWidth &+ self.high.trailingZeroBitCount : self.low.trailingZeroBitCount
    }
}
