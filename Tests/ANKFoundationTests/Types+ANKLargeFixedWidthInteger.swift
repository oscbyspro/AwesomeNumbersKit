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
// MARK: * Types x Fixed Width Integer x Large
//*============================================================================*

final class TypesTestsOnANKLargeFixedWidthInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allLargeFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrivialTypesCount() {
        XCTAssertEqual(types.count, 2)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Words
    //=------------------------------------------------------------------------=
    
    func testRepeatingWord() {
        let word = UInt.random(in: UInt.min ... UInt.max)
        for type: any ANKLargeFixedWidthInteger.Type in types {
            let words = type.init(repeating: word).words
            XCTAssert(words.allSatisfy({ $0 as! UInt == word }))
        }
    }
    
    func testBitWidthInvariants() {
        for type: any ANKLargeFixedWidthInteger.Type in types {
            XCTAssert(type.bitWidth / UInt.bitWidth >= 1)
            XCTAssert(type.bitWidth % UInt.bitWidth == 0)
        }
    }
}

#endif
