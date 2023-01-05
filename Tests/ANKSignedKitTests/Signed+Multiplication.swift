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
// MARK: * Signed x Multiplication
//*============================================================================*

final class SignedTestsOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    typealias M = UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        XCTAssertEqual(T( 0) * T( 0), T( 0))
        XCTAssertEqual(T( 0) * T( 1), T( 0))
        XCTAssertEqual(T( 1) * T( 0), T( 0))
        XCTAssertEqual(T( 1) * T( 1), T( 1))
        
        XCTAssertEqual(T( 0) * T( 0), T( 0))
        XCTAssertEqual(T( 0) * T(-1), T( 0))
        XCTAssertEqual(T(-1) * T( 0), T( 0))
        XCTAssertEqual(T(-1) * T(-1), T( 1))

        XCTAssertEqual(T( 2) * T( 3), T( 6))
        XCTAssertEqual(T( 2) * T(-3), T(-6))
        XCTAssertEqual(T(-2) * T( 3), T(-6))
        XCTAssertEqual(T(-2) * T(-3), T( 6))
    }
}

#endif
