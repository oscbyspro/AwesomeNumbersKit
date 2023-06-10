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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

final class ANKSignedTestsOnSubtraction: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        ANKAssertSubtraction( T(1),  T(2), -T(1))
        ANKAssertSubtraction( T(1),  T(1),  T(0))
        ANKAssertSubtraction( T(1),  T(0),  T(1))
        ANKAssertSubtraction( T(1), -T(0),  T(1))
        ANKAssertSubtraction( T(1), -T(1),  T(2))
        ANKAssertSubtraction( T(1), -T(2),  T(3))
        
        ANKAssertSubtraction( T(0),  T(2), -T(2))
        ANKAssertSubtraction( T(0),  T(1), -T(1))
        ANKAssertSubtraction( T(0),  T(0),  T(0))
        ANKAssertSubtraction( T(0), -T(0),  T(0))
        ANKAssertSubtraction( T(0), -T(1),  T(1))
        ANKAssertSubtraction( T(0), -T(2),  T(2))
        
        ANKAssertSubtraction(-T(0),  T(2), -T(2))
        ANKAssertSubtraction(-T(0),  T(1), -T(1))
        ANKAssertSubtraction(-T(0),  T(0), -T(0))
        ANKAssertSubtraction(-T(0), -T(0), -T(0))
        ANKAssertSubtraction(-T(0), -T(1),  T(1))
        ANKAssertSubtraction(-T(0), -T(2),  T(2))
        
        ANKAssertSubtraction(-T(1),  T(2), -T(3))
        ANKAssertSubtraction(-T(1),  T(1), -T(2))
        ANKAssertSubtraction(-T(1),  T(0), -T(1))
        ANKAssertSubtraction(-T(1), -T(0), -T(1))
        ANKAssertSubtraction(-T(1), -T(1), -T(0))
        ANKAssertSubtraction(-T(1), -T(2),  T(1))
    }
    
    func testSubtractingReportingOverflow() {
        ANKAssertSubtraction(T.min,  T(2), T(  ) - T(1), true )
        ANKAssertSubtraction(T.min, -T(2), T.min + T(2), false)
        ANKAssertSubtraction(T.max,  T(2), T.max - T(2), false)
        ANKAssertSubtraction(T.max, -T(2), T(  ) + T(1), true )
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        ANKAssertSubtractionByDigit( T(1),  D(2), -T(1))
        ANKAssertSubtractionByDigit( T(1),  D(1),  T(0))
        ANKAssertSubtractionByDigit( T(1),  D(0),  T(1))
        ANKAssertSubtractionByDigit( T(1), -D(0),  T(1))
        ANKAssertSubtractionByDigit( T(1), -D(1),  T(2))
        ANKAssertSubtractionByDigit( T(1), -D(2),  T(3))
        
        ANKAssertSubtractionByDigit( T(0),  D(2), -T(2))
        ANKAssertSubtractionByDigit( T(0),  D(1), -T(1))
        ANKAssertSubtractionByDigit( T(0),  D(0),  T(0))
        ANKAssertSubtractionByDigit( T(0), -D(0),  T(0))
        ANKAssertSubtractionByDigit( T(0), -D(1),  T(1))
        ANKAssertSubtractionByDigit( T(0), -D(2),  T(2))
        
        ANKAssertSubtractionByDigit(-T(0),  D(2), -T(2))
        ANKAssertSubtractionByDigit(-T(0),  D(1), -T(1))
        ANKAssertSubtractionByDigit(-T(0),  D(0), -T(0))
        ANKAssertSubtractionByDigit(-T(0), -D(0), -T(0))
        ANKAssertSubtractionByDigit(-T(0), -D(1),  T(1))
        ANKAssertSubtractionByDigit(-T(0), -D(2),  T(2))
        
        ANKAssertSubtractionByDigit(-T(1),  D(2), -T(3))
        ANKAssertSubtractionByDigit(-T(1),  D(1), -T(2))
        ANKAssertSubtractionByDigit(-T(1),  D(0), -T(1))
        ANKAssertSubtractionByDigit(-T(1), -D(0), -T(1))
        ANKAssertSubtractionByDigit(-T(1), -D(1), -T(0))
        ANKAssertSubtractionByDigit(-T(1), -D(2),  T(1))
    }
    
    func testSubtractingDigitReportingOverflow() {
        ANKAssertSubtractionByDigit(T.min,  D(2), T(  ) - T(1), true )
        ANKAssertSubtractionByDigit(T.min, -D(2), T.min + T(2), false)
        ANKAssertSubtractionByDigit(T.max,  D(2), T.max - T(2), false)
        ANKAssertSubtractionByDigit(T.max, -D(2), T(  ) + T(1), true )
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        func becauseThisCompilesSuccessfully(_ x: inout D.Digit) {
            XCTAssertNotNil(x  -= D(0))
            XCTAssertNotNil(x &-= D(0))
            XCTAssertNotNil(x.subtractReportingOverflow(D(0)))
            
            XCTAssertNotNil(x  -  D(0))
            XCTAssertNotNil(x &-  D(0))
            XCTAssertNotNil(x.subtractingReportingOverflow(D(0)))
        }
    }
}

#endif
