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
// MARK: * ANK x Signed x Multiplication
//*============================================================================*

final class ANKSignedBenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs * rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitWrappingAround() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs &* rhs)
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedReportingOverflow(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        var lhs = ANK.blackHoleIdentity(T(4, as: .plus ))
        var rhs = ANK.blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(lhs.multipliedFullWidth(by: rhs))
            ANK.blackHoleInoutIdentity(&lhs)
            ANK.blackHoleInoutIdentity(&rhs)
        }
    }
}

#endif
