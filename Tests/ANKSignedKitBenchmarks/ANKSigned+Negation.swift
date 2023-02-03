//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFullWidthKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Negation
//*============================================================================*

final class ANKSignedBenchmarksOnNegation: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        let abc = T.max
        
        for _ in 0 ..< 1_000_000 {
            _ = -abc
        }
    }
    
    func testNegatedReportingOverflow() {
        let abc = T.max
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.negatedReportingOverflow()
        }
    }
}

#endif
