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
// MARK: * Types x ANKLargeBinaryInteger
//*============================================================================*

final class TypesTestsOnANKLargeBinaryInteger: XCTestCase {
    
    typealias T = any ANKLargeBinaryInteger.Type
    typealias S = any ANKSignedLargeBinaryInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKLargeBinaryInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 2)
    }
}

#endif
