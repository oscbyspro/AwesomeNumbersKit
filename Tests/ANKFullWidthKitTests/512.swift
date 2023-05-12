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
    
    typealias T =  ANKInt512
    typealias M = ANKUInt512
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
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
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 0, 0, 0, 0, 1 << 63)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 0, 0, 0, 0, 1 << 63)))
    }
    
    func testInitComponents() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)), T(ascending:  LH(T.Low (x64:(1, 2, 3, 4)), T.High(x64:(5, 6, 7, 8)))))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)), T(descending: HL(T.High(x64:(5, 6, 7, 8)), T.Low (x64:(1, 2, 3, 4)))))
    }
}

//*============================================================================*
// MARK: * UInt512
//*============================================================================*

final class UInt512Tests: XCTestCase {
    
    typealias T = ANKUInt512
    typealias M = ANKUInt512

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
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
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 0, 0, 0, 0, 0)))
    }
    
    func testInitComponents() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)), T(ascending:  LH(T.Low (x64:(1, 2, 3, 4)), T.High(x64:(5, 6, 7, 8)))))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6, 7, 8)), T(descending: HL(T.High(x64:(5, 6, 7, 8)), T.Low (x64:(1, 2, 3, 4)))))
    }
}

#endif
