//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * Signed x Multiplication
//*============================================================================*

final class SignedBenchmarksOnMultiplication: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
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
    
    func testMultipliedFullWidth() {
        let lhs = T(4, as: .plus )
        let rhs = T(4, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedFullWidth(by: rhs)
        }
    }
}

#endif
