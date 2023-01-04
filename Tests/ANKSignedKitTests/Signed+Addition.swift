//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * Signed x Addition
//*============================================================================*

final class SignedTestsOnAddition: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        XCTAssertEqual(T( 1) + T(-2), T(-1))
        XCTAssertEqual(T( 1) + T(-1), T( 0))
        XCTAssertEqual(T( 1) + T( 0), T( 1))
        XCTAssertEqual(T( 1) + T( 1), T( 2))
        XCTAssertEqual(T( 1) + T( 2), T( 3))
        
        XCTAssertEqual(T( 0) + T(-2), T(-2))
        XCTAssertEqual(T( 0) + T(-1), T(-1))
        XCTAssertEqual(T( 0) + T( 0), T( 0))
        XCTAssertEqual(T( 0) + T( 1), T( 1))
        XCTAssertEqual(T( 0) + T( 2), T( 2))

        XCTAssertEqual(T(-1) + T(-2), T(-3))
        XCTAssertEqual(T(-1) + T(-1), T(-2))
        XCTAssertEqual(T(-1) + T( 0), T(-1))
        XCTAssertEqual(T(-1) + T( 1), T( 0))
        XCTAssertEqual(T(-1) + T( 2), T( 1))
    }
}

#endif