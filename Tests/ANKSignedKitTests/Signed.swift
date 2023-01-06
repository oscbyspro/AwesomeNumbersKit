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
        XCTAssertEqual(T().sign, .plus)
        XCTAssertEqual(T().magnitude, 0 as UInt)
    }
    
    func testInitWithBit() {
        XCTAssertEqual(T(bit: false), 0 as T)
        XCTAssertEqual(T(bit: true ), 1 as T)
    }
    
    func testInitWithRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  0 as T)
        XCTAssertEqual(T(repeating: true ), -1 as T)
    }
    
    func testSign() {
        XCTAssertEqual(T(0, as: .plus ).sign, .plus )
        XCTAssertEqual(T(0, as: .minus).sign, .minus)
        XCTAssertEqual(T(1, as: .plus ).sign, .plus )
        XCTAssertEqual(T(1, as: .minus).sign, .minus)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Normalization
    //=------------------------------------------------------------------------=
    
    func testIsNormal() {
        XCTAssertEqual(T(0, as: .plus ).isNormal, true )
        XCTAssertEqual(T(0, as: .minus).isNormal, false)
        XCTAssertEqual(T(1, as: .plus ).isNormal, true )
        XCTAssertEqual(T(1, as: .minus).isNormal, true )
    }
    
    func testNormalizedSign() {
        XCTAssertEqual(T(0, as: .plus ).normalized.sign, .plus )
        XCTAssertEqual(T(0, as: .minus).normalized.sign, .plus )
        XCTAssertEqual(T(1, as: .plus ).normalized.sign, .plus )
        XCTAssertEqual(T(1, as: .minus).normalized.sign, .minus)
    }
}

#endif
