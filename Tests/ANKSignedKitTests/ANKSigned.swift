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
// MARK: * ANK x Signed
//*============================================================================*

final class ANKSignedTests: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T().sign, .plus)
        XCTAssertEqual(T().magnitude, 0 as UInt256)
    }
    
    func testInitWithBit() {
        XCTAssertEqual(T(bit: false), T(0))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitWithDigit() {
        XCTAssertEqual(T(digit:  D(3)),  T(3))
        XCTAssertEqual(T(digit: -D(3)), -T(3))
        XCTAssertEqual(D(digit:  D(3)),  D(3))
        XCTAssertEqual(D(digit: -D(3)), -D(3))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Normalization
    //=------------------------------------------------------------------------=
    
    func testSign() {
        XCTAssertEqual(T(0, as: .plus ).sign, .plus )
        XCTAssertEqual(T(0, as: .minus).sign, .minus)
        XCTAssertEqual(T(1, as: .plus ).sign, .plus )
        XCTAssertEqual(T(1, as: .minus).sign, .minus)
    }
    
    func testIsNormal() {
        XCTAssertEqual(T(0, as: .plus ).isNormal, true )
        XCTAssertEqual(T(0, as: .minus).isNormal, false)
        XCTAssertEqual(T(1, as: .plus ).isNormal, true )
        XCTAssertEqual(T(1, as: .minus).isNormal, true )
    }
    
    func testNormalizedSign() {
        XCTAssertEqual(T(0, as: .plus ).normalizedSign, .plus )
        XCTAssertEqual(T(0, as: .minus).normalizedSign, .plus )
        XCTAssertEqual(T(1, as: .plus ).normalizedSign, .plus )
        XCTAssertEqual(T(1, as: .minus).normalizedSign, .minus)
    }
}

#endif
