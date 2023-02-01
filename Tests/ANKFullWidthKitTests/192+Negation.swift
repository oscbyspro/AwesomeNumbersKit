//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFullWidthKit
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Negation
//*============================================================================*

final class Int192TestsOnNegation: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        XCTAssertEqual(-T( 0), T( 0))
        XCTAssertEqual(-T( 1), T(-1))
        XCTAssertEqual(-T(-1), T( 1))
    }
    
    func testNegatedReportingOverflow() {
        XCTAssert(T.min.negatedReportingOverflow() == (T(x64: X(0, 0, ~0 << 63)), true ) as (T, Bool))
        XCTAssert(T.max.negatedReportingOverflow() == (T(x64: X(1, 0, ~0 << 63)), false) as (T, Bool))
    }
}

#endif
