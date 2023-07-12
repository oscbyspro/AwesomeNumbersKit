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
// MARK: * ANK x Int192 x Logic
//*============================================================================*

final class Int192TestsOnLogic: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        ANKAssertNot(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~1, ~2)))
        ANKAssertNot(T(x64: X(~0, ~1, ~2)), T(x64: X( 0,  1,  2)))
    }
    
    func testAnd() {
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X( 0,  1,  2)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
    }
    
    func testOr() {
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 1,  1,  3)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 3,  1,  1)))
    }
    
    func testXor() {
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~1, ~2)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X(~2, ~1, ~0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 1,  0,  3)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 3,  0,  1)))
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Logic
//*============================================================================*

final class UInt192TestsOnLogic: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNot() {
        ANKAssertNot(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~1, ~2)))
        ANKAssertNot(T(x64: X(~0, ~1, ~2)), T(x64: X( 0,  1,  2)))
    }
    
    func testAnd() {
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  0,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X( 0,  1,  2)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertAnd(T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
        ANKAssertAnd(T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 0,  1,  0)))
    }
    
    func testOr() {
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~0, ~0)))
        
        ANKAssertOr (T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 1,  1,  3)))
        ANKAssertOr (T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 3,  1,  1)))
    }
    
    func testXor() {
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X( 0,  0,  0)), T(x64: X( 0,  1,  2)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X( 0,  0,  0)), T(x64: X( 2,  1,  0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X(~0, ~0, ~0)), T(x64: X(~0, ~1, ~2)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X(~0, ~0, ~0)), T(x64: X(~2, ~1, ~0)))
        
        ANKAssertXor(T(x64: X( 0,  1,  2)), T(x64: X( 1,  1,  1)), T(x64: X( 1,  0,  3)))
        ANKAssertXor(T(x64: X( 2,  1,  0)), T(x64: X( 1,  1,  1)), T(x64: X( 3,  0,  1)))
    }
}

#endif
