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
// MARK: * Int256 x Tests
//*============================================================================*

final class Int256Tests: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
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
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x =  T(x64:(1, 2, 3, 4))
        XCTAssertEqual(x + 0, x)
        XCTAssertEqual(x - x, 0)
        XCTAssertEqual(x * 1, x)
        XCTAssertEqual(x / x, 1)
        XCTAssertEqual(x % x, 0)
        XCTAssertEqual(x & x, x)
        XCTAssertEqual(x | x, x)
        XCTAssertEqual(x ^ x, 0)
        XCTAssertEqual(~(~x), x)
    }

    func testAbsoluteValue() {
        XCTAssertEqual(abs(T( 3)), 3)
        XCTAssertEqual(abs(T( 0)), 0)
        XCTAssertEqual(abs(T(-3)), 3)
    }

    func testStride() {
        XCTAssertEqual(T(3).advanced(by: 2), 5)
        XCTAssertEqual(T(3).distance(to: 5), 2)
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests
//*============================================================================*

final class UInt256Tests: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
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
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x =  T(x64:(1, 2, 3, 4))
        XCTAssertEqual(x + 0, x)
        XCTAssertEqual(x - x, 0)
        XCTAssertEqual(x * 1, x)
        XCTAssertEqual(x / x, 1)
        XCTAssertEqual(x % x, 0)
        XCTAssertEqual(x & x, x)
        XCTAssertEqual(x | x, x)
        XCTAssertEqual(x ^ x, 0)
        XCTAssertEqual(~(~x), x)
    }
    
    func testStride() {
        XCTAssertEqual(T(3).advanced(by: 2), 5)
        XCTAssertEqual(T(3).distance(to: 5), 2)
    }
}

#endif
