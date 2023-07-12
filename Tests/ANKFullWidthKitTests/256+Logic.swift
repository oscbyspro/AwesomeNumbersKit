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
// MARK: * ANK x Int256 x Logic
//*============================================================================*

final class Int256TestsOnLogic: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        ANKAssertNot(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~1, ~2, ~3)))
        ANKAssertNot(T(x64: X(~0, ~1, ~2, ~3)), T(x64: X( 0,  1,  2,  3)))
    }
    
    func testAnd() {
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 0,  1,  0,  1)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  1,  0)))
    }
    
    func testOr() {
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  1,  3,  3)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 3,  3,  1,  1)))
    }
    
    func testXor() {
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~1, ~2, ~3)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~3, ~2, ~1, ~0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  3,  2)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 2,  3,  0,  1)))
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Logic
//*============================================================================*

final class UInt256TestsOnLogic: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        ANKAssertNot(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~1, ~2, ~3)))
        ANKAssertNot(T(x64: X(~0, ~1, ~2, ~3)), T(x64: X( 0,  1,  2,  3)))
    }
    
    func testAnd() {
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  0,  0,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 0,  1,  0,  1)))
        ANKAssertAnd(T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  1,  0)))
    }
    
    func testOr() {
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~0, ~0, ~0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  1,  3,  3)))
        ANKAssertOr (T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 3,  3,  1,  1)))
    }
    
    func testXor() {
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 0,  1,  2,  3)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X( 0,  0,  0,  0)), T(x64: X( 3,  2,  1,  0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~0, ~1, ~2, ~3)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X(~0, ~0, ~0, ~0)), T(x64: X(~3, ~2, ~1, ~0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2,  3)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 1,  0,  3,  2)))
        ANKAssertXor(T(x64: X( 3,  2,  1,  0)), T(x64: X( 1,  1,  1,  1)), T(x64: X( 2,  3,  0,  1)))
    }
}

#endif
