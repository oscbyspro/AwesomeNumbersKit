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

//*============================================================================*
// MARK: * Int192 x Bitwise
//*============================================================================*

final class Int192TestsOnBitwise: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(0, 0, 0)), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(0, 0, 0)), T(x64:(0, 0, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(w, w, w)), T(x64:(0, 1, 2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(w, w, w)), T(x64:(2, 1, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(1, 1, 1)), T(x64:(0, 1, 0)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(1, 1, 1)), T(x64:(0, 1, 0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(0, 0, 0)), T(x64:(0, 1, 2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(0, 0, 0)), T(x64:(2, 1, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(w, w, w)), T(x64:(w, w, w)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(w, w, w)), T(x64:(w, w, w)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(1, 1, 1)), T(x64:(1, 1, 3)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(1, 1, 1)), T(x64:(3, 1, 1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(0, 0, 0)), T(x64:( 0,  1,  2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(0, 0, 0)), T(x64:( 2,  1,  0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(w, w, w)), T(x64:(~0, ~1, ~2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(w, w, w)), T(x64:(~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(1, 1, 1)), T(x64:( 1,  0,  3)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(1, 1, 1)), T(x64:( 3,  0,  1)))
    }
    
    func testNot() {
        XCTAssertEqual(~T(x64:( 0,  1,  2)), T(x64:(~0, ~1, ~2)))
        XCTAssertEqual(~T(x64:(~0, ~1, ~2)), T(x64:( 0,  1,  2)))
    }
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64:(0, 0, 0)).byteSwapped, T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(w, 0, 0)).byteSwapped, T(x64:(0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, 0)).byteSwapped, T(x64:(0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w)).byteSwapped, T(x64:(w, w, w)))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).byteSwapped, T(x64:(3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64:(3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64:(1, 2, 3)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Bitwise
//*============================================================================*

final class UInt192TestsOnBitwise: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(0, 0, 0)), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(0, 0, 0)), T(x64:(0, 0, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(w, w, w)), T(x64:(0, 1, 2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(w, w, w)), T(x64:(2, 1, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) & T(x64:(1, 1, 1)), T(x64:(0, 1, 0)))
        XCTAssertEqual(T(x64:(2, 1, 0)) & T(x64:(1, 1, 1)), T(x64:(0, 1, 0)))
    }
    
    func testOr() {
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(0, 0, 0)), T(x64:(0, 1, 2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(0, 0, 0)), T(x64:(2, 1, 0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(w, w, w)), T(x64:(w, w, w)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(w, w, w)), T(x64:(w, w, w)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) | T(x64:(1, 1, 1)), T(x64:(1, 1, 3)))
        XCTAssertEqual(T(x64:(2, 1, 0)) | T(x64:(1, 1, 1)), T(x64:(3, 1, 1)))
    }
    
    func testXor() {
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(0, 0, 0)), T(x64:( 0,  1,  2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(0, 0, 0)), T(x64:( 2,  1,  0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(w, w, w)), T(x64:(~0, ~1, ~2)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(w, w, w)), T(x64:(~2, ~1, ~0)))
        
        XCTAssertEqual(T(x64:(0, 1, 2)) ^ T(x64:(1, 1, 1)), T(x64:( 1,  0,  3)))
        XCTAssertEqual(T(x64:(2, 1, 0)) ^ T(x64:(1, 1, 1)), T(x64:( 3,  0,  1)))
    }
    
    func testNot() {
        XCTAssertEqual(~T(x64:( 0,  1,  2)), T(x64:(~0, ~1, ~2)))
        XCTAssertEqual(~T(x64:(~0, ~1, ~2)), T(x64:( 0,  1,  2)))
    }
    
    func testByteSwapped() {
        XCTAssertEqual(T(x64:(0, 0, 0)).byteSwapped, T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(w, 0, 0)).byteSwapped, T(x64:(0, 0, w)))
        XCTAssertEqual(T(x64:(w, w, 0)).byteSwapped, T(x64:(0, w, w)))
        XCTAssertEqual(T(x64:(w, w, w)).byteSwapped, T(x64:(w, w, w)))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).byteSwapped, T(x64:(3 << 56, 2 << 56, 1 << 56)))
        XCTAssertEqual(T(x64:(3 << 56, 2 << 56, 1 << 56)).byteSwapped, T(x64:(1, 2, 3)))
    }
}

#endif
