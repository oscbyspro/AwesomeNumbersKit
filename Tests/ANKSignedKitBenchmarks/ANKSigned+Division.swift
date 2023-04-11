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
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
        }
    }
    
    func testQuotientReportingOverflow() {
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
        }
    }
    
    func testRemainderReportingOverflow() {
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(T(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.quotientAndRemainder(dividingBy: rhs))
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividedReportingOverflow(by: rhs))
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(7, as: .plus ))
        let rhs = _blackHoleIdentity(D(3, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.remainderReportingOverflow(dividingBy: rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        let lhs = _blackHoleIdentity((T.max))
        let rhs = _blackHoleIdentity((T.max, T.max.magnitude))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.dividingFullWidth(rhs))
        }
    }
}

#endif
