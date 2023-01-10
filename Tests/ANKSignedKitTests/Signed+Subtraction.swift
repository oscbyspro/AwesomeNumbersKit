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
// MARK: * Signed x Subtraction
//*============================================================================*

final class SignedTestsOnSubtraction: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual( T(1)  -  T(2), -T(1))
        XCTAssertEqual( T(1)  -  T(1),  T(0))
        XCTAssertEqual( T(1)  -  T(0),  T(1))
        XCTAssertEqual( T(1)  - -T(0),  T(1))
        XCTAssertEqual( T(1)  - -T(1),  T(2))
        XCTAssertEqual( T(1)  - -T(2),  T(3))
        
        XCTAssertEqual( T(0)  -  T(2), -T(2))
        XCTAssertEqual( T(0)  -  T(1), -T(1))
        XCTAssertEqual( T(0)  -  T(0),  T(0))
        XCTAssertEqual( T(0)  - -T(0),  T(0))
        XCTAssertEqual( T(0)  - -T(1),  T(1))
        XCTAssertEqual( T(0)  - -T(2),  T(2))
        
        XCTAssertEqual(-T(0)  -  T(2), -T(2))
        XCTAssertEqual(-T(0)  -  T(1), -T(1))
        XCTAssertEqual(-T(0)  -  T(0),  T(0))
        XCTAssertEqual(-T(0)  - -T(0),  T(0))
        XCTAssertEqual(-T(0)  - -T(1),  T(1))
        XCTAssertEqual(-T(0)  - -T(2),  T(2))
        
        XCTAssertEqual(-T(1)  -  T(2), -T(3))
        XCTAssertEqual(-T(1)  -  T(1), -T(2))
        XCTAssertEqual(-T(1)  -  T(0), -T(1))
        XCTAssertEqual(-T(1)  - -T(0), -T(1))
        XCTAssertEqual(-T(1)  - -T(1),  T(0))
        XCTAssertEqual(-T(1)  - -T(2),  T(1))
    }
    
    func testSubtractingWrappingAround() {
        XCTAssertEqual( T(1) &-  T(2), -T(1))
        XCTAssertEqual( T(1) &-  T(1),  T(0))
        XCTAssertEqual( T(1) &-  T(0),  T(1))
        XCTAssertEqual( T(1) &- -T(0),  T(1))
        XCTAssertEqual( T(1) &- -T(1),  T(2))
        XCTAssertEqual( T(1) &- -T(2),  T(3))
        
        XCTAssertEqual( T(0) &-  T(2), -T(2))
        XCTAssertEqual( T(0) &-  T(1), -T(1))
        XCTAssertEqual( T(0) &-  T(0),  T(0))
        XCTAssertEqual( T(0) &- -T(0),  T(0))
        XCTAssertEqual( T(0) &- -T(1),  T(1))
        XCTAssertEqual( T(0) &- -T(2),  T(2))
        
        XCTAssertEqual(-T(0) &-  T(2), -T(2))
        XCTAssertEqual(-T(0) &-  T(1), -T(1))
        XCTAssertEqual(-T(0) &-  T(0),  T(0))
        XCTAssertEqual(-T(0) &- -T(0),  T(0))
        XCTAssertEqual(-T(0) &- -T(1),  T(1))
        XCTAssertEqual(-T(0) &- -T(2),  T(2))
        
        XCTAssertEqual(-T(1) &-  T(2), -T(3))
        XCTAssertEqual(-T(1) &-  T(1), -T(2))
        XCTAssertEqual(-T(1) &-  T(0), -T(1))
        XCTAssertEqual(-T(1) &- -T(0), -T(1))
        XCTAssertEqual(-T(1) &- -T(1),  T(0))
        XCTAssertEqual(-T(1) &- -T(2),  T(1))
    }
    
    func testSubtractingReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(T( 2)) == (T(  ) - T(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T( 2)) == (T.max - T(2), false) as (T, Bool))
        
        XCTAssert(T.min.subtractingReportingOverflow(T(-2)) == (T.min + T(2), false) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T(-2)) == (T(  ) + T(1), true ) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        XCTAssertEqual( T(1)  -  D(2), -T(1))
        XCTAssertEqual( T(1)  -  D(1),  T(0))
        XCTAssertEqual( T(1)  -  D(0),  T(1))
        XCTAssertEqual( T(1)  - -D(0),  T(1))
        XCTAssertEqual( T(1)  - -D(1),  T(2))
        XCTAssertEqual( T(1)  - -D(2),  T(3))
        
        XCTAssertEqual( T(0)  -  D(2), -T(2))
        XCTAssertEqual( T(0)  -  D(1), -T(1))
        XCTAssertEqual( T(0)  -  D(0),  T(0))
        XCTAssertEqual( T(0)  - -D(0),  T(0))
        XCTAssertEqual( T(0)  - -D(1),  T(1))
        XCTAssertEqual( T(0)  - -D(2),  T(2))
        
        XCTAssertEqual(-T(0)  -  D(2), -T(2))
        XCTAssertEqual(-T(0)  -  D(1), -T(1))
        XCTAssertEqual(-T(0)  -  D(0),  T(0))
        XCTAssertEqual(-T(0)  - -D(0),  T(0))
        XCTAssertEqual(-T(0)  - -D(1),  T(1))
        XCTAssertEqual(-T(0)  - -D(2),  T(2))
        
        XCTAssertEqual(-T(1)  -  D(2), -T(3))
        XCTAssertEqual(-T(1)  -  D(1), -T(2))
        XCTAssertEqual(-T(1)  -  D(0), -T(1))
        XCTAssertEqual(-T(1)  - -D(0), -T(1))
        XCTAssertEqual(-T(1)  - -D(1),  T(0))
        XCTAssertEqual(-T(1)  - -D(2),  T(1))
    }
    
    func testSubtractingDigitWrappingAround() {
        XCTAssertEqual( T(1) &-  D(2), -T(1))
        XCTAssertEqual( T(1) &-  D(1),  T(0))
        XCTAssertEqual( T(1) &-  D(0),  T(1))
        XCTAssertEqual( T(1) &- -D(0),  T(1))
        XCTAssertEqual( T(1) &- -D(1),  T(2))
        XCTAssertEqual( T(1) &- -D(2),  T(3))
        
        XCTAssertEqual( T(0) &-  D(2), -T(2))
        XCTAssertEqual( T(0) &-  D(1), -T(1))
        XCTAssertEqual( T(0) &-  D(0),  T(0))
        XCTAssertEqual( T(0) &- -D(0),  T(0))
        XCTAssertEqual( T(0) &- -D(1),  T(1))
        XCTAssertEqual( T(0) &- -D(2),  T(2))
        
        XCTAssertEqual(-T(0) &-  D(2), -T(2))
        XCTAssertEqual(-T(0) &-  D(1), -T(1))
        XCTAssertEqual(-T(0) &-  D(0),  T(0))
        XCTAssertEqual(-T(0) &- -D(0),  T(0))
        XCTAssertEqual(-T(0) &- -D(1),  T(1))
        XCTAssertEqual(-T(0) &- -D(2),  T(2))
        
        XCTAssertEqual(-T(1) &-  D(2), -T(3))
        XCTAssertEqual(-T(1) &-  D(1), -T(2))
        XCTAssertEqual(-T(1) &-  D(0), -T(1))
        XCTAssertEqual(-T(1) &- -D(0), -T(1))
        XCTAssertEqual(-T(1) &- -D(1),  T(0))
        XCTAssertEqual(-T(1) &- -D(2),  T(1))
    }
    
    func testSubtractingDigitReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(D( 2)) == (T(  ) - D(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(D( 2)) == (T.max - D(2), false) as (T, Bool))
        
        XCTAssert(T.min.subtractingReportingOverflow(D(-2)) == (T.min + D(2), false) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(D(-2)) == (T(  ) + D(1), true ) as (T, Bool))
    }
}

#endif
