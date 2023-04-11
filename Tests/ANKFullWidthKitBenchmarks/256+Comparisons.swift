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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Comparisons
//*============================================================================*

final class Int256BenchmarksOnComparisons: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThan() {
        let lhs = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        let rhs = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
        }
    }
    
    func testIsLessThanZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Comparisons
//*============================================================================*

final class UInt256BenchmarksOnComparisons: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThan() {
        let lhs = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        let rhs = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs < rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isZero)
        }
    }
    
    func testIsLessThanZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isLessThanZero)
        }
    }
    
    func testIsMoreThanZero() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.isMoreThanZero)
        }
    }
}

#endif
