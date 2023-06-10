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
// MARK: * ANK x Core Integer x Subtraction
//*============================================================================*

final class ANKCoreIntegerTestsOnSubtraction: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertSubtraction(T( 1), T( 2), T(-1))
            ANKAssertSubtraction(T( 1), T( 1), T( 0))
            ANKAssertSubtraction(T( 1), T( 0), T( 1))
            ANKAssertSubtraction(T( 1), T(-1), T( 2))
            ANKAssertSubtraction(T( 1), T(-2), T( 3))
            
            ANKAssertSubtraction(T( 0), T( 2), T(-2))
            ANKAssertSubtraction(T( 0), T( 1), T(-1))
            ANKAssertSubtraction(T( 0), T( 0), T( 0))
            ANKAssertSubtraction(T( 0), T(-1), T( 1))
            ANKAssertSubtraction(T( 0), T(-2), T( 2))
            
            ANKAssertSubtraction(T(-1), T( 2), T(-3))
            ANKAssertSubtraction(T(-1), T( 1), T(-2))
            ANKAssertSubtraction(T(-1), T( 0), T(-1))
            ANKAssertSubtraction(T(-1), T(-1), T( 0))
            ANKAssertSubtraction(T(-1), T(-2), T( 1))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertSubtraction(T(3), T(0), T(3))
            ANKAssertSubtraction(T(3), T(1), T(2))
            ANKAssertSubtraction(T(3), T(2), T(1))
            ANKAssertSubtraction(T(3), T(3), T(0))
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testSubtractingReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertSubtraction(T.min, T( 2), T.max - T(1), true )
            ANKAssertSubtraction(T.max, T( 2), T.max - T(2), false)
            
            ANKAssertSubtraction(T.min, T(-2), T.min + T(2), false)
            ANKAssertSubtraction(T.max, T(-2), T.min + T(1), true )
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertSubtraction(T.min, T(2), T.max - T(1), true )
            ANKAssertSubtraction(T.max, T(2), T.max - T(2), false)
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
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
}

#endif
