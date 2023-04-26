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
    
    func testMultipliedWrappingAround() {
        XCTAssertEqual( T(2) &*  T(3),  T(6))
        XCTAssertEqual( T(2) &* -T(3), -T(6))
        XCTAssertEqual(-T(2) &*  T(3), -T(6))
        XCTAssertEqual(-T(2) &* -T(3),  T(6))
        
        XCTAssertEqual(T.min &* T.min,  T(1))
        XCTAssertEqual(T.min &* T.max, -T(1))
        XCTAssertEqual(T.max &* T.min, -T(1))
        XCTAssertEqual(T.min &* T.min,  T(1))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(( T(2)).multipliedReportingOverflow(by:  T(3)) == ( T(6), false) as (T, Bool))
        XCTAssert(( T(2)).multipliedReportingOverflow(by: -T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert((-T(2)).multipliedReportingOverflow(by:  T(3)) == (-T(6), false) as (T, Bool))
        XCTAssert((-T(2)).multipliedReportingOverflow(by: -T(3)) == ( T(6), false) as (T, Bool))
        
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.min) == (-T(1), true ) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == ( T(1), true ) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssert(( T(2)).multipliedFullWidth(by:  T(3)) == ( T(0),  M(6)) as (T, M))
        XCTAssert(( T(2)).multipliedFullWidth(by: -T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert((-T(2)).multipliedFullWidth(by:  T(3)) == (-T(0),  M(6)) as (T, M))
        XCTAssert((-T(2)).multipliedFullWidth(by: -T(3)) == ( T(0),  M(6)) as (T, M))
        
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
    
    func testMultipliedByDigitWrappingAround() {
        XCTAssertEqual( T(2) &*  D(3),  T(6))
        XCTAssertEqual( T(2) &* -D(3), -T(6))
        XCTAssertEqual(-T(2) &*  D(3), -T(6))
        XCTAssertEqual(-T(2) &* -D(3),  T(6))
    }
    
    func testMultipliedByDigitReportingOverflow() {
        XCTAssert(( T(2)).multipliedReportingOverflow(by:  D(3)) == ( T(6), false) as (T, Bool))
        XCTAssert(( T(2)).multipliedReportingOverflow(by: -D(3)) == (-T(6), false) as (T, Bool))
        XCTAssert((-T(2)).multipliedReportingOverflow(by:  D(3)) == (-T(6), false) as (T, Bool))
        XCTAssert((-T(2)).multipliedReportingOverflow(by: -D(3)) == ( T(6), false) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() {
        XCTAssert(( T(2)).multipliedFullWidth(by:  D(3)) == ( D(0),  M(6)) as (D, M))
        XCTAssert(( T(2)).multipliedFullWidth(by: -D(3)) == (-D(0),  M(6)) as (D, M))
        XCTAssert((-T(2)).multipliedFullWidth(by:  D(3)) == (-D(0),  M(6)) as (D, M))
        XCTAssert((-T(2)).multipliedFullWidth(by: -D(3)) == ( D(0),  M(6)) as (D, M))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        func becauseThisCompilesSuccessfully(_ x: inout D.Digit) {
            XCTAssertNotNil(x  *= D(0))
            XCTAssertNotNil(x &*= D(0))
            XCTAssertNotNil(x.multiplyReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.multiplyFullWidth(by: D(0)))
            
            XCTAssertNotNil(x  *  D(0))
            XCTAssertNotNil(x &*  D(0))
            XCTAssertNotNil(x.multipliedReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.multipliedFullWidth(by: D(0)))
        }
    }
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  *= 0)
            XCTAssertNotNil(x &*= 0)
            XCTAssertNotNil(x.multiplyReportingOverflow(by: 0))
            XCTAssertNotNil(x.multiplyFullWidth(by: 0))
            
            XCTAssertNotNil(x  *  0)
            XCTAssertNotNil(x &*  0)
            XCTAssertNotNil(x.multipliedReportingOverflow(by: 0))
            XCTAssertNotNil(x.multipliedFullWidth(by: 0))
        }
    }
}

#endif
