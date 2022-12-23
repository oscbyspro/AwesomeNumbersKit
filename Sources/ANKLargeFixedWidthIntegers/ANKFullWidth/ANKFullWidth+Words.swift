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
    
    @inlinable static var bitWidth: Int {
        High.bitWidth + Low.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline var words: some WoRdS {
        self
    }
    
    @_transparent @usableFromInline var mostSignificantBit: Bool {
        self.high.mostSignificantBit
    }
    
    @_transparent @usableFromInline var leastSignificantBit: Bool {
        self.low.leastSignificantBit
    }
    
    @inlinable var nonzeroBitCount: Int {
        self.low.nonzeroBitCount &+ self.high.nonzeroBitCount
    }
    
    @inlinable var leadingZeroBitCount: Int {
        self.high.isZero ? High.bitWidth &+ self.low.leadingZeroBitCount : self.high.leadingZeroBitCount
    }
    
    @inlinable var trailingZeroBitCount: Int {
        self.low.isZero ? Low.bitWidth &+ self.high.trailingZeroBitCount : self.low.trailingZeroBitCount
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    /// Returns its word count in minimum two's complement form.
    @inlinable func minWordCountReportingIsZeroOrMinusOne() -> (minWordCount: Int, isZeroOrMinusOne: Bool) {
        let (mli, izomo) = self.minLastIndexReportingIsZeroOrMinusOne(); return (mli + 1, izomo)
    }
    
    /// Returns its last index in minimum two's complement form.
    @inlinable func minLastIndexReportingIsZeroOrMinusOne() -> (minLastIndex: Int, isZeroOrMinusOne: Bool) {
        let sign  = UInt(repeating: self.isLessThanZero)
        let index = self.withUnsafeWords({ SELF in SELF.lastIndex(where:{ word in word != sign }) })
        return index.map({($0, false)}) ?? (Int(), true)
    }
}
