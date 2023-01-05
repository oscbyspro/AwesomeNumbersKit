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
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let min = T(UInt.max, as: .minus)
    let max = T(UInt.max, as: .plus )
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T( 0) / T( 1),  0)
        XCTAssertEqual(T( 0) / T( 2),  0)
        XCTAssertEqual(T( 0) % T( 1),  0)
        XCTAssertEqual(T( 0) % T( 2),  0)

        XCTAssertEqual(T( 7) / T( 1),  7)
        XCTAssertEqual(T( 7) / T( 2),  3)
        XCTAssertEqual(T( 7) % T( 1),  0)
        XCTAssertEqual(T( 7) % T( 2),  1)
                
        XCTAssertEqual(T( 7) / T( 3),  2)
        XCTAssertEqual(T( 7) / T(-3), -2)
        XCTAssertEqual(T(-7) / T( 3), -2)
        XCTAssertEqual(T(-7) / T(-3),  2)
        
        XCTAssertEqual(T( 7) % T( 3),  1)
        XCTAssertEqual(T( 7) % T(-3),  1)
        XCTAssertEqual(T(-7) % T( 3), -1)
        XCTAssertEqual(T(-7) % T(-3), -1)
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(min.dividedReportingOverflow(by:  T(0)) == (min,  true) as (T, Bool))
        XCTAssert(min.dividedReportingOverflow(by: -T(1)) == (max, false) as (T, Bool))
    }

    func testRemainderReportingOverflow() {
        XCTAssert(min.remainderReportingOverflow(dividingBy:  T(0)) == (min,  true) as (T, Bool))
        XCTAssert(min.remainderReportingOverflow(dividingBy: -T(1)) == (T(), false) as (T, Bool))
    }
}

#endif
