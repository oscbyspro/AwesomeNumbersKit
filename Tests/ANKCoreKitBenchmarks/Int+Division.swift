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
import XCTest

//*============================================================================*
// MARK: * ANK x Int x Division
//*============================================================================*

final class IntBenchmarksOnDivision: XCTestCase {
    
    typealias T =  Int
    typealias M = UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
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
                
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividingFullWidth(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testDividingFullWidthReportingOverflow() {
        var lhs = ANK.blackHoleIdentity((T.max))
        var rhs = ANK.blackHoleIdentity((T.max / 2, M(bitPattern: T.max)))
                
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividingFullWidthReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt x Division
//*============================================================================*

final class UIntBenchmarksOnDivision: XCTestCase {
    
    typealias T = UInt
    typealias M = UInt
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(~T(123))
        var rhs = ANK.blackHoleIdentity( T(123))
        
        for _ in 0 ..< 5_000_000 {
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
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividingFullWidth(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testDividingFullWidthReportingOverflow() {
        var lhs = ANK.blackHoleIdentity((T.max))
        var rhs = ANK.blackHoleIdentity((T.max - 1, M.max))
        
        for _ in 0 ..< 5_000_000 {
            ANK.blackHole(lhs.dividingFullWidthReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
