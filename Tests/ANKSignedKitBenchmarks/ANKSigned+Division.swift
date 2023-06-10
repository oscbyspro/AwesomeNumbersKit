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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Division
//*============================================================================*

final class ANKSignedBenchmarksOnDivision: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(3, as: .minus))
        
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
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(7, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(3, as: .minus))
        
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
        var rhs = ANK.blackHoleIdentity((T.max - 1, T.max.magnitude))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.dividingFullWidth(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
