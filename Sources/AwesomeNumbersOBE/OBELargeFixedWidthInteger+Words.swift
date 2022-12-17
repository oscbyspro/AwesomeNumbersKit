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
// MARK: * OBE x Fixed Width Integer x Large x Words
//*============================================================================*

extension OBELargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public static var bitWidth: Int {
        Body.bitWidth
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: some WoRdS {
        body
    }
    
    @inlinable public var nonzeroBitCount: Int {
        body.nonzeroBitCount
    }
    
    @inlinable public var leadingZeroBitCount: Int {
        body.leadingZeroBitCount
    }
    
    @inlinable public var trailingZeroBitCount: Int {
        body.trailingZeroBitCount
    }
    
    @inlinable public var mostSignificantBit: Bool {
        body.mostSignificantBit
    }
    
    @inlinable public var leastSignificantBit: Bool {
        body.leastSignificantBit
    }
    
    @inlinable var minWordsCount: Int {
        body.minWordsCount
    }
    
    @inlinable func minWordsCountReportingIsZeroOrMinusOne() -> (count: Int, isZeroOrMinusOne: Bool) {
        body.minWordsCountReportingIsZeroOrMinusOne()
     }
}
