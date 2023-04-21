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
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            let a = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T( 3))
            XCTAssertEqual(a.partialValue.quotient,  T( 2))
            XCTAssertEqual(a.partialValue.remainder, T( 1))
            XCTAssertEqual(a.overflow, false)
            
            let b = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T( 0))
            XCTAssertEqual(b.partialValue.quotient,  T( 7))
            XCTAssertEqual(b.partialValue.remainder, T( 7))
            XCTAssertEqual(b.overflow, true )
            
            guard type.isSigned else { return }
            
            let c = T.min.quotientAndRemainderReportingOverflow(dividingBy: T(-1))
            XCTAssertEqual(c.partialValue.quotient,  T.min)
            XCTAssertEqual(c.partialValue.remainder, T( 0))
            XCTAssertEqual(c.overflow, true )
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
}

#endif
