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
// MARK: * ANK x Signed x Addition
//*============================================================================*

final class ANKSignedBenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
        }
    }
    
    func testAddingWrappingAround() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T.max)
        let rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
        }
    }
}

#endif
