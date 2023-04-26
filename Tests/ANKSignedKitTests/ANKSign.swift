//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Sign
//*============================================================================*

final class ANKSignTests: XCTestCase {
    
    typealias T = ANKSign
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Initializers
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(false), T.plus )
        XCTAssertEqual(T(true ), T.minus)
    }
    
    func testInitFloatingPointSign() {
        XCTAssertEqual(T(FloatingPointSign.plus ), T.plus )
        XCTAssertEqual(T(FloatingPointSign.minus), T.minus)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Accessors
    //=------------------------------------------------------------------------=
    
    func testBit() {
        XCTAssertEqual(T.plus .bit, false)
        XCTAssertEqual(T.minus.bit, true )
    }
    
    func testDescription() {
        XCTAssertEqual(T.plus .description, "+")
        XCTAssertEqual(T.minus.description, "-")
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Transformations
    //=------------------------------------------------------------------------=
    
    func testToggle() {
        var a = T.plus;  a.toggle(); XCTAssertEqual(a, T.minus)
        var b = T.minus; b.toggle(); XCTAssertEqual(b, T.plus )
    }
    
    func testToggled() {
        XCTAssertEqual(T.plus .toggled(), T.minus)
        XCTAssertEqual(T.minus.toggled(), T.plus )
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Transformations
    //=------------------------------------------------------------------------=
    
    func testNot() {
        XCTAssertEqual(~T.plus,  T.minus)
        XCTAssertEqual(~T.minus, T.plus )
    }
    
    func testAnd() {
        XCTAssertEqual(T.plus  & T.plus,  T.plus )
        XCTAssertEqual(T.plus  & T.minus, T.plus )
        XCTAssertEqual(T.minus & T.plus,  T.plus )
        XCTAssertEqual(T.minus & T.minus, T.minus)
    }
    
    func testOr() {
        XCTAssertEqual(T.plus  | T.plus,  T.plus )
        XCTAssertEqual(T.plus  | T.minus, T.minus)
        XCTAssertEqual(T.minus | T.plus,  T.minus)
        XCTAssertEqual(T.minus | T.minus, T.minus)
    }
    
    func testXor() {
        XCTAssertEqual(T.plus  ^ T.plus,  T.plus )
        XCTAssertEqual(T.plus  ^ T.minus, T.minus)
        XCTAssertEqual(T.minus ^ T.plus,  T.minus)
        XCTAssertEqual(T.minus ^ T.minus, T.plus )
    }
}

#endif
