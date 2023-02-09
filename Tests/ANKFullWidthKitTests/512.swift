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

private typealias X = ANK512X64
private typealias Y = ANK512X32

//*============================================================================*
// MARK: * Int512
//*============================================================================*

final class Int512Tests: XCTestCase {
    
    typealias T = ANKInt512
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 320)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 384)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 448)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 224)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)), T(1) << 288)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 320)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 352)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 384)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 416)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 448)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 480)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        XCTAssertEqual(T.min,  (T(1) << (T.bitWidth - 1)))
    }
    
    func testInitMax() {
        XCTAssertEqual(T.max, ~(T(1) << (T.bitWidth - 1)))
    }
    
    func testInitZero() {
        XCTAssertEqual(T.zero,  T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        XCTAssertEqual(T(ascending:  (ANKUInt256(x64:(1, 2, 3, 4)), ANKInt256(x64:(5, 6, 7, 8)))), T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)))
    }

    func testInitDescending() {
        XCTAssertEqual(T(descending: (ANKInt256(x64:(5, 6, 7, 8)), ANKUInt256(x64:(1, 2, 3, 4)))), T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)))
    }
}

//*============================================================================*
// MARK: * UInt512
//*============================================================================*

final class UInt512Tests: XCTestCase {
    
    typealias T = ANKUInt512

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 320)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 384)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 448)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) << 224)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)), T(1) << 288)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 320)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 352)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 384)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 416)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 448)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 480)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        XCTAssertEqual(T.min,  T( ))
    }
    
    func testInitMax() {
        XCTAssertEqual(T.max, ~T( ))
    }
    
    func testInitZero() {
        XCTAssertEqual(T.zero, T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        XCTAssertEqual(T(ascending:  (ANKUInt256(x64:(1, 2, 3, 4)), ANKUInt256(x64:(5, 6, 7, 8)))), T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)))
    }

    func testInitDescending() {
        XCTAssertEqual(T(descending: (ANKUInt256(x64:(5, 6, 7, 8)), ANKUInt256(x64:(1, 2, 3, 4)))), T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)))
    }
}

#endif
