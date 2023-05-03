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
        ANKAssertAddition( T(1),  T(2),  T(3))
        ANKAssertAddition( T(1),  T(1),  T(2))
        ANKAssertAddition( T(1),  T(0),  T(1))
        ANKAssertAddition( T(1), -T(0),  T(1))
        ANKAssertAddition( T(1), -T(1),  T(0))
        ANKAssertAddition( T(1), -T(2), -T(1))
        
        ANKAssertAddition( T(0),  T(2),  T(2))
        ANKAssertAddition( T(0),  T(1),  T(1))
        ANKAssertAddition( T(0),  T(0),  T(0))
        ANKAssertAddition( T(0), -T(0),  T(0))
        ANKAssertAddition( T(0), -T(1), -T(1))
        ANKAssertAddition( T(0), -T(2), -T(2))
        
        ANKAssertAddition(-T(0),  T(2),  T(2))
        ANKAssertAddition(-T(0),  T(1),  T(1))
        ANKAssertAddition(-T(0),  T(0), -T(0))
        ANKAssertAddition(-T(0), -T(0), -T(0))
        ANKAssertAddition(-T(0), -T(1), -T(1))
        ANKAssertAddition(-T(0), -T(2), -T(2))

        ANKAssertAddition(-T(1),  T(2),  T(1))
        ANKAssertAddition(-T(1),  T(1), -T(0))
        ANKAssertAddition(-T(1),  T(0), -T(1))
        ANKAssertAddition(-T(1), -T(0), -T(1))
        ANKAssertAddition(-T(1), -T(1), -T(2))
        ANKAssertAddition(-T(1), -T(2), -T(3))
    }
    
    func testAddingReportingOverflow() {
        ANKAssertAddition(T.min,  T(2), T.min + T(2), false)
        ANKAssertAddition(T.max,  T(2), T(  ) + T(1), true )
        ANKAssertAddition(T.min, -T(2), T(  ) - T(1), true )
        ANKAssertAddition(T.max, -T(2), T.max - T(2), false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        ANKAssertAdditionByDigit( T(1),  D(2),  T(3))
        ANKAssertAdditionByDigit( T(1),  D(1),  T(2))
        ANKAssertAdditionByDigit( T(1),  D(0),  T(1))
        ANKAssertAdditionByDigit( T(1), -D(0),  T(1))
        ANKAssertAdditionByDigit( T(1), -D(1),  T(0))
        ANKAssertAdditionByDigit( T(1), -D(2), -T(1))
        
        ANKAssertAdditionByDigit( T(0),  D(2),  T(2))
        ANKAssertAdditionByDigit( T(0),  D(1),  T(1))
        ANKAssertAdditionByDigit( T(0),  D(0),  T(0))
        ANKAssertAdditionByDigit( T(0), -D(0),  T(0))
        ANKAssertAdditionByDigit( T(0), -D(1), -T(1))
        ANKAssertAdditionByDigit( T(0), -D(2), -T(2))
        
        ANKAssertAdditionByDigit(-T(0),  D(2),  T(2))
        ANKAssertAdditionByDigit(-T(0),  D(1),  T(1))
        ANKAssertAdditionByDigit(-T(0),  D(0), -T(0))
        ANKAssertAdditionByDigit(-T(0), -D(0), -T(0))
        ANKAssertAdditionByDigit(-T(0), -D(1), -T(1))
        ANKAssertAdditionByDigit(-T(0), -D(2), -T(2))

        ANKAssertAdditionByDigit(-T(1),  D(2),  T(1))
        ANKAssertAdditionByDigit(-T(1),  D(1), -T(0))
        ANKAssertAdditionByDigit(-T(1),  D(0), -T(1))
        ANKAssertAdditionByDigit(-T(1), -D(0), -T(1))
        ANKAssertAdditionByDigit(-T(1), -D(1), -T(2))
        ANKAssertAdditionByDigit(-T(1), -D(2), -T(3))
    }
    
    func testAddingDigitReportingOverflow() {
        ANKAssertAdditionByDigit(T.min,  D(2), T.min + T(2), false)
        ANKAssertAdditionByDigit(T.min, -D(2), T(  ) - T(1), true )
        ANKAssertAdditionByDigit(T.max,  D(2), T(  ) + T(1), true )
        ANKAssertAdditionByDigit(T.max, -D(2), T.max - T(2), false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  += 0)
            XCTAssertNotNil(x &+= 0)
            XCTAssertNotNil(x.addReportingOverflow(0))
            
            XCTAssertNotNil(x  +  0)
            XCTAssertNotNil(x &+  0)
            XCTAssertNotNil(x.addingReportingOverflow(0))
        }
    }
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        func becauseThisCompilesSuccessfully(_ x: inout D.Digit) {
            XCTAssertNotNil(x  += D(0))
            XCTAssertNotNil(x &+= D(0))
            XCTAssertNotNil(x.addReportingOverflow(D(0)))
            
            XCTAssertNotNil(x  +  D(0))
            XCTAssertNotNil(x &+  D(0))
            XCTAssertNotNil(x.addingReportingOverflow(D(0)))
        }
    }
}

#endif
