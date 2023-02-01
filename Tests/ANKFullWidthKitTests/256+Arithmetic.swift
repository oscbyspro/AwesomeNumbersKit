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
// MARK: * Int256 x Arithmetic
//*============================================================================*

final class Int256TestsOnArithmetic: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x = T(x64: X(1, 2, 3, 4))
        XCTAssertEqual(x + (0 as T), x)
        XCTAssertEqual(x - (x as T), 0)
        XCTAssertEqual(x * (1 as T), x)
        XCTAssertEqual(x / (x as T), 1)
        XCTAssertEqual(x % (x as T), 0)
        XCTAssertEqual(x & (x as T), x)
        XCTAssertEqual(x | (x as T), x)
        XCTAssertEqual(x ^ (x as T), 0)
        XCTAssertEqual(  ~(~x as T), x)
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
// MARK: * UInt256 x Arithmetic
//*============================================================================*

final class UInt256TestsOnArithmetic: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x = T(x64: X(1, 2, 3, 4))
        XCTAssertEqual(x + (0 as T), x)
        XCTAssertEqual(x - (x as T), 0)
        XCTAssertEqual(x * (1 as T), x)
        XCTAssertEqual(x / (x as T), 1)
        XCTAssertEqual(x % (x as T), 0)
        XCTAssertEqual(x & (x as T), x)
        XCTAssertEqual(x | (x as T), x)
        XCTAssertEqual(x ^ (x as T), 0)
        XCTAssertEqual(  ~(~x as T), x)
    }
    
    func testStride() {
        XCTAssertEqual(T(3).advanced(by: 2), 5)
        XCTAssertEqual(T(3).distance(to: 5), 2)
    }
}

#endif
