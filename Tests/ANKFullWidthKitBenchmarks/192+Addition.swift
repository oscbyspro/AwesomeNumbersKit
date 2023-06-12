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
// MARK: * ANK x Int192 x Addition
//*============================================================================*

final class Int192BenchmarksOnAddition: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
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
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Addition
//*============================================================================*

final class UInt192BenchmarksOnAddition: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
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
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
