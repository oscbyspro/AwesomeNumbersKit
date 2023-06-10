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
// MARK: * ANK x Signed x Addition
//*============================================================================*

final class ANKSignedBenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs + rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &+ rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testAddingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.min)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.addingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
