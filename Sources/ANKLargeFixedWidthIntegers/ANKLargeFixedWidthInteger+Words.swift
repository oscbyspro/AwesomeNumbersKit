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
// MARK: * ANK x Fixed Width Integer x Large x Words
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public static var bitWidth: Int {
        Body.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent public var words: some WoRdS {
        self.body
    }
    
    @_transparent public var nonzeroBitCount: Int {
        self.body.nonzeroBitCount
    }
    
    @_transparent public var leadingZeroBitCount: Int {
        self.body.leadingZeroBitCount
    }
    
    @_transparent public var trailingZeroBitCount: Int {
        self.body.trailingZeroBitCount
    }
    
    @_transparent public var mostSignificantBit: Bool {
        self.body.mostSignificantBit
    }
    
    @_transparent public var leastSignificantBit: Bool {
        self.body.leastSignificantBit
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func minWordCountReportingIsZeroOrMinusOne() -> (minWordCount: Int, isZeroOrMinusOne: Bool) {
        self.body.minWordCountReportingIsZeroOrMinusOne()
    }
    
    @_transparent @usableFromInline func minLastIndexReportingIsZeroOrMinusOne() -> (minLastIndex: Int, isZeroOrMinusOne: Bool) {
        self.body.minLastIndexReportingIsZeroOrMinusOne()
    }
}
