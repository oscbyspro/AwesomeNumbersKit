//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import AwesomeNumbersOBE
import XCTest

//*============================================================================*
// MARK: * Int256 x Benchmarks x Comparisons
//*============================================================================*

final class Int256BenchmarksOnComparisons: XCTestCase {
    
    typealias T = Int256
    
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
    
    func testIsLessThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isLessThanZero
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Benchmarks x Comparisons
//*============================================================================*

final class UInt256BenchmarksOnComparisons: XCTestCase {
    
    typealias T = UInt256
    
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
    
    func testIsLessThanZero() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.isLessThanZero
        }
    }
}

#endif
