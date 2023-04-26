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
// MARK: * ANK x Core Integer x Division
//*============================================================================*

final class ANKCoreIntegerTestsOnDivision: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            var x: PVO<QR<T, T>>
            //=----------------------------------=
            // Divisor: 0, -1
            //=----------------------------------=
            x = T(7).quotientAndRemainderReportingOverflow(dividingBy: T( 0))
            XCTAssertEqual(x.partialValue.quotient,  T( 7))
            XCTAssertEqual(x.partialValue.remainder, T( 7))
            XCTAssertEqual(x.overflow, true)
            //=----------------------------------=
            x = T.min.quotientAndRemainderReportingOverflow(dividingBy: T(-1))
            XCTAssertEqual(x.partialValue.quotient,  T.min)
            XCTAssertEqual(x.partialValue.remainder, T( 0))
            XCTAssertEqual(x.overflow, true)
            //=----------------------------------=
            // Standard
            //=----------------------------------=
            x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T( 3))
            XCTAssertEqual(x.partialValue.quotient,  T( 2))
            XCTAssertEqual(x.partialValue.remainder, T( 1))
            XCTAssertEqual(x.overflow, false)
            //=----------------------------------=
            x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T(-3))
            XCTAssertEqual(x.partialValue.quotient,  T(-2))
            XCTAssertEqual(x.partialValue.remainder, T( 1))
            XCTAssertEqual(x.overflow, false)
            //=----------------------------------=
            x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: T( 3))
            XCTAssertEqual(x.partialValue.quotient,  T(-2))
            XCTAssertEqual(x.partialValue.remainder, T(-1))
            XCTAssertEqual(x.overflow, false)
            //=----------------------------------=
            x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: T(-3))
            XCTAssertEqual(x.partialValue.quotient,  T( 2))
            XCTAssertEqual(x.partialValue.remainder, T(-1))
            XCTAssertEqual(x.overflow, false)
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            var x: PVO<QR<T, T>>
            //=----------------------------------=
            x = T(7).quotientAndRemainderReportingOverflow(dividingBy: T(0))
            XCTAssertEqual(x.partialValue.quotient,  T(7))
            XCTAssertEqual(x.partialValue.remainder, T(7))
            XCTAssertEqual(x.overflow, true)
            //=----------------------------------=
            x = T(7).quotientAndRemainderReportingOverflow(dividingBy: T(1))
            XCTAssertEqual(x.partialValue.quotient,  T(7))
            XCTAssertEqual(x.partialValue.remainder, T(0))
            XCTAssertEqual(x.overflow, false)
            //=----------------------------------=
            x = T(7).quotientAndRemainderReportingOverflow(dividingBy: T(2))
            XCTAssertEqual(x.partialValue.quotient,  T(3))
            XCTAssertEqual(x.partialValue.remainder, T(1))
            XCTAssertEqual(x.overflow, false)
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
            XCTAssertNotNil(x /= 1)
            XCTAssertNotNil(x %= 2)
            XCTAssertNotNil(x.divideReportingOverflow(by: 1))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: 2))
            
            XCTAssertNotNil(x /  1)
            XCTAssertNotNil(x %  2)
            XCTAssertNotNil(x.dividedReportingOverflow(by: 1))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: 2))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: 3))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: 3))
            XCTAssertNotNil(x.dividingFullWidth((1, 2)))
        }
    }
}

#endif
