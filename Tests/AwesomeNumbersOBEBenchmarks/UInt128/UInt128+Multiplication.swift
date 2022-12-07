//=----------------------------------------------------------------------------=
// This source file is part of the ExtraLargeNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import AwesomeNumbersOBE
import XCTest

//*============================================================================*
// MARK: * UInt128 x Benchmarks x Multiplication
//*============================================================================*

final class UInt128BenchmarksOnMultiplication: XCTestCase {
    
    typealias T = UInt128
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultipliedFullWidth() {
        let lhs = T(x64:(~0, ~1))
        let rhs = T(x64:( 0,  1))
        
        for _ in 0 ..< 1_000_000 {
            _ = lhs.multipliedFullWidth(by: rhs)
        }
    }
}

#endif
