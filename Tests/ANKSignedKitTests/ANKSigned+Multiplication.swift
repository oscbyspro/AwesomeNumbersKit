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
    
    func testMultiplying() {
        ANKAssertMultiplication( T(2),  T(3),  T(6))
        ANKAssertMultiplication( T(2), -T(3), -T(6))
        ANKAssertMultiplication(-T(2),  T(3), -T(6))
        ANKAssertMultiplication(-T(2), -T(3),  T(6))
    }
    
    func testMultiplyingReportingOverflow() {
        ANKAssertMultiplication(T.max, T.max,  T(1), T.max - T(1), true)
        ANKAssertMultiplication(T.max, T.min, -T(1), T.min + T(1), true)
        ANKAssertMultiplication(T.min, T.max, -T(1), T.min + T(1), true)
        ANKAssertMultiplication(T.min, T.min,  T(1), T.max - T(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultiplyingByDigit() {
        ANKAssertMultiplicationByDigit( T(2),  D(3),  T(6))
        ANKAssertMultiplicationByDigit( T(2), -D(3), -T(6))
        ANKAssertMultiplicationByDigit(-T(2),  D(3), -T(6))
        ANKAssertMultiplicationByDigit(-T(2), -D(3),  T(6))
    }
    
    func testMultiplyingByDigitReportingOverflow() {
        ANKAssertMultiplicationByDigit(T.max,  D(2), T.max - T(1),  D(1), true)
        ANKAssertMultiplicationByDigit(T.max, -D(2), T.min + T(1), -D(1), true)
        ANKAssertMultiplicationByDigit(T.min,  D(2), T.min + T(1), -D(1), true)
        ANKAssertMultiplicationByDigit(T.min, -D(2), T.max - T(1),  D(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
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
}

#endif
