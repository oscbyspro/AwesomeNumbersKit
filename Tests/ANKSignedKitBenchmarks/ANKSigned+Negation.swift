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
// MARK: * ANK x Signed x Negation
//*============================================================================*

final class ANKSignedBenchmarksOnNegation: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(-abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testNegatedReportingOverflow() {
        var abc = ANK.blackHoleIdentity(T.max)
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.negatedReportingOverflow())
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
