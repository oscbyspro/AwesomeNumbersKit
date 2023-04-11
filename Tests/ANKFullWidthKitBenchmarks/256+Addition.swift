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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Addition
//*============================================================================*

final class Int256BenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
             _blackHole(lhs + rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Addition
//*============================================================================*

final class UInt256BenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        let rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
}

#endif
