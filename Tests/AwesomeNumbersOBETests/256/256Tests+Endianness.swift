//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersOBE
import XCTest

//*============================================================================*
// MARK: * Int256 x Tests x Endianness
//*============================================================================*

final class Int256TestsOnEndianness: XCTestCase {
    
    typealias T = Int256
    
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
        let base = T(x64:(1, 2, 3, 4))
        let baseBigEndian = T(x64:(b4, b3, b2, b1))
        XCTAssertEqual(base.bigEndian, baseBigEndian)
        XCTAssertEqual(T(bigEndian: baseBigEndian), base)
    }
    
    func testLittleEndian() {
        let base = T(x64:(1, 2, 3, 4))
        let baseLittleEndian = T(x64:(l1, l2, l3, l4))
        XCTAssertEqual(base.littleEndian, baseLittleEndian)
        XCTAssertEqual(T(littleEndian: baseLittleEndian), base)
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Endianness
//*============================================================================*

final class UInt256TestsOnEndianness: XCTestCase {
    
    typealias T = UInt256
    
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
        let base = T(x64:(1, 2, 3, 4))
        let baseBigEndian = T(x64:(b4, b3, b2, b1))
        XCTAssertEqual(base.bigEndian, baseBigEndian)
        XCTAssertEqual(T(bigEndian: baseBigEndian), base)
    }
    
    func testLittleEndian() {
        let base = T(x64:(1, 2, 3, 4))
        let baseLittleEndian = T(x64:(l1, l2, l3, l4))
        XCTAssertEqual(base.littleEndian, baseLittleEndian)
        XCTAssertEqual(T(littleEndian: baseLittleEndian), base)
    }
}

#endif