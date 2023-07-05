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
// MARK: * ANK x Int256 x Multiplication
//*============================================================================*

final class Int256BenchmarksOnMultiplication: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-T(x64: X(3, 0, 0, 0)))

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedWrappingAround() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-Int.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-Int.max)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-Int.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        var lhs = ANK.blackHoleIdentity( T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(-Int.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Multiplication
//*============================================================================*

final class UInt256BenchmarksOnMultiplication: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(T(x64: X(3, 0, 0, 0)))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)

        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(3, 3, 3, 0)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
