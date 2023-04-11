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
// MARK: * ANK x Signed x Multiplication
//*============================================================================*

final class ANKSignedBenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedReportingOverflow() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedFullWidth() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(T(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs * rhs)
        }
    }
    
    func testMultipliedByDigitReportingOverflow() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedReportingOverflow(by: rhs))
        }
    }
    
    func testMultipliedByDigitFullWidth() {
        let lhs = _blackHoleIdentity(T(4, as: .plus ))
        let rhs = _blackHoleIdentity(D(4, as: .minus))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(lhs.multipliedFullWidth(by: rhs))
        }
    }
}

#endif
