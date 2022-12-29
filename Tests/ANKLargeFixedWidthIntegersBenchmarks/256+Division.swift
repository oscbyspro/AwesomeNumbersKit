//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKLargeFixedWidthIntegers
import XCTest

//*============================================================================*
// MARK: * Int256 x Division
//*============================================================================*

final class Int256BenchmarksOnDivision: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
    
    func testQuotientAndRemainderDividingByInt() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Division
//*============================================================================*

final class UInt256BenchmarksOnDivision: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = T(x64:( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
    
    func testQuotientAndRemainderDividingByUInt() {
        let lhs = T(x64:(~0, ~1, ~2, ~3))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
}

#endif