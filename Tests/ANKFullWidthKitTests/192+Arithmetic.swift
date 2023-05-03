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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Arithmetic
//*============================================================================*

final class Int192TestsOnArithmetic: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x = T(x64: X(1, 2, 3))
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
    
    func testAbsoluteValue() {
        XCTAssertEqual(abs(T( 3)), 3)
        XCTAssertEqual(abs(T( 0)), 0)
        XCTAssertEqual(abs(T(-3)), 3)
    }
}

//*============================================================================*
// MARK: * UInt192 x Arithmetic
//*============================================================================*

final class UInt192TestsOnArithmetic: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIdentities() {
        let x = T(x64: X(1, 2, 3))
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
