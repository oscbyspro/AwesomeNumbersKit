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

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Addition
//*============================================================================*

final class Int256BenchmarksOnAddition: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Addition
//*============================================================================*

final class UInt256BenchmarksOnAddition: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
