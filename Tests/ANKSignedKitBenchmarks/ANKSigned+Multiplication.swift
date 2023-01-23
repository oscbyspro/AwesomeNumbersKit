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
// MARK: * ANK x Signed x Multiplication
//*============================================================================*

final class ANKSignedBenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        let lhs = T(4, as: .plus )
        let rhs = T(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs * rhs
        }
    }
    
    func testMultipliedReportingOverflow() {
        let lhs = T(4, as: .plus )
        let rhs = T(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedReportingOverflow(by: rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        let lhs = T(4, as: .plus )
        let rhs = T(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedFullWidth(by: rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        let lhs = T(4, as: .plus )
        let rhs = D(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs * rhs
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        let lhs = T(4, as: .plus )
        let rhs = D(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedReportingOverflow(by: rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        let lhs = T(4, as: .plus )
        let rhs = D(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedFullWidth(by: rhs)
        }
    }
}

#endif
