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
// MARK: * ANK x Core Integer x Multiplication
//*============================================================================*

final class ANKCoreIntegerTestsOnMultiplication: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertMultiplication(T( 3), T( 0), T( 0))
            ANKAssertMultiplication(T( 3), T(-0), T(-0))
            ANKAssertMultiplication(T(-3), T( 0), T(-0))
            ANKAssertMultiplication(T(-3), T(-0), T( 0))
            
            ANKAssertMultiplication(T( 3), T( 1), T( 3))
            ANKAssertMultiplication(T( 3), T(-1), T(-3))
            ANKAssertMultiplication(T(-3), T( 1), T(-3))
            ANKAssertMultiplication(T(-3), T(-1), T( 3))
            
            ANKAssertMultiplication(T( 3), T( 2), T( 6))
            ANKAssertMultiplication(T( 3), T(-2), T(-6))
            ANKAssertMultiplication(T(-3), T( 2), T(-6))
            ANKAssertMultiplication(T(-3), T(-2), T( 6))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertMultiplication(T( 3), T( 0), T( 0))
            ANKAssertMultiplication(T( 3), T( 1), T( 3))
            ANKAssertMultiplication(T( 3), T( 2), T( 6))
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }

    func testMultiplyingReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertMultiplication(T.max, T( 1), T.max,        T( 0), false)
            ANKAssertMultiplication(T.max, T(-1), T.min + T(1), T(-1), false)
            ANKAssertMultiplication(T.min, T( 1), T.min,        T(-1), false)
            ANKAssertMultiplication(T.min, T(-1), T.min,        T( 0), true )
            
            ANKAssertMultiplication(T.max, T( 2), T(-2),        T( 0), true )
            ANKAssertMultiplication(T.max, T(-2), T( 2),        T(-1), true )
            ANKAssertMultiplication(T.min, T( 2), T( 0),        T(-1), true )
            ANKAssertMultiplication(T.min, T(-2), T( 0),        T( 1), true )
            
            ANKAssertMultiplication(T.max, T.max, T( 1), T.max >> (1),              true)
            ANKAssertMultiplication(T.max, T.min, T.min, T(-1) << (T.bitWidth - 2), true)
            ANKAssertMultiplication(T.min, T.max, T.min, T(-1) << (T.bitWidth - 2), true)
            ANKAssertMultiplication(T.min, T.min, T( 0), T( 1) << (T.bitWidth - 2), true)
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertMultiplication(T.max, T( 2), ~T(1),  T(1), true)
            ANKAssertMultiplication(T.max, T.max,  T(1), ~T(1), true)
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
}

#endif
