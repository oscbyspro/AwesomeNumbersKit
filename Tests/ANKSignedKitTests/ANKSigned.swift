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
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitZero() {
        ANKAssertIdentical(T(   ), T(M(  ), as: ANKSign.plus ))
        ANKAssertIdentical(T.zero, T(M(  ), as: ANKSign.plus ))
    }
    
    func testInitEdges() {
        ANKAssertIdentical(T.max,  T(M.max, as: ANKSign.plus ))
        ANKAssertIdentical(T.min,  T(M.max, as: ANKSign.minus))
    }
    
    func testInitBit() {
        ANKAssertIdentical(T(bit: false), T(M(bit: false), as: ANKSign.plus ))
        ANKAssertIdentical(T(bit: true ), T(M(bit: true ), as: ANKSign.plus ))
    }
    
    func testInitDigit() {
        ANKAssertIdentical(T(digit:  D(4)),  T(4))
        ANKAssertIdentical(T(digit: -D(4)), -T(4))
        ANKAssertIdentical(D(digit:  D(4)),  D(4))
        ANKAssertIdentical(D(digit: -D(4)), -D(4))
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
