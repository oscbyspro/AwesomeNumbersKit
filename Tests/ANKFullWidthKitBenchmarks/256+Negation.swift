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
import XCTest

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Negation
//*============================================================================*

final class Int256BenchmarksOnNegation: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNegated() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(-abc)
        }
    }
    
    func testNegatedReportingOverflow() {
        let abc = _blackHoleIdentity(T(x64: X(0, 1, 2, 3)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.negatedReportingOverflow())
        }
    }
}

#endif
