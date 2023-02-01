//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFullWidthKit
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Bitwise
//*============================================================================*

final class Int192BenchmarksOnBitwise: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs & rhs
        }
    }
    
    func testOr() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))

        for _ in 0 ..< 1_000_000 {
            _ = lhs | rhs
        }
    }
    
    func testXor() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))

        for _ in 0 ..< 1_000_000 {
            _ = lhs ^ rhs
        }
    }
    
    func testNot() {
        let abc = T(x64: X(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = ~abc
        }
    }
    
    func testByteSwapped() {
        let abc = T(x64: X(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.byteSwapped
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Bitwise
//*============================================================================*

final class UInt192BenchmarksOnBitwise: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs & rhs
        }
    }
    
    func testOr() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))

        for _ in 0 ..< 1_000_000 {
            _ = lhs | rhs
        }
    }
    
    func testXor() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))

        for _ in 0 ..< 1_000_000 {
            _ = lhs ^ rhs
        }
    }
    
    func testNot() {
        let abc = T(x64: X(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = ~abc
        }
    }
    
    func testByteSwapped() {
        let abc = T(x64: X(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.byteSwapped
        }
    }
}

#endif
