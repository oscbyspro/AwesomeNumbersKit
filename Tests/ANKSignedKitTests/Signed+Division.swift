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
// MARK: * Signed x Division
//*============================================================================*

final class SignedTestsOnDivision: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    typealias M = UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T( 0) / T( 1),  0 as T)
        XCTAssertEqual(T( 0) / T( 2),  0 as T)
        XCTAssertEqual(T( 0) % T( 1),  0 as T)
        XCTAssertEqual(T( 0) % T( 2),  0 as T)

        XCTAssertEqual(T( 7) / T( 1),  7 as T)
        XCTAssertEqual(T( 7) / T( 2),  3 as T)
        XCTAssertEqual(T( 7) % T( 1),  0 as T)
        XCTAssertEqual(T( 7) % T( 2),  1 as T)
                
        XCTAssertEqual(T( 7) / T( 3),  2 as T)
        XCTAssertEqual(T( 7) / T(-3), -2 as T)
        XCTAssertEqual(T(-7) / T( 3), -2 as T)
        XCTAssertEqual(T(-7) / T(-3),  2 as T)
        
        XCTAssertEqual(T( 7) % T( 3),  1 as T)
        XCTAssertEqual(T( 7) % T(-3),  1 as T)
        XCTAssertEqual(T(-7) % T( 3), -1 as T)
        XCTAssertEqual(T(-7) % T(-3), -1 as T)
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(T.min.dividedReportingOverflow(by:  T(0)) == (T.min,  true) as (T, Bool))
        XCTAssert(T.min.dividedReportingOverflow(by: -T(1)) == (T.max, false) as (T, Bool))
    }

    func testRemainderReportingOverflow() {
        XCTAssert(T.min.remainderReportingOverflow(dividingBy:  T(0)) == (T.min,  true) as (T, Bool))
        XCTAssert(T.min.remainderReportingOverflow(dividingBy: -T(1)) == (T(  ), false) as (T, Bool))
    }
}

#endif
