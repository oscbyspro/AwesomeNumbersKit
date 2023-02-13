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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Tests x Shifts
//*============================================================================*

final class Int256TestsOnShifts: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 0), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 1), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 2), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 3), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 4), T(x64: X( 0,  0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 0), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 1), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 2), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 3), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 4), T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 0, T(x64: X(1, 2,  3,  4)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 1, T(x64: X(2, 4,  6,  8)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 2, T(x64: X(4, 8, 12, 16)))
        
        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16, 0)) << 16, T(x64: X(0, 0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32, 0)) << 32, T(x64: X(0, 0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48, 0)) << 48, T(x64: X(0, 0, ~0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 0), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 1), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 2), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 3), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 4), T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 0), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 1), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 2), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 3), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 4), T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 0), T(x64: X(~0, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 1), T(x64: X(~0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 2), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 3), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 4), T(x64: X( 0,  0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 0), T(x64: X(~0, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 1), T(x64: X(~0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 2), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 3), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 4), T(x64: X( 0,  0,  0,  0)))
    }
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 0, T(x64: X(4, 8, 12, 16)))
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 1, T(x64: X(2, 4,  6,  8)))
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 2, T(x64: X(1, 2,  3,  4)))
        
        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48, 0)) >> 16, T(x64: X(0, ~0, 0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32, 0)) >> 32, T(x64: X(0, ~0, 0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16, 0)) >> 48, T(x64: X(0, ~0, 0, 0)))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Shifts
//*============================================================================*

final class UInt256TestsOnShifts: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 0), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 1), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 2), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 3), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) <<  (64 * 4), T(x64: X( 0,  0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 0), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 1), T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 2), T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 3), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) >> -(64 * 4), T(x64: X( 0,  0,  0,  0)))
    }

    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 0, T(x64: X(1, 2,  3,  4)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 1, T(x64: X(2, 4,  6,  8)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)) << 2, T(x64: X(4, 8, 12, 16)))

        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16, 0)) << 16, T(x64: X(0, 0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32, 0)) << 32, T(x64: X(0, 0, ~0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48, 0)) << 48, T(x64: X(0, 0, ~0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 0), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 1), T(x64: X( 0,  0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 2), T(x64: X( 0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 3), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) >>  (64 * 4), T(x64: X( 0,  0,  0,  0)))

        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 0), T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 1), T(x64: X( 0,  0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 2), T(x64: X( 0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 3), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) << -(64 * 4), T(x64: X( 0,  0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 0), T(x64: X(~0, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 1), T(x64: X(~0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 2), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 3), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) >>  (64 * 4), T(x64: X( 0,  0,  0,  0)))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 0), T(x64: X(~0, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 1), T(x64: X(~0, ~0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 2), T(x64: X(~0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 3), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) << -(64 * 4), T(x64: X( 0,  0,  0,  0)))
    }

    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 0, T(x64: X(4, 8, 12, 16)))
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 1, T(x64: X(2, 4,  6,  8)))
        XCTAssertEqual(T(x64: X(4, 8, 12, 16)) >> 2, T(x64: X(1, 2,  3,  4)))

        XCTAssertEqual(T(x64: X(0, ~0 << 16, ~0 >> 48, 0)) >> 16, T(x64: X(0, ~0, 0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 32, ~0 >> 32, 0)) >> 32, T(x64: X(0, ~0, 0, 0)))
        XCTAssertEqual(T(x64: X(0, ~0 << 48, ~0 >> 16, 0)) >> 48, T(x64: X(0, ~0, 0, 0)))
    }
}

#endif
