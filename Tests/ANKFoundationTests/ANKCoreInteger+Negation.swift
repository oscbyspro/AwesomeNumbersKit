//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Negation
//*============================================================================*

final class ANKCoreIntegerTestsOnNegation: XCTestCase {
    
    typealias T = any (ANKCoreInteger).Type
    typealias S = any (ANKCoreInteger & ANKSignedInteger).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        for case let type as S in types {
            XCTAssertEqual(type.min.negatedReportingOverflow().overflow, true )
            XCTAssertEqual(type.max.negatedReportingOverflow().overflow, false)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguous() {
        func becauseThisCompilesSuccessfully(_ x: inout some ANKCoreInteger & ANKSignedInteger) {
            XCTAssertNotNil(x.negate())
            XCTAssertNotNil(x.negateReportingOverflow())
            
            XCTAssertNotNil(-x)
            XCTAssertNotNil(x.negated())
            XCTAssertNotNil(x.negatedReportingOverflow())
        }
    }
}

#endif
