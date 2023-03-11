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
// MARK: * Int256 x Endianness
//*============================================================================*

final class Int256TestsOnEndianness: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian
    let b2 = UInt64(2).bigEndian
    let b3 = UInt64(3).bigEndian
    let b4 = UInt64(4).bigEndian

    let l1 = UInt64(1).littleEndian
    let l2 = UInt64(2).littleEndian
    let l3 = UInt64(3).littleEndian
    let l4 = UInt64(4).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(01 ,02, 03, 04)).bigEndian,     T(x64: X(b4, b3, b2, b1)))
        XCTAssertEqual(T(x64: X(b4, b3, b2, b1)).bigEndian,     T(x64: X(01, 02, 03, 04)))
        
        XCTAssertEqual(T(bigEndian: T(x64: X(01, 02, 03, 04))), T(x64: X(b4, b3, b2, b1)))
        XCTAssertEqual(T(bigEndian: T(x64: X(b4, b3, b2, b1))), T(x64: X(01, 02, 03, 04)))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(01, 02, 03, 04)).littleEndian,     T(x64: X(l1, l2, l3, l4)))
        XCTAssertEqual(T(x64: X(l1, l2, l3, l4)).littleEndian,     T(x64: X(01, 02, 03, 04)))
        
        XCTAssertEqual(T(littleEndian: T(x64: X(01, 02, 03, 04))), T(x64: X(l1, l2, l3, l4)))
        XCTAssertEqual(T(littleEndian: T(x64: X(l1, l2, l3, l4))), T(x64: X(01, 02, 03, 04)))
    }
}

//*============================================================================*
// MARK: * UInt256 x Endianness
//*============================================================================*

final class UInt256TestsOnEndianness: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian
    let b2 = UInt64(2).bigEndian
    let b3 = UInt64(3).bigEndian
    let b4 = UInt64(4).bigEndian

    let l1 = UInt64(1).littleEndian
    let l2 = UInt64(2).littleEndian
    let l3 = UInt64(3).littleEndian
    let l4 = UInt64(4).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(01 ,02, 03, 04)).bigEndian,     T(x64: X(b4, b3, b2, b1)))
        XCTAssertEqual(T(x64: X(b4, b3, b2, b1)).bigEndian,     T(x64: X(01, 02, 03, 04)))
        
        XCTAssertEqual(T(bigEndian: T(x64: X(01, 02, 03, 04))), T(x64: X(b4, b3, b2, b1)))
        XCTAssertEqual(T(bigEndian: T(x64: X(b4, b3, b2, b1))), T(x64: X(01, 02, 03, 04)))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(01, 02, 03, 04)).littleEndian,     T(x64: X(l1, l2, l3, l4)))
        XCTAssertEqual(T(x64: X(l1, l2, l3, l4)).littleEndian,     T(x64: X(01, 02, 03, 04)))
        
        XCTAssertEqual(T(littleEndian: T(x64: X(01, 02, 03, 04))), T(x64: X(l1, l2, l3, l4)))
        XCTAssertEqual(T(littleEndian: T(x64: X(l1, l2, l3, l4))), T(x64: X(01, 02, 03, 04)))
    }
}

#endif
