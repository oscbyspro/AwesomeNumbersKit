//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

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
        let lhs = T(7, as: .plus )
        let rhs = T(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
    
    func testQuotientReportingOverflow() {
        let lhs = T(7, as: .plus )
        let rhs = T(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.dividedReportingOverflow(by: rhs)
        }
    }
    
    func testRemainderReportingOverflow() {
        let lhs = T(7, as: .plus )
        let rhs = T(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.remainderReportingOverflow(dividingBy: rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testQuotientAndRemainderDividingByDigit() {
        let lhs = T(7, as: .plus )
        let rhs = D(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.quotientAndRemainder(dividingBy: rhs)
        }
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        let lhs = T(7, as: .plus )
        let rhs = D(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.dividedReportingOverflow(by: rhs)
        }
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        let lhs = T(7, as: .plus )
        let rhs = D(3, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.remainderReportingOverflow(dividingBy: rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        let lhs = (T.max)
        let rhs = (T.max, T.max.magnitude)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.dividingFullWidth(rhs)
        }
    }
}

#endif
