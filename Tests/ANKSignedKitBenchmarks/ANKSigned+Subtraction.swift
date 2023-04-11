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
// MARK: * ANK x Signed x Subtraction
//*============================================================================*

final class ANKSignedBenchmarksOnSubtraction: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs - rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingWrappingAround() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &- rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingReportingOverflow() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.subtractingReportingOverflow(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs - rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitWrappingAround() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs &- rhs)
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testSubtractingDigitReportingOverflow() {
        var lhs = _blackHoleIdentity(T.max)
        var rhs = _blackHoleIdentity(D.max)
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.subtractingReportingOverflow(rhs))
            _blackHoleInoutIdentity(&lhs)
            _blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
