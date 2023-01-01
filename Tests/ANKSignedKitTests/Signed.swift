//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed
//*============================================================================*

final class SignedTests: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T().magnitude, 0)
        XCTAssertEqual(T().sign,  .plus)
        
        XCTAssertEqual(T(0, as: .plus ).sign, .plus )
        XCTAssertEqual(T(0, as: .minus).sign, .minus)
        
        XCTAssertEqual(T(1, as: .plus ).sign, .plus )
        XCTAssertEqual(T(1, as: .minus).sign, .minus)
    }
    
    func testIsLessThanZero() {
        XCTAssertEqual(T(0, as: .plus ).isLessThanZero, false)
        XCTAssertEqual(T(0, as: .minus).isLessThanZero, false)
        
        XCTAssertEqual(T(1, as: .plus ).isLessThanZero, false)
        XCTAssertEqual(T(1, as: .minus).isLessThanZero, true )
    }
}

#endif
