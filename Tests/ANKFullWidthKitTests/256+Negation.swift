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

//*============================================================================*
// MARK: * Int256 x Negation
//*============================================================================*

final class Int256TestsOnNegation: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        XCTAssertEqual(-T( 0), T( 0))
        XCTAssertEqual(-T( 1), T(-1))
        XCTAssertEqual(-T(-1), T( 1))
    }
    
    func testNegatedReportingOverflow() {
        XCTAssert(T.min.negatedReportingOverflow() == (T(x64:(0, 0, 0, ~0 << 63)), true ) as (T, Bool))
        XCTAssert(T.max.negatedReportingOverflow() == (T(x64:(1, 0, 0, ~0 << 63)), false) as (T, Bool))
    }
}

#endif
