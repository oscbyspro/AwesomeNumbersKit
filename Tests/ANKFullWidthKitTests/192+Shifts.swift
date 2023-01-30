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

//*============================================================================*
// MARK: * Int192 x Tests x Bitwise x Shifts
//*============================================================================*

final class Int192TestsOnBitwiseShifts: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 0), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 2), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 3), T(x64:(0, 0, 0)))
        
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 0), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 2), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 3), T(x64:(0, 0, 0)))
    }
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64:(1, 2, 3)) << 0, T(x64:(1, 2,  3)))
        XCTAssertEqual(T(x64:(1, 2, 3)) << 1, T(x64:(2, 4,  6)))
        XCTAssertEqual(T(x64:(1, 2, 3)) << 2, T(x64:(4, 8, 12)))
        
        XCTAssertEqual(T(x64:(b << 48, b >> 16, 0)) << 16, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(b << 32, b >> 32, 0)) << 32, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(b << 16, b >> 48, 0)) << 48, T(x64:(0, b, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=

    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 0), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 2), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 3), T(x64:(b, b, b)))
        
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 0), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 2), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 3), T(x64:(b, b, b)))

        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 0), T(x64:(b, b, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 1), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 2), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 3), T(x64:(0, 0, 0)))

        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 0), T(x64:(b, b, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 1), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 2), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 3), T(x64:(0, 0, 0)))
    }
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 0, T(x64:(4, 8, 12)))
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 1, T(x64:(2, 4,  6)))
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 2, T(x64:(1, 2,  3)))

        XCTAssertEqual(T(x64:(0, b << 16, b >> 48)) >> 16, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, b << 32, b >> 32)) >> 32, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, b << 48, b >> 16)) >> 48, T(x64:(0, b, 0)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Tests x Bitwise x Shifts
//*============================================================================*

final class UInt192TestsOnBitwiseShifts: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x L
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 0), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 2), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(b, b, b)) <<  (64 * 3), T(x64:(0, 0, 0)))

        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 0), T(x64:(b, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 1), T(x64:(0, b, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 2), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(b, b, b)) >> -(64 * 3), T(x64:(0, 0, 0)))
    }

    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64:(1, 2, 3)) << 0, T(x64:(1, 2,  3)))
        XCTAssertEqual(T(x64:(1, 2, 3)) << 1, T(x64:(2, 4,  6)))
        XCTAssertEqual(T(x64:(1, 2, 3)) << 2, T(x64:(4, 8, 12)))

        XCTAssertEqual(T(x64:(b << 48, b >> 16, 0)) << 16, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(b << 32, b >> 32, 0)) << 32, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(b << 16, b >> 48, 0)) << 48, T(x64:(0, b, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x R
    //=------------------------------------------------------------------------=
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 0), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 1), T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 2), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, b)) >>  (64 * 3), T(x64:(0, 0, 0)))

        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 0), T(x64:(0, 0, b)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 1), T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 2), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, b)) << -(64 * 3), T(x64:(0, 0, 0)))

        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 0), T(x64:(b, b, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 1), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 2), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) >>  (64 * 3), T(x64:(0, 0, 0)))

        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 0), T(x64:(b, b, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 1), T(x64:(b, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 2), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(b, b, 0)) << -(64 * 3), T(x64:(0, 0, 0)))
    }

    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 0, T(x64:(4, 8, 12)))
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 1, T(x64:(2, 4,  6)))
        XCTAssertEqual(T(x64:(4, 8, 12)) >> 2, T(x64:(1, 2,  3)))

        XCTAssertEqual(T(x64:(0, b << 16, b >> 48)) >> 16, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, b << 32, b >> 32)) >> 32, T(x64:(0, b, 0)))
        XCTAssertEqual(T(x64:(0, b << 48, b >> 16)) >> 48, T(x64:(0, b, 0)))
    }
}

#endif
