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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Complements
//*============================================================================*

final class Int192TestsOnComplements: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T( 3).magnitude, M(3))
        XCTAssertEqual(T( 0).magnitude, M(0))
        XCTAssertEqual(T(-3).magnitude, M(3))
        
        XCTAssertEqual(T.min.magnitude, M(x64: X( 0,  0, ~0 << 63)))
        XCTAssertEqual(T.max.magnitude, M(x64: X(~0, ~0, ~0 >>  1)))
    }
}

//*============================================================================*
// MARK: * UInt192 x Complements
//*============================================================================*

final class UInt192TestsOnComplements: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMagnitude() {
        XCTAssertEqual(T(3).magnitude, M(3))
        XCTAssertEqual(T(0).magnitude, M(0))
        
        XCTAssertEqual(T.min.magnitude, M(x64: X( 0,  0,  0)))
        XCTAssertEqual(T.max.magnitude, M(x64: X(~0, ~0, ~0)))
    }
}

#endif
