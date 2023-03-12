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
// MARK: * Types x ANKIntOrUInt
//*============================================================================*

final class TypesTestsOnANKIntOrUInt: XCTestCase {
    
    typealias T = any ANKIntOrUInt.Type
    typealias S = Int
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKIntOrUInt
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 2)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsIntOrUInt() {
        XCTAssert(types.allSatisfy({ $0 == Int.self || $0 == UInt.self }))
    }
}

#endif
