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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Multiplication
//*============================================================================*

final class Int192BenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Multiplication
//*============================================================================*

final class UInt192BenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
