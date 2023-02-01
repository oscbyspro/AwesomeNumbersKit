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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Subtraction
//*============================================================================*

final class Int256BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = Int.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = Int.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Subtraction
//*============================================================================*

final class UInt256BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = T(x64: X( 0,  1,  2,  3))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = UInt.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2, ~3))
        let rhs = UInt.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
}

#endif
