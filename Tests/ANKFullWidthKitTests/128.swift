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

private typealias X = ANK128X64
private typealias Y = ANK128X32

//*============================================================================*
// MARK: * Int128
//*============================================================================*

final class Int128Tests: XCTestCase {
    
    typealias T = ANKInt128
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), 0)
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1)), T(1) <<  64)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1)), T(1) <<  96)
    }
}

//*============================================================================*
// MARK: * UInt128
//*============================================================================*

final class UInt128Tests: XCTestCase {
    
    typealias T = ANKUInt128
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), 0)
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1)), T(1) <<  64)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1)), T(1) <<  96)
    }
}

#endif
