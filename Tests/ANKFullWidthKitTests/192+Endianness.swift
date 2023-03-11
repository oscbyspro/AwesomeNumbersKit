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
// MARK: * Int192 x Endianness
//*============================================================================*

final class Int192TestsOnEndianness: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian
    let b2 = UInt64(2).bigEndian
    let b3 = UInt64(3).bigEndian
    
    let l1 = UInt64(1).littleEndian
    let l2 = UInt64(2).littleEndian
    let l3 = UInt64(3).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(01 ,02, 03)).bigEndian,     T(x64: X(b3, b2, b1)))
        XCTAssertEqual(T(x64: X(b3, b2, b1)).bigEndian,     T(x64: X(01, 02, 03)))
        
        XCTAssertEqual(T(bigEndian: T(x64: X(01, 02, 03))), T(x64: X(b3, b2, b1)))
        XCTAssertEqual(T(bigEndian: T(x64: X(b3, b2, b1))), T(x64: X(01, 02, 03)))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(01, 02, 03)).littleEndian,     T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(x64: X(l1, l2, l3)).littleEndian,     T(x64: X(01, 02, 03)))
        
        XCTAssertEqual(T(littleEndian: T(x64: X(01, 02, 03))), T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(littleEndian: T(x64: X(l1, l2, l3))), T(x64: X(01, 02, 03)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Endianness
//*============================================================================*

final class UInt192TestsOnEndianness: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian
    let b2 = UInt64(2).bigEndian
    let b3 = UInt64(3).bigEndian
    
    let l1 = UInt64(1).littleEndian
    let l2 = UInt64(2).littleEndian
    let l3 = UInt64(3).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(01 ,02, 03)).bigEndian,     T(x64: X(b3, b2, b1)))
        XCTAssertEqual(T(x64: X(b3, b2, b1)).bigEndian,     T(x64: X(01, 02, 03)))
        
        XCTAssertEqual(T(bigEndian: T(x64: X(01, 02, 03))), T(x64: X(b3, b2, b1)))
        XCTAssertEqual(T(bigEndian: T(x64: X(b3, b2, b1))), T(x64: X(01, 02, 03)))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(01, 02, 03)).littleEndian,     T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(x64: X(l1, l2, l3)).littleEndian,     T(x64: X(01, 02, 03)))
        
        XCTAssertEqual(T(littleEndian: T(x64: X(01, 02, 03))), T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(littleEndian: T(x64: X(l1, l2, l3))), T(x64: X(01, 02, 03)))
    }
}

#endif
