//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersOBE
import XCTest

//*============================================================================*
// MARK: * Int256 x Tests x Bitwise x Shifts
//*============================================================================*

final class Int256TestsOnBitwiseShifts: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 0), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 1), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 2), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 3), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 4), T(x64:(0, 0, 0, 0)))
        
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 0), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 1), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 2), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 3), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 4), T(x64:(0, 0, 0, 0)))
    }
    
    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 0, T(x64:(1, 2,  3,  4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 1, T(x64:(2, 4,  6,  8)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 2, T(x64:(4, 8, 12, 16)))
        
        XCTAssertEqual(T(x64:(0, w << 48, w >> 16, 0)) << 16, T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, w << 32, w >> 32, 0)) << 32, T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, w << 16, w >> 48, 0)) << 48, T(x64:(0, 0, w, 0)))
    }
    
    func testBitshiftingRightByWords() {
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 0), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 2), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 3), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 4), T(x64:(w, w, w, w)))
        
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 0), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 2), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 3), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 4), T(x64:(w, w, w, w)))
        
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 0), T(x64:(w, w, w, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 2), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 3), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 4), T(x64:(0, 0, 0, 0)))
        
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 0), T(x64:(w, w, w, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 2), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 3), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 4), T(x64:(0, 0, 0, 0)))
    }
    
    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 0, T(x64:(4, 8, 12, 16)))
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 1, T(x64:(2, 4,  6,  8)))
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 2, T(x64:(1, 2,  3,  4)))
        
        XCTAssertEqual(T(x64:(0, w << 16, w >> 48, 0)) >> 16, T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w << 32, w >> 32, 0)) >> 32, T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w << 48, w >> 16, 0)) >> 48, T(x64:(0, w, 0, 0)))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Bitwise x Shifts
//*============================================================================*

final class UInt256TestsOnBitwiseShifts: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitshiftingLeftByWords() {
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 0), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 1), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 2), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 3), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) <<  (s * 4), T(x64:(0, 0, 0, 0)))

        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 0), T(x64:(w, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 1), T(x64:(0, w, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 2), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 3), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, w, w)) >> -(s * 4), T(x64:(0, 0, 0, 0)))
    }

    func testBitshiftingLeftByBits() {
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 0, T(x64:(1, 2,  3,  4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 1, T(x64:(2, 4,  6,  8)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) << 2, T(x64:(4, 8, 12, 16)))

        XCTAssertEqual(T(x64:(0, w << 48, w >> 16, 0)) << 16, T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, w << 32, w >> 32, 0)) << 32, T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, w << 16, w >> 48, 0)) << 48, T(x64:(0, 0, w, 0)))
    }

    func testBitshiftingRight() {
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 0), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 1), T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 2), T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 3), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) >>  (s * 4), T(x64:(0, 0, 0, 0)))

        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 0), T(x64:(0, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 1), T(x64:(0, 0, w, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 2), T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 3), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) << -(s * 4), T(x64:(0, 0, 0, 0)))

        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 0), T(x64:(w, w, w, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 2), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 3), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) >>  (s * 4), T(x64:(0, 0, 0, 0)))

        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 0), T(x64:(w, w, w, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 2), T(x64:(w, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 3), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) << -(s * 4), T(x64:(0, 0, 0, 0)))
    }

    func testBitshiftingRightByBits() {
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 0, T(x64:(4, 8, 12, 16)))
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 1, T(x64:(2, 4,  6,  8)))
        XCTAssertEqual(T(x64:(4, 8, 12, 16)) >> 2, T(x64:(1, 2,  3,  4)))

        XCTAssertEqual(T(x64:(0, w << 16, w >> 48, 0)) >> 16, T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w << 32, w >> 32, 0)) >> 32, T(x64:(0, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w << 48, w >> 16, 0)) >> 48, T(x64:(0, w, 0, 0)))
    }
}

#endif