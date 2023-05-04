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
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T().sign, ANKSign.plus)
        XCTAssertEqual(T().magnitude, M())
    }
    
    func testInitDigit() {
        ANKAssertIdentical(T(digit:  D(3)),  T(3))
        ANKAssertIdentical(T(digit: -D(3)), -T(3))
        ANKAssertIdentical(D(digit:  D(3)),  D(3))
        ANKAssertIdentical(D(digit: -D(3)), -D(3))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        ANKAssertIdentical(T(bit: false), T( ))
        ANKAssertIdentical(T(bit: true ), T(1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        XCTAssertEqual(T.min.sign, ANKSign.minus)
        XCTAssertEqual(T.min.magnitude, M.max)
    }
    
    func testInitMax() {
        XCTAssertEqual(T.max.sign, ANKSign.plus)
        XCTAssertEqual(T.max.magnitude, M.max)
    }
    
    func testInitZero() {
        XCTAssertEqual(T.zero.sign, ANKSign.plus)
        XCTAssertEqual(T.zero.magnitude, M())
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Normalization
    //=------------------------------------------------------------------------=
    
    func testSign() {
        XCTAssertEqual(T(0, as: .plus ).sign, ANKSign.plus )
        XCTAssertEqual(T(0, as: .minus).sign, ANKSign.minus)
        XCTAssertEqual(T(1, as: .plus ).sign, ANKSign.plus )
        XCTAssertEqual(T(1, as: .minus).sign, ANKSign.minus)
    }
    
    func testIsNormal() {
        XCTAssertEqual(T(0, as: .plus ).isNormal, true )
        XCTAssertEqual(T(0, as: .minus).isNormal, false)
        XCTAssertEqual(T(1, as: .plus ).isNormal, true )
        XCTAssertEqual(T(1, as: .minus).isNormal, true )
    }
    
    func testNormalizedSign() {
        XCTAssertEqual(T(0, as: .plus ).normalizedSign, ANKSign.plus )
        XCTAssertEqual(T(0, as: .minus).normalizedSign, ANKSign.plus )
        XCTAssertEqual(T(1, as: .plus ).normalizedSign, ANKSign.plus )
        XCTAssertEqual(T(1, as: .minus).normalizedSign, ANKSign.minus)
    }
}

#endif
