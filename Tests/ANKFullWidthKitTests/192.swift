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
// MARK: * ANK x Int192
//*============================================================================*

final class Int192Tests: XCTestCase {
    
    typealias T =  Int192
    typealias M = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1)), T(1) << 128)
    }
    
    func testFromX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1)), T(1) << 160)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testComponentsGetSetInit() {
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 0)), T.Low(x64:(0, 0)), T.High(0))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 0)), T.Low(x64:(1, 2)), T.High(0))
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 3)), T.Low(x64:(0, 0)), T.High(3))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 3)), T.Low(x64:(1, 2)), T.High(3))
    }
}

//*============================================================================*
// MARK: * ANK x UInt192
//*============================================================================*

final class UInt192Tests: XCTestCase {
    
    typealias T = UInt192
    typealias M = UInt192

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testFromX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1)), T(1) << 128)
    }
    
    func testFromX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1)), T(1) << 160)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testComponentsGetSetInit() {
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 0)), T.Low(x64:(0, 0)), T.High(0))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 0)), T.Low(x64:(1, 2)), T.High(0))
        ANKAssertComponentsGetSetInit(T(x64: X(0, 0, 3)), T.Low(x64:(0, 0)), T.High(3))
        ANKAssertComponentsGetSetInit(T(x64: X(1, 2, 3)), T.Low(x64:(1, 2)), T.High(3))
    }
}

#endif
