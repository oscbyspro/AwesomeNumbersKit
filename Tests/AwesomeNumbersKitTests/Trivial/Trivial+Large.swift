//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersKit
import XCTest

//*============================================================================*
// MARK: * Trivial x Large
//*============================================================================*

final class TrivialTestsOnLarge: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allLargeFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidthInvariants() {
        for type: any AwesomeLargeFixedWidthInteger.Type in types {
            XCTAssert(type.bitWidth / UInt.bitWidth >= 1)
            XCTAssert(type.bitWidth % UInt.bitWidth == 0)
        }
    }
    
    func testInitRepeatingWord() {
        let word = UInt.random(in: UInt.min ... UInt.max)
        for type: any AwesomeLargeFixedWidthInteger.Type in types {
            XCTAssert(type.init(repeating: word).words.allSatisfy({ $0 as! UInt == word }))
        }
    }
}

#endif
