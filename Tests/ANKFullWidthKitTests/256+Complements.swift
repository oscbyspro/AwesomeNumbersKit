//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * Int256 x Complements
//*============================================================================*

final class Int256TestsOnComplements: XCTestCase {
    
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T( 3).magnitude, M(3))
        XCTAssertEqual(T( 0).magnitude, M(0))
        XCTAssertEqual(T(-3).magnitude, M(3))
        
        XCTAssertEqual(T.min.magnitude, M(x64:(0, 0, 0, w << (s - 1))))
        XCTAssertEqual(T.max.magnitude, M(x64:(w, w, w, w >> (0 + 1))))
    }
}

//*============================================================================*
// MARK: * UInt256 x Complements
//*============================================================================*

final class UInt256TestsOnComplements: XCTestCase {
    
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T(3).magnitude, M(3))
        XCTAssertEqual(T(0).magnitude, M(0))
        
        XCTAssertEqual(T.min.magnitude, M(x64:(0, 0, 0, w << (s - 0))))
        XCTAssertEqual(T.max.magnitude, M(x64:(w, w, w, w >> (0 + 0))))
    }
}

#endif
