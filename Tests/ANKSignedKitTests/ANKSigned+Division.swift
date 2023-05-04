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
// MARK: * ANK x Signed x Division
//*============================================================================*

final class ANKSignedTestsOnDivision: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        ANKAssertDivision( T(0),  T(1),  T(0),  T(0))
        ANKAssertDivision( T(0),  T(2),  T(0),  T(0))
        ANKAssertDivision( T(7),  T(1),  T(7),  T(0))
        ANKAssertDivision( T(7),  T(2),  T(3),  T(1))
                
        ANKAssertDivision( T(7),  T(3),  T(2),  T(1))
        ANKAssertDivision( T(7), -T(3), -T(2),  T(1))
        ANKAssertDivision(-T(7),  T(3), -T(2), -T(1))
        ANKAssertDivision(-T(7), -T(3),  T(2), -T(1))
    }
    
    func testDividingReportingOverflow() {
        ANKAssertDivision( T(7),  T(0),  T(7),  T(7), true)
        ANKAssertDivision( T(7), -T(0), -T(7),  T(7), true)
        ANKAssertDivision(-T(7),  T(0), -T(7), -T(7), true)
        ANKAssertDivision(-T(7), -T(0),  T(7), -T(7), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        ANKAssertDivisionByDigit( T(0),  D(1),  T(0),  D(0))
        ANKAssertDivisionByDigit( T(0),  D(2),  T(0),  D(0))
        ANKAssertDivisionByDigit( T(7),  D(1),  T(7),  D(0))
        ANKAssertDivisionByDigit( T(7),  D(2),  T(3),  D(1))
                
        ANKAssertDivisionByDigit( T(7),  D(3),  T(2),  D(1))
        ANKAssertDivisionByDigit( T(7), -D(3), -T(2),  D(1))
        ANKAssertDivisionByDigit(-T(7),  D(3), -T(2), -D(1))
        ANKAssertDivisionByDigit(-T(7), -D(3),  T(2), -D(1))
    }
    
    func testDividingByDigitReportingOverflow() {
        ANKAssertDivisionByDigit( T(7),  D(0),  T(7),  D(0), true)
        ANKAssertDivisionByDigit( T(7), -D(0), -T(7),  D(0), true)
        ANKAssertDivisionByDigit(-T(7),  D(0), -T(7), -D(0), true)
        ANKAssertDivisionByDigit(-T(7), -D(0),  T(7), -D(0), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        ANKAssertDivisionFullWidth(( T(1), M(1)),  T.max,  T(1),  T(2))
        ANKAssertDivisionFullWidth(( T(1), M(1)), -T.max, -T(1),  T(2))
        ANKAssertDivisionFullWidth((-T(1), M(1)),  T.max, -T(1), -T(2))
        ANKAssertDivisionFullWidth((-T(1), M(1)), -T.max,  T(1), -T(2))
        
        ANKAssertDivisionFullWidth(( T(1), M(1)),  T( 2),  T.max/T(2) + T(1),  T(1))
        ANKAssertDivisionFullWidth(( T(1), M(1)), -T( 2), -T.max/T(2) - T(1),  T(1))
        ANKAssertDivisionFullWidth((-T(1), M(1)),  T( 2), -T.max/T(2) - T(1), -T(1))
        ANKAssertDivisionFullWidth((-T(1), M(1)), -T( 2),  T.max/T(2) + T(1), -T(1))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        ANKAssertDivisionFullWidth(( T.max, M.max),  T.max,  T(1),  T(0))
        ANKAssertDivisionFullWidth(( T.max, M.max), -T.max, -T(1),  T(0))
        ANKAssertDivisionFullWidth((-T.max, M.max),  T.max, -T(1), -T(0))
        ANKAssertDivisionFullWidth((-T.max, M.max), -T.max,  T(1), -T(0))
        
        ANKAssertDivisionFullWidth(( T.max, M.max),  T( 2),  T.max,  T(1))
        ANKAssertDivisionFullWidth(( T.max, M.max), -T( 2), -T.max,  T(1))
        ANKAssertDivisionFullWidth((-T.max, M.max),  T( 2), -T.max, -T(1))
        ANKAssertDivisionFullWidth((-T.max, M.max), -T( 2),  T.max, -T(1))
        
        ANKAssertDivisionFullWidth(( T( 2), M( 3)),  T( 1),  T( 3),  T(0))
        ANKAssertDivisionFullWidth(( T( 2), M( 3)), -T( 1), -T( 3),  T(0))
        ANKAssertDivisionFullWidth((-T( 2), M( 3)),  T( 1), -T( 3), -T(0))
        ANKAssertDivisionFullWidth((-T( 2), M( 3)), -T( 1),  T( 3), -T(0))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x /= 0)
            XCTAssertNotNil(x %= 0)
            XCTAssertNotNil(x.divideReportingOverflow(by: 0))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: 0))
            
            XCTAssertNotNil(x /  0)
            XCTAssertNotNil(x %  0)
            XCTAssertNotNil(x.dividedReportingOverflow(by: 0))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.dividingFullWidth((0, 0)))
        }
    }
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        func becauseThisCompilesSuccessfully(_ x: inout D.Digit) {
            XCTAssertNotNil(x /= D(0))
            XCTAssertNotNil(x %= D(0))
            XCTAssertNotNil(x.divideReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: D(0)))
            
            XCTAssertNotNil(x /  D(0))
            XCTAssertNotNil(x %  D(0))
            XCTAssertNotNil(x.dividedReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: D(0)))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: D(0)))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: D(0)))
            XCTAssertNotNil(x.dividingFullWidth((D(0), UInt(0))))
        }
    }
}

#endif
