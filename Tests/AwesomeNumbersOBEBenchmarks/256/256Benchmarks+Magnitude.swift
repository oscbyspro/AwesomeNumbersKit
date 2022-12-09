//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
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
// MARK: * Int256 x Benchmarks x Magnitude
//*============================================================================*

final class Int256BenchmarksOnMagnitude: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Signed
    //=------------------------------------------------------------------------=
    
    func testNegating() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = -abc
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Benchmarks x Magnitude
//*============================================================================*

final class UInt256BenchmarksOnMagnitude: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(0, 1, 2, 3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
}

#endif
