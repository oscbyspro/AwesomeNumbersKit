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
// MARK: * Types x Int Or UInt
//*============================================================================*

final class TypesTestsOnANKIntOrUInt: XCTestCase {
    
    typealias T = any ANKIntOrUInt.Type
    typealias S = Int
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allEitherIntOrUIntTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrivialTypesCount() {
        XCTAssertEqual(types.count, 2)
    }
    
    func testIsEitherIntOrUInt() {
        for type: T in types {
            if type is  Int.Type { continue }
            if type is UInt.Type { continue }
            XCTFail("\(type) is neither Int nor UInt")
        }
    }
}

#endif
