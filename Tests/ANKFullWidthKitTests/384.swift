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

private typealias X = ANK384X64
private typealias Y = ANK384X32

//*============================================================================*
// MARK: * Int384
//*============================================================================*

final class Int384Tests: XCTestCase {
    
    typealias T =  ANKInt384
    typealias M = ANKUInt384
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 1, 0)), T(1) << 256)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 1)), T(1) << 320)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 224)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 288)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 320)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 352)
    }
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 0, 0, 1 << 63)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 0, 0, 1 << 63)))
    }
    
    func testInitComponents() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6)), T(ascending:  LH(T.Low (x64:(1, 2, 3)), T.High(x64:(4, 5, 6)))))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6)), T(descending: HL(T.High(x64:(4, 5, 6)), T.Low (x64:(1, 2, 3)))))
    }
}

//*============================================================================*
// MARK: * UInt384
//*============================================================================*

final class UInt384Tests: XCTestCase {
    
    typealias T = ANKUInt384
    typealias M = ANKUInt384

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 1, 0)), T(1) << 256)
        XCTAssertEqual(T(x64: X(0, 0, 0, 0, 0, 1)), T(1) << 320)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0)), T(1) << 224)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 256)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 288)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 320)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 352)
    }
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 0, 0, 0)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 0, 0, 0)))
    }
    
    func testInitComponents() {
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6)), T(ascending:  LH(T.Low (x64:(1, 2, 3)), T.High(x64:(4, 5, 6)))))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4, 5, 6)), T(descending: HL(T.High(x64:(4, 5, 6)), T.Low (x64:(1, 2, 3)))))
    }
}

#endif
