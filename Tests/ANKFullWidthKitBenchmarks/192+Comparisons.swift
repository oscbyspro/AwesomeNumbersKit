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

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Comparisons
//*============================================================================*

final class Int192BenchmarksOnComparisons: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsEqualTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs == rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testIsLessThan() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs < rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testComparedTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.compared(to: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsLessThanZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isLessThanZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isMoreThanZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsPowerOf2() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isPowerOf2)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Comparisons
//*============================================================================*

final class UInt192BenchmarksOnComparisons: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsEqualTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs == rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testIsLessThan() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs < rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testComparedTo() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.compared(to: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsLessThanZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isLessThanZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isMoreThanZero)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsPowerOf2() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.isPowerOf2)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
