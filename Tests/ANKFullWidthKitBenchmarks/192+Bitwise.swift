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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * ANK x Int192 x Bitwise
//*============================================================================*

final class Int192BenchmarksOnBitwise: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs & rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs | rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs ^ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testNot() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(~abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Bitwise
//*============================================================================*

final class UInt192BenchmarksOnBitwise: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAnd() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs & rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testOr() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs | rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testXor() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs ^ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testNot() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(~abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testByteSwapped() {
        var abc = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.byteSwapped)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
