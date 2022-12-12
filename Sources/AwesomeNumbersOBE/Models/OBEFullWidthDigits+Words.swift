//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width Digits x Words
//*============================================================================*

extension OBEFullWidthDigits {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable static var bitWidth: Int {
        Body.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
        
    @inlinable var mostSignificantBit: Bool {
        self[lastIndex].mostSignificantBit
    }
    
    @inlinable var leastSignificantBit: Bool {
        self[firstIndex].leastSignificantBit
    }
    
    @inlinable var mostSignificantWord: UInt {
        self[lastIndex].mostSignificantWord
    }
    
    @inlinable var leastSignificantWord: UInt {
        self[firstIndex].leastSignificantWord
    }
    
    @inlinable var nonzeroBitCount: Int {
        self.reduce(0) { $0 &+ $1.nonzeroBitCount }
    }
    
    @inlinable var leadingZeroBitCount: Int {
        let index = self.lastIndex(where:{ !$0.isZero })
        guard let index else { return Self.bitWidth }
        let count = (self.lastIndex - index) * UInt.bitWidth
        return count &+ self[index].leadingZeroBitCount
    }

    @inlinable var trailingZeroBitCount: Int {
        let index = self.firstIndex(where:{ !$0.isZero })
        guard let index else { return Self.bitWidth }
        let count = index * UInt.bitWidth
        return count &+ self[index].trailingZeroBitCount
    }
}
