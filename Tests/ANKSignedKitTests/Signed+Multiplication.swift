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
        XCTAssertEqual( T(2) *  T(3),  T(6))
        XCTAssertEqual( T(2) * -T(3), -T(6))
        XCTAssertEqual(-T(2) *  T(3), -T(6))
        XCTAssertEqual(-T(2) * -T(3),  T(6))
    }
    
    func testMultiplyingReportingOverflow() {
        XCTAssert(T( 2).multipliedReportingOverflow(by:  T(3)) == ( T(6), false) as (T, Bool))
        XCTAssert(T( 2).multipliedReportingOverflow(by: -T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by:  T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by: -T(3)) == ( T(6), false) as (T, Bool))
        
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.min) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
    }
    
    func testMultiplyingFullWidth() {
        XCTAssert(T( 2).multipliedFullWidth(by:  T(3)) == ( T(0),  M(6)) as (T, M))
        XCTAssert(T( 2).multipliedFullWidth(by: -T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert(T(-2).multipliedFullWidth(by:  T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert(T(-2).multipliedFullWidth(by: -T(3)) == ( T(0),  M(6)) as (T, M))
        
        XCTAssert(T.min.multipliedFullWidth(by: T.min) == (T.max - T(1), M(1)) as (T, M))
        XCTAssert(T.min.multipliedFullWidth(by: T.max) == (T.min + T(1), M(1)) as (T, M))
        XCTAssert(T.max.multipliedFullWidth(by: T.min) == (T.min + T(1), M(1)) as (T, M))
        XCTAssert(T.min.multipliedFullWidth(by: T.min) == (T.max - T(1), M(1)) as (T, M))
    }
}

#endif
