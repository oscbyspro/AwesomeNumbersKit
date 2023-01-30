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
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T( 3).magnitude, M(3))
        XCTAssertEqual(T( 0).magnitude, M(0))
        XCTAssertEqual(T(-3).magnitude, M(3))
        
        XCTAssertEqual(T.min.magnitude, M(x64:(0, 0, 0, b << 63)))
        XCTAssertEqual(T.max.magnitude, M(x64:(b, b, b, b >>  1)))
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
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T(3).magnitude, M(3))
        XCTAssertEqual(T(0).magnitude, M(0))
        
        XCTAssertEqual(T.min.magnitude, M(x64:(0, 0, 0, b << 64)))
        XCTAssertEqual(T.max.magnitude, M(x64:(b, b, b, b >>  0)))
    }
}

#endif
