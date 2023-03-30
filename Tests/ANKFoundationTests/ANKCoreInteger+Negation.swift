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
    typealias S = any (ANKCoreInteger & ANKSignedFixedWidthInteger).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = typesOfANKCoreInteger
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Negation
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        for case let type as S in types {
            XCTAssertEqual(type.min.negatedReportingOverflow().overflow, true )
            XCTAssertEqual(type.max.negatedReportingOverflow().overflow, false)
        }
    }
}

#endif
