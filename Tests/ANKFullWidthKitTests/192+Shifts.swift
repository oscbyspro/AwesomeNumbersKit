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
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Tests x Shifts
//*============================================================================*

final class Int192TestsOnShifts: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 0), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 2), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 3), T(x64: X( 0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 0), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 2), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 3), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 0, T(x64: X(1, 2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 1, T(x64: X(2, 4,  6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 2, T(x64: X(4, 8, 12)))
        
        XCTAssertEqual(T(x64: X(~0 << 48, ~0 >> 16, 0)) << 16, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~0 << 32, ~0 >> 32, 0)) << 32, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~0 << 16, ~0 >> 48, 0)) << 48, T(x64: X(0, ~0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=

    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 0), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 2), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 3), T(x64: X(~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 0), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 2), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 3), T(x64: X(~0, ~0, ~0)))

        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 0), T(x64: X(~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 1), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 2), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 3), T(x64: X( 0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 0), T(x64: X(~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 1), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 2), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 3), T(x64: X( 0,  0,  0)))
    }
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 0, T(x64: X(4, 8, 12)))
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 1, T(x64: X(2, 4,  6)))
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 2, T(x64: X(1, 2,  3)))

        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48)) >> 16, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32)) >> 32, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16)) >> 48, T(x64: X(0, ~0, 0)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Tests x Shifts
//*============================================================================*

final class UInt192TestsOnShifts: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 0), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 2), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) <<  (64 * 3), T(x64: X( 0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 0), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 1), T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 2), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)) >> -(64 * 3), T(x64: X( 0,  0,  0)))
    }

    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 0, T(x64: X(1, 2,  3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 1, T(x64: X(2, 4,  6)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) << 2, T(x64: X(4, 8, 12)))

        XCTAssertEqual(T(x64: X(~0 << 48, ~0 >> 16, 0)) << 16, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~0 << 32, ~0 >> 32, 0)) << 32, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~0 << 16, ~0 >> 48, 0)) << 48, T(x64: X(0, ~0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 0), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 1), T(x64: X( 0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 2), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) >>  (64 * 3), T(x64: X( 0,  0,  0)))

        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 0), T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 1), T(x64: X( 0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 2), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0)) << -(64 * 3), T(x64: X( 0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 0), T(x64: X(~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 1), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 2), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) >>  (64 * 3), T(x64: X( 0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 0), T(x64: X(~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 1), T(x64: X(~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 2), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)) << -(64 * 3), T(x64: X( 0,  0,  0)))
    }

    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 0, T(x64: X(4, 8, 12)))
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 1, T(x64: X(2, 4,  6)))
        XCTAssertEqual(T(x64: X(4, 8, 12)) >> 2, T(x64: X(1, 2,  3)))

        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48)) >> 16, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32)) >> 32, T(x64: X(0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16)) >> 48, T(x64: X(0, ~0, 0)))
    }
}

#endif
