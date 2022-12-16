//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersKit
import XCTest

//*============================================================================*
// MARK: * Int x Tests x Complements
//*============================================================================*

final class IntTestsOnComplements: XCTestCase {
    
    typealias T = Int
    typealias M = T.Magnitude
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt.max
    let s = UInt.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signed
    //=------------------------------------------------------------------------=
    
    func testNegatedReportingOverflow() {
        XCTAssert(T.min.negatedReportingOverflow() == (T.min,     true ) as (T, Bool))
        XCTAssert(T.max.negatedReportingOverflow() == (T.min + 1, false) as (T, Bool))
    }
}

#endif
