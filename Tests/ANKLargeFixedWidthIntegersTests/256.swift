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
// MARK: * Int256
//*============================================================================*

final class Int256Tests: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), 0)
    }
    
    func testInitWithUInt64() {
        XCTAssertEqual(T(x64:(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64:(0, 1, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64:(0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x64:(0, 0, 0, 1)), T(1) << 192)
    }
    
    func testInitWithUInt32() {
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32:(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32:(0, 0, 1, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32:(0, 0, 0, 1, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 192)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 224)
    }
}

//*============================================================================*
// MARK: * UInt256
//*============================================================================*

final class UInt256Tests: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(), 0)
    }
    
    func testInitWithUInt64() {
        XCTAssertEqual(T(x64:(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64:(0, 1, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64:(0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x64:(0, 0, 0, 1)), T(1) << 192)
    }
    
    func testInitWithUInt32() {        
        XCTAssertEqual(T(x32:(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32:(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32:(0, 0, 1, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32:(0, 0, 0, 1, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 192)
        XCTAssertEqual(T(x32:(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 224)
    }
}

#endif
