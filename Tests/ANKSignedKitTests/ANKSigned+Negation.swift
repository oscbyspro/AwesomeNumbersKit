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
// MARK: * ANK x Signed x Negation
//*============================================================================*

final class ANKSignedTestsOnNegation: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        XCTAssertEqual(-( T(0)),  T(0))
        XCTAssertEqual(-( T(1)), -T(1))
        XCTAssertEqual(-(-T(1)),  T(1))
        
        XCTAssertEqual( ( T(0).negated()),  T(0))
        XCTAssertEqual( ( T(1).negated()), -T(1))
        XCTAssertEqual( (-T(1).negated()),  T(1))
    }
    
    func testNegatedSignIsAlwaysToggled() {
        XCTAssertEqual((-T(0, as: .plus )).sign, .minus)
        XCTAssertEqual((-T(0, as: .minus)).sign, .plus )
        
        XCTAssertEqual(( T(0, as: .plus )).negated().sign, .minus)
        XCTAssertEqual(( T(0, as: .minus)).negated().sign, .plus )
    }
    
    func testNegatedReportingOverflow() {
        XCTAssert(T.min.negatedReportingOverflow() == (T.max, false) as (T, Bool))
        XCTAssert(T.max.negatedReportingOverflow() == (T.min, false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x.negate())
            XCTAssertNotNil(x.negateReportingOverflow())
            
            XCTAssertNotNil(-x)
            XCTAssertNotNil(x.negated())
            XCTAssertNotNil(x.negatedReportingOverflow())
        }
    }
}

#endif
