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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Subtraction
//*============================================================================*

final class Int192BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Subtraction
//*============================================================================*

final class UInt192BenchmarksOnSubtraction: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = ANK.blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
