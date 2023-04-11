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
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs + rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &+ rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.addingReportingOverflow(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
