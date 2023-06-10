//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Addition
//*============================================================================*

final class ANKCoreIntegerTestsOnAddition: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertAddition(T( 1), T( 2), T( 3))
            ANKAssertAddition(T( 1), T( 1), T( 2))
            ANKAssertAddition(T( 1), T( 0), T( 1))
            ANKAssertAddition(T( 1), T(-1), T( 0))
            ANKAssertAddition(T( 1), T(-2), T(-1))
            
            ANKAssertAddition(T( 0), T( 2), T( 2))
            ANKAssertAddition(T( 0), T( 1), T( 1))
            ANKAssertAddition(T( 0), T( 0), T( 0))
            ANKAssertAddition(T( 0), T(-1), T(-1))
            ANKAssertAddition(T( 0), T(-2), T(-2))
            
            ANKAssertAddition(T(-1), T( 2), T( 1))
            ANKAssertAddition(T(-1), T( 1), T( 0))
            ANKAssertAddition(T(-1), T( 0), T(-1))
            ANKAssertAddition(T(-1), T(-1), T(-2))
            ANKAssertAddition(T(-1), T(-2), T(-3))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertAddition(T(0), T(0), T(0))
            ANKAssertAddition(T(0), T(1), T(1))
            ANKAssertAddition(T(0), T(2), T(2))
            
            ANKAssertAddition(T(1), T(0), T(1))
            ANKAssertAddition(T(1), T(1), T(2))
            ANKAssertAddition(T(1), T(2), T(3))
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testAddingReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertAddition(T.min, T( 1), T.min + T(1))
            ANKAssertAddition(T.min, T(-1), T.max,  true)
            
            ANKAssertAddition(T.max, T( 1), T.min,  true)
            ANKAssertAddition(T.max, T(-1), T.max - T(1))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertAddition(T.min, T(1), T.min + T(1))
            ANKAssertAddition(T.max, T(1), T.min,  true)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout some ANKCoreInteger) {
            XCTAssertNotNil(x  += 0)
            XCTAssertNotNil(x &+= 0)
            XCTAssertNotNil(x.addReportingOverflow(0))
            
            XCTAssertNotNil(x  +  0)
            XCTAssertNotNil(x &+  0)
            XCTAssertNotNil(x.addingReportingOverflow(0))
        }
    }
}

#endif
