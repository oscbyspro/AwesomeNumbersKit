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

//*============================================================================*
// MARK: * Int256 x Complements
//*============================================================================*

final class Int256BenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Complements
//*============================================================================*

final class UInt256BenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(~0, ~1, ~2, ~3))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
}

#endif