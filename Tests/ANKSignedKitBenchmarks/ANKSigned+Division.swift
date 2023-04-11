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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Division
//*============================================================================*

final class ANKSignedBenchmarksOnDivision: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainder() {
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(T(3, as: .minus))
        
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
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T(7, as: .plus ))
        var rhs = _blackHoleIdentity(D(3, as: .minus))
        
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
        var rhs = _blackHoleIdentity((T.max, T.max.magnitude))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividingFullWidth(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
