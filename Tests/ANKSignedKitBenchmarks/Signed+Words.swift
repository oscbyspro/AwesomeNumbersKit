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
// MARK: * Signed x Words
//*============================================================================*

final class SignedBenchmarksOnWords: XCTestCase {
    
    typealias T = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTrailingZeroBitCount() {
        let abc = T(3)
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.trailingZeroBitCount
        }
    }
}

#endif
