//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Negation
//*============================================================================*

final class Int192TestsOnNegation: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        XCTAssertEqual(-T( 0), T( 0))
        XCTAssertEqual(-T( 1), T(-1))
        XCTAssertEqual(-T(-1), T( 1))
    }
    
    func testNegatedReportingOverflow() {
        XCTAssert(T.min.negatedReportingOverflow() == (T.min,        true ) as (T, Bool))
        XCTAssert(T.max.negatedReportingOverflow() == (T.min + T(1), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguous() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x.negate())
            XCTAssertNotNil(x.negateReportingOverflow())
            
            XCTAssertNotNil(-x)
            XCTAssertNotNil(x.negated())
            XCTAssertNotNil(x.negatedReportingOverflow())
        }
    }
}

#endif
