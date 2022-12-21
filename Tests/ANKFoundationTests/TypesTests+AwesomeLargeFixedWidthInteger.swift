//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * Types x Awesome x Fixed Width Integers x Large
//*============================================================================*

final class TypesTestsOnAwesomeLargeFixedWidthInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allLargeFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
    //=------------------------------------------------------------------------=
    
    func testInitRepeatingWord() {
        let word = UInt.random(in: UInt.min ... UInt.max)
        for type: any AwesomeLargeFixedWidthInteger.Type in types {
            let words = type.init(repeating: word).words
            XCTAssert(words.allSatisfy({ $0 as! UInt == word }))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testBitWidthInvariants() {
        for type: any AwesomeLargeFixedWidthInteger.Type in types {
            XCTAssert(type.bitWidth / UInt.bitWidth >= 1)
            XCTAssert(type.bitWidth % UInt.bitWidth == 0)
        }
    }
}

#endif
