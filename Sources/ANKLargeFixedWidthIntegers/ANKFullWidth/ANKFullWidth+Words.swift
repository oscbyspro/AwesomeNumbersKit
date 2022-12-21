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
// MARK: * ANK x Full Width x Words
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline static var bitWidth: Int {
        High.bitWidth + Low.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var words: some WoRdS {
        self
    }
    
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
    
    @inlinable var minWordsCount: Int {
        minWordsCountReportingIsZeroOrMinusOne().count
    }
    
    @inlinable func minWordsCountReportingIsZeroOrMinusOne() -> (count: Int, isZeroOrMinusOne: Bool) {
        let sign  = UInt(repeating: isLessThanZero)
        let index = withUnsafeWords({ SELF in SELF.lastIndex(where:{ word in word != sign }) })
        return index.map({($0 + 1, false)}) ?? (1, true)
    }
}
