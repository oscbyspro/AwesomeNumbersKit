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
// MARK: * Int256 x Comparison
//*============================================================================*

final class Int256BenchmarksOnComparison: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThan() {
        let lhs = T(x64:(0, 1, 2, 3))
        let rhs = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs < rhs
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isZero
        }
    }
    
    func testIsLessThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isLessThanZero
        }
    }
    
    func testIsMoreThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isMoreThanZero
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Comparison
//*============================================================================*

final class UInt256BenchmarksOnComparison: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIsLessThan() {
        let lhs = T(x64:(0, 1, 2, 3))
        let rhs = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs < rhs
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Zero
    //=------------------------------------------------------------------------=
    
    func testIsZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isZero
        }
    }
    
    func testIsLessThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isLessThanZero
        }
    }
    
    func testIsMoreThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isMoreThanZero
        }
    }
}

#endif
