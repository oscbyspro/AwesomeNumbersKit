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
import XCTest

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Negation
//*============================================================================*

final class Int256BenchmarksOnNegation: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(-abc)
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
    
    func testNegatedReportingOverflow() {
        var abc = ANK.blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            ANK.blackHole(abc.negatedReportingOverflow())
            ANK.blackHoleInoutIdentity(&abc)
        }
    }
}

#endif
