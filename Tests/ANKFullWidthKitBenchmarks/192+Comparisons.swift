//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFoundation
import ANKFullWidthKit
import XCTest

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Comparisons
//*============================================================================*

final class Int192BenchmarksOnComparisons: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsEqualTo() {
        var lhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs == rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testIsLessThan() {
        var lhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsFull() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isFull)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsLessThanZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsPowerOf2() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isPowerOf2)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMatchesRepeatingBit() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var bit = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.matches(repeating: bit))
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&bit)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Comparisons
//*============================================================================*

final class UInt192BenchmarksOnComparisons: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsEqualTo() {
        var lhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs == rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testIsLessThan() {
        var lhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var rhs = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsFull() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isFull)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsLessThanZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsMoreThanZero() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testIsPowerOf2() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isPowerOf2)
            _blackHoleInoutIdentity(&abc)
        }
    }
    
    func testMatchesRepeatingBit() {
        var abc = _blackHoleIdentity(T(x64: X(0, 1, 2)))
        var bit = _blackHoleIdentity(true)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.matches(repeating: bit))
            _blackHoleInoutIdentity(&abc)
            _blackHoleInoutIdentity(&bit)
        }
    }
}

#endif
