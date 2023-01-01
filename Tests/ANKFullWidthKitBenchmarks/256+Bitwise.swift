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

//*============================================================================*
// MARK: * Int256 x Bitwise
//*============================================================================*

final class Int256BenchmarksOnBitwise: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs & rhs
        }
    }
    
    func testOr() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))

        for _ in 0 ..< 1_000_000 {
            _ = lhs | rhs
        }
    }
    
    func testXor() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))

        for _ in 0 ..< 1_000_000 {
            _ = lhs ^ rhs
        }
    }
    
    func testNot() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = ~abc
        }
    }
    
    func testByteSwapped() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.byteSwapped
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Bitwise
//*============================================================================*

final class UInt256BenchmarksOnBitwise: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs & rhs
        }
    }
    
    func testOr() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))

        for _ in 0 ..< 1_000_000 {
            _ = lhs | rhs
        }
    }
    
    func testXor() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))

        for _ in 0 ..< 1_000_000 {
            _ = lhs ^ rhs
        }
    }
    
    func testNot() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = ~abc
        }
    }
    
    func testByteSwapped() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.byteSwapped
        }
    }
}

#endif
