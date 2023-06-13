//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Endianness
//*============================================================================*

final class Int192TestsOnEndianness: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian, l1 = UInt64(1).littleEndian
    let b2 = UInt64(2).bigEndian, l2 = UInt64(2).littleEndian
    let b3 = UInt64(3).bigEndian, l3 = UInt64(3).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(b3, b2, b1)), T(x64: X(01 ,02, 03)).bigEndian)
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(x64: X(b3, b2, b1)).bigEndian)
        
        XCTAssertEqual(T(x64: X(b3, b2, b1)), T(bigEndian: T(x64: X(01, 02, 03))))
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(bigEndian: T(x64: X(b3, b2, b1))))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(l1, l2, l3)), T(x64: X(01 ,02, 03)).littleEndian)
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(x64: X(l1, l2, l3)).littleEndian)
        
        XCTAssertEqual(T(x64: X(l1, l2, l3)), T(littleEndian: T(x64: X(01, 02, 03))))
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(littleEndian: T(x64: X(l1, l2, l3))))
    }
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X(b1, b2, b3)).byteSwapped, T(x64: X(l3, l2, l1)))
        XCTAssertEqual(T(x64: X(l1, l2, l3)).byteSwapped, T(x64: X(b3, b2, b1)))
        
        XCTAssertEqual(T(x64: X(b3, b2, b1)).byteSwapped, T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(x64: X(l3, l2, l1)).byteSwapped, T(x64: X(b1, b2, b3)))
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Endianness
//*============================================================================*

final class UInt192TestsOnEndianness: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let b1 = UInt64(1).bigEndian, l1 = UInt64(1).littleEndian
    let b2 = UInt64(2).bigEndian, l2 = UInt64(2).littleEndian
    let b3 = UInt64(3).bigEndian, l3 = UInt64(3).littleEndian
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBigEndian() {
        XCTAssertEqual(T(x64: X(b3, b2, b1)), T(x64: X(01 ,02, 03)).bigEndian)
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(x64: X(b3, b2, b1)).bigEndian)
        
        XCTAssertEqual(T(x64: X(b3, b2, b1)), T(bigEndian: T(x64: X(01, 02, 03))))
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(bigEndian: T(x64: X(b3, b2, b1))))
    }
    
    func testLittleEndian() {
        XCTAssertEqual(T(x64: X(l1, l2, l3)), T(x64: X(01 ,02, 03)).littleEndian)
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(x64: X(l1, l2, l3)).littleEndian)
        
        XCTAssertEqual(T(x64: X(l1, l2, l3)), T(littleEndian: T(x64: X(01, 02, 03))))
        XCTAssertEqual(T(x64: X(01, 02, 03)), T(littleEndian: T(x64: X(l1, l2, l3))))
    }
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X(b1, b2, b3)).byteSwapped, T(x64: X(l3, l2, l1)))
        XCTAssertEqual(T(x64: X(l1, l2, l3)).byteSwapped, T(x64: X(b3, b2, b1)))
        
        XCTAssertEqual(T(x64: X(b3, b2, b1)).byteSwapped, T(x64: X(l1, l2, l3)))
        XCTAssertEqual(T(x64: X(l3, l2, l1)).byteSwapped, T(x64: X(b1, b2, b3)))
    }
}

#endif
