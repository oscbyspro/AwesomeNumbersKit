//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import AwesomeNumbersOBE
import XCTest

//*============================================================================*
// MARK: * Int256 x Tests x Multiplication
//*============================================================================*

final class Int256TestsOnMultiplication: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    let x = T(x64:(.max, 0, 0, 0))
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        XCTAssertEqual(T( 0) * T( 0),  0)
        XCTAssertEqual(T( 0) * T( 1),  0)
        XCTAssertEqual(T( 1) * T( 0),  0)
        XCTAssertEqual(T( 1) * T( 1),  1)
        
        XCTAssertEqual(T( 0) * T( 0),  0)
        XCTAssertEqual(T( 0) * T(-1),  0)
        XCTAssertEqual(T(-1) * T( 0),  0)
        XCTAssertEqual(T(-1) * T(-1),  1)

        XCTAssertEqual(T( 2) * T( 3),  6)
        XCTAssertEqual(T( 2) * T(-3), -6)
        XCTAssertEqual(T(-2) * T( 3), -6)
        XCTAssertEqual(T(-2) * T(-3),  6)
        
        XCTAssertEqual(T(x64:(1, 2, 3, 0)) * T(x64:(4, 5, 0, 0)),  T(x64:(4, 13, 22, 15)))
        XCTAssertEqual(T(x64:(4, 5, 0, 0)) * T(x64:(1, 2, 3, 0)),  T(x64:(4, 13, 22, 15)))
        
        XCTAssertEqual(x,             T(x64:(~0,  0,  0,  0)))
        XCTAssertEqual(x * x,         T(x64:( 1, ~1,  0,  0)))
        XCTAssertEqual(x * x * x,     T(x64:(~0,  2, ~2,  0)))
        XCTAssertEqual(x * x * x * x, T(x64:( 1, ~3,  5, ~3)))

        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~1,  0,  0)))
        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1,  0, ~1, ~0)))
    }
    
    #warning("TODO")
//    func testMultiplyingReportingOverflow() {
//        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:( 0,  0,  0,  0)),            true))
//        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:( 0,  0,  0,  1 << (s - 1))), true))
//        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:( 1,  0,  0,  0)),            true))
//
//        XCTAssert(T(x64:(1, 2, 3, 4)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~0, ~2, ~3, ~4)), false))
//        XCTAssert(T(x64:(4, 3, 2, 1)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~3, ~3, ~2, ~1)), false))
//    }
    
    func testMultiplyingFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,  M(x64:( 0,  0,  0,  0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high, T(x64:( 0,  0,  0,  1 << (s - 2))))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,  M(x64:( 0,  0,  0,  1 << (s - 1))))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high, T(x64:( 0,  0,  0,  w << (s - 2))))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,  M(x64:( 1,  0,  0,  0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high, T(x64:(~0, ~0, ~0,  w >> (0 + 2))))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  M(x64:(~0, ~2, ~3, ~4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:(~0, ~0, ~0, ~0)))

        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  M(x64:(~3, ~3, ~2, ~1)))
        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:(~0, ~0, ~0, ~0)))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Multiplication
//*============================================================================*

final class UInt256TestsOnMultiplication: XCTestCase {
    
    typealias T = UInt256
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    let x = T(x64:(.max, 0, 0, 0))
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        XCTAssertEqual(T(0) * T(0), 0)
        XCTAssertEqual(T(0) * T(1), 0)
        XCTAssertEqual(T(1) * T(0), 0)
        XCTAssertEqual(T(1) * T(1), 1)
        
        XCTAssertEqual(T(2) * T(3), 6)
        XCTAssertEqual(T(3) * T(2), 6)
        
//        XCTAssertEqual(T(x64:(1, 2, 3, 0)) * T(x64:(4, 5, 0, 0)),  T(x64:(4, 13, 22, 15)))
//        XCTAssertEqual(T(x64:(4, 5, 0, 0)) * T(x64:(1, 2, 3, 0)),  T(x64:(4, 13, 22, 15)))
//        
//        XCTAssertEqual(x,             T(x64:(~0,  0,  0,  0)))
//        XCTAssertEqual(x * x,         T(x64:( 1, ~1,  0,  0)))
//        XCTAssertEqual(x * x * x,     T(x64:(~0,  2, ~2,  0)))
//        XCTAssertEqual(x * x * x * x, T(x64:( 1, ~3,  5, ~3)))

//        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~1,  0,  0)))
//        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1, ~0, ~1,  0)))
//        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~0, ~1,  0)))
//        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1,  0, ~1, ~0)))
    }
    
    #warning("TODO")
    func testMultiplyingReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:(0, 0, 0, 0)), false))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:(0, 0, 0, 0)), false))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:(1, 0, 0, 0)), true ))

        XCTAssert(T(x64:(1, 2, 3, 4)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~0, ~2, ~3, ~4)), true))
        XCTAssert(T(x64:(4, 3, 2, 1)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~3, ~3, ~2, ~1)), true))
    }
    
    func testMultiplyingFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,  M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high, T(x64:( 0, 0, 0, 0)))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,  M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high, T(x64:( 0, 0, 0, 0)))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,  M(x64:( 1, 0, 0, 0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high, T(x64:(~1, w, w, w)))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  T(x64:(~0, ~2, ~3, ~4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:( 0,  2,  3,  4)))

        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  T(x64:(~3, ~3, ~2, ~1)))
        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:( 3,  3,  2,  1)))
    }
}

#endif
