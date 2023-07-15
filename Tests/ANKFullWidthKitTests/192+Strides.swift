//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = [UInt64]
private typealias Y = [UInt64]

//*============================================================================*
// MARK: * ANK x Int192 x Strides
//*============================================================================*

final class Int192TestsOnStrides: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdvancedBy() {
        XCTAssertEqual(T.min.advanced(by:  Int.max), T.min + T(Int.max))
        XCTAssertEqual(T(  ).advanced(by:  Int.max), T(  ) + T(Int.max))
        XCTAssertEqual(T(  ).advanced(by: -Int.max), T(  ) - T(Int.max))
        XCTAssertEqual(T.max.advanced(by: -Int.max), T.max - T(Int.max))
        XCTAssertEqual(T(  ).advanced(by:  Int.min), T(  ) - T(Int.max) - T(1))
        XCTAssertEqual(T.max.advanced(by:  Int.min), T.max - T(Int.max) - T(1))
    }
    
    func testDistanceTo() {
        XCTAssertEqual(T.min.distance(to:  T.min.advanced(by:  Int.max)),  Int.max)
        XCTAssertEqual(T(  ).distance(to:  T(  ).advanced(by:  Int.max)),  Int.max)
        XCTAssertEqual(T(  ).distance(to:  T(  ).advanced(by: -Int.max)), -Int.max)
        XCTAssertEqual(T.max.distance(to:  T.max.advanced(by: -Int.max)), -Int.max)
        XCTAssertEqual(T(  ).distance(to:  T(  ).advanced(by:  Int.min)),  Int.min)
        XCTAssertEqual(T.max.distance(to:  T.max.advanced(by:  Int.min)),  Int.min)
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Stride
//*============================================================================*

final class UInt192TestsOnStrides: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdvancedBy() {
        XCTAssertEqual(T(  ).advanced(by:  Int.max), T(  ) + T(Int.max))
        XCTAssertEqual(T.max.advanced(by: -Int.max), T.max - T(Int.max))
        XCTAssertEqual(T.max.advanced(by:  Int.min), T.max - T(Int.max) - T(1))
    }
    
    func testDistanceTo() {
        XCTAssertEqual(T(  ).distance(to:  T(  ).advanced(by:  Int.max)),  Int.max)
        XCTAssertEqual(T.max.distance(to:  T.max.advanced(by: -Int.max)), -Int.max)
        XCTAssertEqual(T.max.distance(to:  T.max.advanced(by:  Int.min)),  Int.min)
    }
}

#endif
