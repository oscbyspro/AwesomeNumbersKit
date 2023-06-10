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
    
    func testNegating() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger & ANKSignedInteger {
            ANKAssertNegation( T(1), -T(1))
            ANKAssertNegation( T( ),  T( ))
            ANKAssertNegation(-T(1),  T(1))
        }
        
        for case let type as S in types {
            whereIsSigned(type)
        }
    }
    
    func testNegatingReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger & ANKSignedInteger {
            ANKAssertNegation(T.max - T( ), T.min + T(1))
            ANKAssertNegation(T.max - T(1), T.min + T(2))
            ANKAssertNegation(T.min + T(1), T.max - T( ))
            ANKAssertNegation(T.min + T( ), T.min,  true)
        }
        
        for case let type as S in types {
            whereIsSigned(type)
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
