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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Multiplication
//*============================================================================*

final class ANKSignedTestsOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual( T(2) *  T(3),  T(6))
        XCTAssertEqual( T(2) * -T(3), -T(6))
        XCTAssertEqual(-T(2) *  T(3), -T(6))
        XCTAssertEqual(-T(2) * -T(3),  T(6))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T( 2).multipliedReportingOverflow(by:  T(3)) == ( T(6), false) as (T, Bool))
        XCTAssert(T( 2).multipliedReportingOverflow(by: -T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by:  T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by: -T(3)) == ( T(6), false) as (T, Bool))
        
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.min) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssert(T( 2).multipliedFullWidth(by:  T(3)) == ( T(0),  M(6)) as (T, M))
        XCTAssert(T( 2).multipliedFullWidth(by: -T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert(T(-2).multipliedFullWidth(by:  T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert(T(-2).multipliedFullWidth(by: -T(3)) == ( T(0),  M(6)) as (T, M))
        
        XCTAssert(T.min.multipliedFullWidth(by: T.min) == (T.max - T(1), M(1)) as (T, M))
        XCTAssert(T.min.multipliedFullWidth(by: T.max) == (T.min + T(1), M(1)) as (T, M))
        XCTAssert(T.max.multipliedFullWidth(by: T.min) == (T.min + T(1), M(1)) as (T, M))
        XCTAssert(T.min.multipliedFullWidth(by: T.min) == (T.max - T(1), M(1)) as (T, M))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual( T(2) *  D(3),  T(6))
        XCTAssertEqual( T(2) * -D(3), -T(6))
        XCTAssertEqual(-T(2) *  D(3), -T(6))
        XCTAssertEqual(-T(2) * -D(3),  T(6))
    }
    
    func testMultipliedByDigitReportingOverflow() {
        XCTAssert(T( 2).multipliedReportingOverflow(by:  D(3)) == ( T(6), false) as (T, Bool))
        XCTAssert(T( 2).multipliedReportingOverflow(by: -D(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by:  D(3)) == (-T(6), false) as (T, Bool))
        XCTAssert(T(-2).multipliedReportingOverflow(by: -D(3)) == ( T(6), false) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() {
        XCTAssert(T( 2).multipliedFullWidth(by:  D(3)) == ( D(0),  M(6)) as (D, M))
        XCTAssert(T( 2).multipliedFullWidth(by: -D(3)) == (-D(0),  M(6)) as (D, M))
        XCTAssert(T(-2).multipliedFullWidth(by:  D(3)) == (-D(0),  M(6)) as (D, M))
        XCTAssert(T(-2).multipliedFullWidth(by: -D(3)) == ( D(0),  M(6)) as (D, M))
    }
    
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        XCTAssert(D.Digit.self == D.self)
        XCTAssertNotNil(D(2) * D(3))
        XCTAssertNotNil(D(2).multipliedReportingOverflow(by: D(3)))
        XCTAssertNotNil(D(2).multipliedFullWidth(by: D(3)))
    }
}

#endif
