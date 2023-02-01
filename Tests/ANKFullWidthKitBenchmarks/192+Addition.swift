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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Addition
//*============================================================================*

final class Int192BenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = Int.max
        
        for _ in 0 ..< 1_000_000 {
             _ = lhs + rhs
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = Int.max

        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = Int.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Addition
//*============================================================================*

final class UInt192BenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))

        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = T(x64: X( 0,  1,  2))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = T(x64: X(~0, ~1, ~2))
        let rhs = UInt.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
}

#endif
