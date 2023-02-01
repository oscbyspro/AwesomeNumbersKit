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
// MARK: * Int192 x Bitwise
//*============================================================================*

final class Int192TestsOnBitwise: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        XCTAssertEqual(~T(x64: X( 0,  1,  2)), T(x64: X(~0, ~1, ~2)))
        XCTAssertEqual(~T(x64: X(~0, ~1, ~2)), T(x64: X( 0,  1,  2)))
    }
    
    func testAnd() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X( 0,  0,  0)), T(x64: X(0, 0, 0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X( 0,  0,  0)), T(x64: X(0, 0, 0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X(~0, ~0, ~0)), T(x64: X(0, 1, 2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X(~0, ~0, ~0)), T(x64: X(2, 1, 0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X( 1,  1,  1)), T(x64: X(0, 1, 0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X( 1,  1,  1)), T(x64: X(0, 1, 0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X( 1,  1,  1)), T(x64: X( 1,  1,  3)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X( 1,  1,  1)), T(x64: X( 3,  1,  1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~1, ~2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X(~0, ~0, ~0)), T(x64: X(~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X( 1,  1,  1)), T(x64: X( 1,  0,  3)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X( 1,  1,  1)), T(x64: X( 3,  0,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0,  0,  0)).byteSwapped, T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)).byteSwapped, T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).byteSwapped, T(x64: X(~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3)).byteSwapped, T(x64: X(3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64: X(3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64: X(1, 2, 3)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Bitwise
//*============================================================================*

final class UInt192TestsOnBitwise: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        XCTAssertEqual(~T(x64: X( 0,  1,  2)), T(x64: X(~0, ~1, ~2)))
        XCTAssertEqual(~T(x64: X(~0, ~1, ~2)), T(x64: X( 0,  1,  2)))
    }
    
    func testAnd() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X(~0, ~0, ~0)), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X(~0, ~0, ~0)), T(x64: X( 2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) & T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) & T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) | T(x64: X( 1,  1,  1)), T(x64: X( 1,  1,  3)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) | T(x64: X( 1,  1,  1)), T(x64: X( 3,  1,  1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~1, ~2)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X(~0, ~0, ~0)), T(x64: X(~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64: X(0, 1, 2)) ^ T(x64: X( 1,  1,  1)), T(x64: X( 1,  0,  3)))
        XCTAssertEqual(T(x64: X(2, 1, 0)) ^ T(x64: X( 1,  1,  1)), T(x64: X( 3,  0,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).byteSwapped, T(x64: X( 0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0,  0,  0)).byteSwapped, T(x64: X( 0,  0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0)).byteSwapped, T(x64: X( 0, ~0, ~0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).byteSwapped, T(x64: X(~0, ~0, ~0)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3)).byteSwapped, T(x64: X(3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64: X(3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64: X(1, 2, 3)))
    }
}

#endif
