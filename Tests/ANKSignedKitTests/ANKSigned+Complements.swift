//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFullWidthKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Complements
//*============================================================================*

final class ANKSignedTestsOnComplements: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Magnitude
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(( T.max).magnitude, M.max)
        XCTAssertEqual(( T( 1)).magnitude, M( 1))
        XCTAssertEqual(( T( 0)).magnitude, M( 0))
        XCTAssertEqual((-T( 0)).magnitude, M( 0))
        XCTAssertEqual((-T( 1)).magnitude, M( 1))
        XCTAssertEqual((-T.max).magnitude, M.max)
    }
}

#endif
