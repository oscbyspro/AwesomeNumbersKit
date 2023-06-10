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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Division
//*============================================================================*

final class Int256BenchmarksOnDivision: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var lhs = ANK.blackHoleIdentity((T.max))
        var rhs = ANK.blackHoleIdentity((T.max / 2, M(bitPattern: T.max)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividingFullWidth(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Division
//*============================================================================*

final class UInt256BenchmarksOnDivision: XCTestCase {
    
    typealias T = UInt256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(T(x64: X( 0,  1,  2,  3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(x64: X(~0, ~1, ~2, ~3)))
        var rhs = ANK.blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var lhs = ANK.blackHoleIdentity((T.max))
        var rhs = ANK.blackHoleIdentity((T.max - 1, M.max))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividingFullWidth(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
