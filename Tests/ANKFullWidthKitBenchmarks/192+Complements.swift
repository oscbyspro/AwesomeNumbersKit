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
// MARK: * Int192 x Complements
//*============================================================================*

final class Int192BenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Complements
//*============================================================================*

final class UInt192BenchmarksOnComplements: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        let abc = T(x64:(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.magnitude
        }
    }
    
    func testTwosComplement() {
        let abc = T(x64:(~0, ~1, ~2))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.twosComplement()
        }
    }
}

#endif
