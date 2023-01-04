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
// MARK: * Signed x Addition
//*============================================================================*

final class SignedBenchmarksOnAddition: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        let lhs = T(UInt.max, as: .plus )
        let rhs = T(UInt.max, as: .minus)
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs + rhs
        }
    }
}

#endif
