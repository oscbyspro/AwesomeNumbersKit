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
// MARK: * Trivial x Signed x Complements
//*============================================================================*

final class TrivialTestsOnComplementsAsSigned: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allSignedFixedWidthIntegerTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signed
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        for type in types {
            XCTAssertEqual(type.min.negatedReportingOverflow().overflow,  true )
            XCTAssertEqual(type.max.negatedReportingOverflow().overflow, false)
        }
    }
}

#endif
