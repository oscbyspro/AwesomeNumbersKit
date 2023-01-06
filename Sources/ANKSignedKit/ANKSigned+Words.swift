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
// MARK: * ANK x Signed x Words
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: [UInt] {
        fatalError("TODO")
    }
    
    @inlinable public var bitWidth: Int {
        self.magnitude.bitWidth + 1
    }
    
    @inlinable public var trailingZeroBitCount: Int {
        let count = self.magnitude.trailingZeroBitCount
        let extra = Int(bit: count == self.magnitude.bitWidth)
        return count + extra
    }
    
    @inlinable public var mostSignificantBit: Bool {
        self.isLessThanZero
    }
    
    @inlinable public var leastSignificantBit: Bool {
        self.magnitude.leastSignificantBit
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Words
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var bitWidth: Int {
        Magnitude.bitWidth + 1
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var nonzeroBitCount: Int {
        fatalError("TODO")
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        fatalError("TODO")
    }
}
