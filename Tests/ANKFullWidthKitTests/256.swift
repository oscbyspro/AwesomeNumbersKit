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

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256
//*============================================================================*

final class Int256Tests: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1)), T(1) << 192)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 224)
    }
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 1 << 63)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 1 << 63)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testComponentsGetSetInit() {
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 0, 0)), T.Low(x64:(0, 0)), T.High(x64:(0, 0)))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 0, 0)), T.Low(x64:(1, 2)), T.High(x64:(0, 0)))
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 3, 4)), T.Low(x64:(0, 0)), T.High(x64:(3, 4)))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 3, 4)), T.Low(x64:(1, 2)), T.High(x64:(3, 4)))
    }
}

//*============================================================================*
// MARK: * ANK x UInt256
//*============================================================================*

final class UInt256Tests: XCTestCase {
    
    typealias T = UInt256
    typealias M = UInt256

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x64: X(0, 0, 0, 1)), T(1) << 192)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), T(1) << 160)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), T(1) << 192)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), T(1) << 224)
    }
    
    func testInitZero() {
        XCTAssertEqual(T(   ), T(x64: X(0, 0, 0, 0)))
        XCTAssertEqual(T.zero, T(x64: X(0, 0, 0, 0)))
    }
    
    func testInitEdges() {
        XCTAssertEqual(T.min,  T(x64: X(0, 0, 0, 0)))
        XCTAssertEqual(T.max, ~T(x64: X(0, 0, 0, 0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testComponentsGetSetInit() {
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 0, 0)), T.Low(x64:(0, 0)), T.High(x64:(0, 0)))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 0, 0)), T.Low(x64:(1, 2)), T.High(x64:(0, 0)))
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 3, 4)), T.Low(x64:(0, 0)), T.High(x64:(3, 4)))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 3, 4)), T.Low(x64:(1, 2)), T.High(x64:(3, 4)))
    }
}

#endif
