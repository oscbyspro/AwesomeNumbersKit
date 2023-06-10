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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

final class ANKSignedBenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs - rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &- rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T.max)
        var rhs = ANK.blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.subtractingReportingOverflow(rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
