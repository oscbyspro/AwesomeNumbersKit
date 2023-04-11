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
// MARK: * Int192 x Division
//*============================================================================*

final class Int192BenchmarksOnDivision: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(Int.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(Int.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var lhs = _blackHoleIdentity((T.max))
        var rhs = _blackHoleIdentity((T.max, M.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividingFullWidth(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Division
//*============================================================================*

final class UInt192BenchmarksOnDivision: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(T(x64: X( 0,  1,  2)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(UInt.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(x64: X(~0, ~1, ~2)))
        var rhs = _blackHoleIdentity(UInt.max)

        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var lhs = _blackHoleIdentity((T.max))
        var rhs = _blackHoleIdentity((T.max, M.max))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividingFullWidth(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
