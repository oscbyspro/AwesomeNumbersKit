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
// MARK: * ANK x Signed x Addition
//*============================================================================*

final class ANKSignedBenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = T.max
        let rhs = T.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = T.max
        let rhs = T.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = T.max
        let rhs = T.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = T.max
        let rhs = D.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = T.max
        let rhs = D.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs &+ rhs
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = T.max
        let rhs = D.min
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.addingReportingOverflow(rhs)
        }
    }
}

#endif
