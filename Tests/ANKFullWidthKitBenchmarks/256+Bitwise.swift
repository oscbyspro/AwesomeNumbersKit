//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Bitwise
//*============================================================================*

final class Int256BenchmarksOnBitwise: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs & rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs | rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs ^ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testNot() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(~abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Bitwise
//*============================================================================*

final class UInt256BenchmarksOnBitwise: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs & rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs | rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs ^ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testNot() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(~abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
