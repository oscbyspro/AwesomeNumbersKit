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
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedFullWidth() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
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
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedFullWidth() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(T(x64: X(3, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        let lhs = _blackHoleIdentity(T(x64: X(3, 3, 0)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
        }
    }
}

#endif
