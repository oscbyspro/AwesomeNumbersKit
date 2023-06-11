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
// MARK: * ANK x Int256 x Bitwise
//*============================================================================*

final class Int256TestsOnBitwise: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        XCTAssertEqual(~T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~1, ~2, ~3)))
        XCTAssertEqual(~T(x64: X(~0, ~1, ~2, ~3)), T(x64: X( 0,  1,  2,  3)))
    }
    
    func testAnd() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X( 1,  1,  1,  1)), T(x64: X( 0,  1,  0,  1)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  1,  0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  1,  3,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X( 1,  1,  1,  1)), T(x64: X( 3,  3,  1,  1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~1, ~2, ~3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~3, ~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  3,  2)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X( 1,  1,  1,  1)), T(x64: X( 2,  3,  0,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X( 0,  0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0,  0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0,  0)).byteSwapped, T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)).byteSwapped, T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)).byteSwapped, T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)).byteSwapped, T(x64: X(4 << 56, 3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64: X(4 << 56, 3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64: X(1, 2, 3, 4)))
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Bitwise
//*============================================================================*

final class UInt256TestsOnBitwise: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        XCTAssertEqual(~T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~1, ~2, ~3)))
        XCTAssertEqual(~T(x64: X(~0, ~1, ~2, ~3)), T(x64: X( 0,  1,  2,  3)))
    }
    
    func testAnd() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) & T(x64: X( 1,  1,  1,  1)), T(x64: X( 0,  1,  0,  1)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) & T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  1,  0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) | T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  1,  3,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) | T(x64: X( 1,  1,  1,  1)), T(x64: X( 3,  3,  1,  1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~1, ~2, ~3)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~3, ~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2, 3)) ^ T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  3,  2)))
        XCTAssertEqual(T(x64: X(3, 2, 1, 0)) ^ T(x64: X( 1,  1,  1,  1)), T(x64: X( 2,  3,  0,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X( 0,  0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0,  0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0,  0)).byteSwapped, T(x64: X( 0,  0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)).byteSwapped, T(x64: X( 0, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)).byteSwapped, T(x64: X(~0, ~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)).byteSwapped, T(x64: X(4 << 56, 3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64: X(4 << 56, 3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64: X(1, 2, 3, 4)))
    }
}

#endif
