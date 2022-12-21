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
        body
    }
    
    @_transparent public var nonzeroBitCount: Int {
        body.nonzeroBitCount
    }
    
    @_transparent public var leadingZeroBitCount: Int {
        body.leadingZeroBitCount
    }
    
    @_transparent public var trailingZeroBitCount: Int {
        body.trailingZeroBitCount
    }
    
    @_transparent public var mostSignificantBit: Bool {
        body.mostSignificantBit
    }
    
    @_transparent public var leastSignificantBit: Bool {
        body.leastSignificantBit
    }
    
    @_transparent var minWordsCount: Int {
        body.minWordsCount
    }
    
    @_transparent func minWordsCountReportingIsZeroOrMinusOne() -> (count: Int, isZeroOrMinusOne: Bool) {
        body.minWordsCountReportingIsZeroOrMinusOne()
     }
}
