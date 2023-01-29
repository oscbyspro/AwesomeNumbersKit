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
// MARK: * ANK x Signed x Addition
//*============================================================================*

final class ANKSignedTestsOnAddition: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        XCTAssertEqual( T(1)  +  T(2),  T(3))
        XCTAssertEqual( T(1)  +  T(1),  T(2))
        XCTAssertEqual( T(1)  +  T(0),  T(1))
        XCTAssertEqual( T(1)  + -T(0),  T(1))
        XCTAssertEqual( T(1)  + -T(1),  T(0))
        XCTAssertEqual( T(1)  + -T(2), -T(1))
        
        XCTAssertEqual( T(0)  +  T(2),  T(2))
        XCTAssertEqual( T(0)  +  T(1),  T(1))
        XCTAssertEqual( T(0)  +  T(0),  T(0))
        XCTAssertEqual( T(0)  + -T(0),  T(0))
        XCTAssertEqual( T(0)  + -T(1), -T(1))
        XCTAssertEqual( T(0)  + -T(2), -T(2))
        
        XCTAssertEqual(-T(0)  +  T(2),  T(2))
        XCTAssertEqual(-T(0)  +  T(1),  T(1))
        XCTAssertEqual(-T(0)  +  T(0),  T(0))
        XCTAssertEqual(-T(0)  + -T(0),  T(0))
        XCTAssertEqual(-T(0)  + -T(1), -T(1))
        XCTAssertEqual(-T(0)  + -T(2), -T(2))

        XCTAssertEqual(-T(1)  +  T(2),  T(1))
        XCTAssertEqual(-T(1)  +  T(1),  T(0))
        XCTAssertEqual(-T(1)  +  T(0), -T(1))
        XCTAssertEqual(-T(1)  + -T(0), -T(1))
        XCTAssertEqual(-T(1)  + -T(1), -T(2))
        XCTAssertEqual(-T(1)  + -T(2), -T(3))
    }
    
    func testAddingWrappingAround() {
        XCTAssertEqual( T(1) &+  T(2),  T(3))
        XCTAssertEqual( T(1) &+  T(1),  T(2))
        XCTAssertEqual( T(1) &+  T(0),  T(1))
        XCTAssertEqual( T(1) &+ -T(0),  T(1))
        XCTAssertEqual( T(1) &+ -T(1),  T(0))
        XCTAssertEqual( T(1) &+ -T(2), -T(1))
        
        XCTAssertEqual( T(0) &+  T(2),  T(2))
        XCTAssertEqual( T(0) &+  T(1),  T(1))
        XCTAssertEqual( T(0) &+  T(0),  T(0))
        XCTAssertEqual( T(0) &+ -T(0),  T(0))
        XCTAssertEqual( T(0) &+ -T(1), -T(1))
        XCTAssertEqual( T(0) &+ -T(2), -T(2))
        
        XCTAssertEqual(-T(0) &+  T(2),  T(2))
        XCTAssertEqual(-T(0) &+  T(1),  T(1))
        XCTAssertEqual(-T(0) &+  T(0),  T(0))
        XCTAssertEqual(-T(0) &+ -T(0),  T(0))
        XCTAssertEqual(-T(0) &+ -T(1), -T(1))
        XCTAssertEqual(-T(0) &+ -T(2), -T(2))

        XCTAssertEqual(-T(1) &+  T(2),  T(1))
        XCTAssertEqual(-T(1) &+  T(1),  T(0))
        XCTAssertEqual(-T(1) &+  T(0), -T(1))
        XCTAssertEqual(-T(1) &+ -T(0), -T(1))
        XCTAssertEqual(-T(1) &+ -T(1), -T(2))
        XCTAssertEqual(-T(1) &+ -T(2), -T(3))
    }
    
    func testAddingReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(T( 2)) == (T.min + T(2), false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(T( 2)) == (T(  ) + T(1), true ) as (T, Bool))
        
        XCTAssert(T.min.addingReportingOverflow(T(-2)) == (T(  ) - T(1), true ) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(T(-2)) == (T.max - T(2), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        XCTAssertEqual( T(1)  +  D(2),  T(3))
        XCTAssertEqual( T(1)  +  D(1),  T(2))
        XCTAssertEqual( T(1)  +  D(0),  T(1))
        XCTAssertEqual( T(1)  + -D(0),  T(1))
        XCTAssertEqual( T(1)  + -D(1),  T(0))
        XCTAssertEqual( T(1)  + -D(2), -T(1))
        
        XCTAssertEqual( T(0)  +  D(2),  T(2))
        XCTAssertEqual( T(0)  +  D(1),  T(1))
        XCTAssertEqual( T(0)  +  D(0),  T(0))
        XCTAssertEqual( T(0)  + -D(0),  T(0))
        XCTAssertEqual( T(0)  + -D(1), -T(1))
        XCTAssertEqual( T(0)  + -D(2), -T(2))
        
        XCTAssertEqual(-T(0)  +  D(2),  T(2))
        XCTAssertEqual(-T(0)  +  D(1),  T(1))
        XCTAssertEqual(-T(0)  +  D(0),  T(0))
        XCTAssertEqual(-T(0)  + -D(0),  T(0))
        XCTAssertEqual(-T(0)  + -D(1), -T(1))
        XCTAssertEqual(-T(0)  + -D(2), -T(2))

        XCTAssertEqual(-T(1)  +  D(2),  T(1))
        XCTAssertEqual(-T(1)  +  D(1),  T(0))
        XCTAssertEqual(-T(1)  +  D(0), -T(1))
        XCTAssertEqual(-T(1)  + -D(0), -T(1))
        XCTAssertEqual(-T(1)  + -D(1), -T(2))
        XCTAssertEqual(-T(1)  + -D(2), -T(3))
    }
    
    func testAddingDigitWrappingAround() {
        XCTAssertEqual( T(1) &+  D(2),  T(3))
        XCTAssertEqual( T(1) &+  D(1),  T(2))
        XCTAssertEqual( T(1) &+  D(0),  T(1))
        XCTAssertEqual( T(1) &+ -D(0),  T(1))
        XCTAssertEqual( T(1) &+ -D(1),  T(0))
        XCTAssertEqual( T(1) &+ -D(2), -T(1))

        XCTAssertEqual( T(0) &+  D(2),  T(2))
        XCTAssertEqual( T(0) &+  D(1),  T(1))
        XCTAssertEqual( T(0) &+  D(0),  T(0))
        XCTAssertEqual( T(0) &+ -D(0),  T(0))
        XCTAssertEqual( T(0) &+ -D(1), -T(1))
        XCTAssertEqual( T(0) &+ -D(2), -T(2))

        XCTAssertEqual(-T(0) &+  D(2),  T(2))
        XCTAssertEqual(-T(0) &+  D(1),  T(1))
        XCTAssertEqual(-T(0) &+  D(0),  T(0))
        XCTAssertEqual(-T(0) &+ -D(0),  T(0))
        XCTAssertEqual(-T(0) &+ -D(1), -T(1))
        XCTAssertEqual(-T(0) &+ -D(2), -T(2))

        XCTAssertEqual(-T(1) &+  D(2),  T(1))
        XCTAssertEqual(-T(1) &+  D(1),  T(0))
        XCTAssertEqual(-T(1) &+  D(0), -T(1))
        XCTAssertEqual(-T(1) &+ -D(0), -T(1))
        XCTAssertEqual(-T(1) &+ -D(1), -T(2))
        XCTAssertEqual(-T(1) &+ -D(2), -T(3))
    }
    
    func testAddingDigitReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(D( 2)) == (T.min + D(2), false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(D( 2)) == (T(  ) + D(1), true ) as (T, Bool))

        XCTAssert(T.min.addingReportingOverflow(D(-2)) == (T(  ) - D(1), true ) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(D(-2)) == (T.max - D(2), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreNonambiguousWhereDigitIsSelf() {
        XCTAssert(D.Digit.self == D.self)
        XCTAssertNotNil(D(2)  + D(3))
        XCTAssertNotNil(D(2) &+ D(3))
        XCTAssertNotNil(D(2).addingReportingOverflow(D(3)))
    }
}

#endif
