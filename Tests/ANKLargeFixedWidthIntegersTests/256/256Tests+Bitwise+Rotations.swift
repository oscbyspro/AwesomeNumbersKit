//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKLargeFixedWidthIntegers
import XCTest

//*============================================================================*
// MARK: * Int256 x Tests x Bitwise x Rotations
//*============================================================================*

final class Int256TestsOnBitwiseRotations: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=----------------------------------------------------------------------------=
    // MARK: Tests
    //=----------------------------------------------------------------------------=
    
    func testBitrotatingLeftByWords() {
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 3), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 4), T(x64:(0, w, w, 0)))

        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 3), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 4), T(x64:(0, w, w, 0)))
    }
    
    func testBitrotatingLeftByBits() {
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 0), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 2), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))

        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-0), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-2), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
    }

    func testBitrotatingRightByWords() {
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 3), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 4), T(x64:(0, w, w, 0)))

        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 3), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 4), T(x64:(0, w, w, 0)))
    }

    func testBitrotatingRightByBits() {
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 0), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 2), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))

        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-0), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-2), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Bitwise x Rotations
//*============================================================================*

final class UInt256TestsOnBitwiseRotations: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=----------------------------------------------------------------------------=
    // MARK: Tests
    //=----------------------------------------------------------------------------=
    
    func testBitrotatingLeftByWords() {
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 3), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<<  (s * 4), T(x64:(0, w, w, 0)))

        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 1), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 3), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>> -(s * 4), T(x64:(0, w, w, 0)))
    }
    
    func testBitrotatingLeftByBits() {
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 0), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &<< ( 2), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))

        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-0), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(0, 0, 0, 3 << (s - 2))) &>> (-2), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
    }

    func testBitrotatingRightByWords() {
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 3), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &>>  (s * 4), T(x64:(0, w, w, 0)))

        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 0), T(x64:(0, w, w, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 1), T(x64:(w, w, 0, 0)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 2), T(x64:(w, 0, 0, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 3), T(x64:(0, 0, w, w)))
        XCTAssertEqual(T(x64:(0, w, w, 0)) &<< -(s * 4), T(x64:(0, w, w, 0)))
    }

    func testBitrotatingRightByBits() {
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 0), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &>> ( 2), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))

        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-0), T(x64:(3 >> 0, 0, 0, 3 << (s - 0))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-1), T(x64:(3 >> 1, 0, 0, 3 << (s - 1))))
        XCTAssertEqual(T(x64:(3, 0, 0, 0)) &<< (-2), T(x64:(3 >> 2, 0, 0, 3 << (s - 2))))
    }
}

#endif
