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
// MARK: * Int192 x Subtraction
//*============================================================================*

final class Int192BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingWrappingAround() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingReportingOverflow() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = Int.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = Int.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Subtraction
//*============================================================================*

final class UInt192BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingWrappingAround() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingReportingOverflow() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = T(x64:( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        let lhs = T(x64:(~0, ~1, ~2))
        let rhs = UInt.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
}

#endif
