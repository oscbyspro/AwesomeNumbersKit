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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * ANK x Int256 x Random
//*============================================================================*

final class Int256BenchmarksOnRandom: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testRandomInRangeUsingSystemRandomNumberGenerator() {
        var range = ANK.blackHoleIdentity((T.min / 2) ... (T.max / 2))
        var randomness = ANK.blackHoleIdentity(SystemRandomNumberGenerator())
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.random(in:  range, using: &randomness))
            ANK.blackHoleInoutIdentity(&range)
            ANK.blackHoleInoutIdentity(&randomness)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Random
//*============================================================================*

final class UInt256BenchmarksOnRandom: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=

    func testRandomInRangeUsingSystemRandomNumberGenerator() {
        var range = ANK.blackHoleIdentity((T.min / 2) ... (T.max / 2))
        var randomness = ANK.blackHoleIdentity(SystemRandomNumberGenerator())
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.random(in:  range, using: &randomness))
            ANK.blackHoleInoutIdentity(&range)
            ANK.blackHoleInoutIdentity(&randomness)
        }
    }
}

#endif
