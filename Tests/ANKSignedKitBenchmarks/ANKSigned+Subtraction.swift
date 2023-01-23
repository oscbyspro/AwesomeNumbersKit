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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

final class ANKSignedBenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        let lhs = T.max
        let rhs = T.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingWrappingAround() {
        let lhs = T.max
        let rhs = T.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingReportingOverflow() {
        let lhs = T.max
        let rhs = T.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        let lhs = T.max
        let rhs = D.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs - rhs
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        let lhs = T.max
        let rhs = D.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &- rhs
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        let lhs = T.max
        let rhs = D.max
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.subtractingReportingOverflow(rhs)
        }
    }
}

#endif
