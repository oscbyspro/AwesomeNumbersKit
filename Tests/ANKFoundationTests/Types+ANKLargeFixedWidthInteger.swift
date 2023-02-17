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
// MARK: * Types x ANKLargeFixedWidthInteger
//*============================================================================*

final class TypesTestsOnANKLargeFixedWidthInteger: XCTestCase {
    
    typealias T = any ANKLargeFixedWidthInteger.Type
    typealias S = any ANKSignedLargeFixedWidthInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKLargeFixedWidthInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 2)
    }
}

#endif
