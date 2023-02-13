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
import XCTest

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Random
//*============================================================================*

final class Int256BenchmarksOnRandom: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testRandomInRangeUsingSystemRandomNumberGenerator() {
        let range = (T.min / 2) ... (T.max / 2)
        var randomness = SystemRandomNumberGenerator()
        
        for _ in 0 ..< 50_000 {
            _ = T.random(in: range, using: &randomness)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Random
//*============================================================================*

final class UInt256BenchmarksOnRandom: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=

    func testRandomInRangeUsingSystemRandomNumberGenerator() {
        let range = (T.min / 2) ... (T.max / 2)
        var randomness = SystemRandomNumberGenerator()
        
        for _ in 0 ..< 50_000 {
            _ = T.random(in: range, using: &randomness)
        }
    }
}

#endif