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
// MARK: * Int256 x Tests x Subtraction
//*============================================================================*

final class Int256TestsOnSubtraction: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual(T( 1) - T(-2), T( 3))
        XCTAssertEqual(T( 1) - T(-1), T( 2))
        XCTAssertEqual(T( 1) - T( 0), T( 1))
        XCTAssertEqual(T( 1) - T( 1), T( 0))
        XCTAssertEqual(T( 1) - T( 2), T(-1))
        
        XCTAssertEqual(T( 0) - T(-2), T( 2))
        XCTAssertEqual(T( 0) - T(-1), T( 1))
        XCTAssertEqual(T( 0) - T( 0), T( 0))
        XCTAssertEqual(T( 0) - T( 1), T(-1))
        XCTAssertEqual(T( 0) - T( 2), T(-2))
        
        XCTAssertEqual(T(-1) - T(-2), T( 1))
        XCTAssertEqual(T(-1) - T(-1), T( 0))
        XCTAssertEqual(T(-1) - T( 0), T(-1))
        XCTAssertEqual(T(-1) - T( 1), T(-2))
        XCTAssertEqual(T(-1) - T( 2), T(-3))
        
        XCTAssertEqual(T(x64:(w, w, w, 0)) - -T(x64:(3, 0, 0, 0)), T(x64:( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) - -T(x64:(0, 3, 0, 0)), T(x64:( w,  2,  0,  1)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) - -T(x64:(0, 0, 3, 0)), T(x64:( w,  w,  2,  1)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) - -T(x64:(0, 0, 0, 3)), T(x64:( w,  w,  w,  3)))
        
        XCTAssertEqual(T(x64:(w, w, w, 0)) -  T(x64:(3, 0, 0, 0)), T(x64:(~3,  w,  w,  0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) -  T(x64:(0, 3, 0, 0)), T(x64:( w, ~3,  w,  0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) -  T(x64:(0, 0, 3, 0)), T(x64:( w,  w, ~3,  0)))
        XCTAssertEqual(T(x64:(w, w, w, 0)) -  T(x64:(0, 0, 0, 3)), T(x64:( w,  w,  w, ~2)))
        
        XCTAssertEqual(T(x64:(0, 0, 0, w)) - -T(x64:(3, 0, 0, 0)), T(x64:( 3,  0,  0,  w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) - -T(x64:(0, 3, 0, 0)), T(x64:( 0,  3,  0,  w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) - -T(x64:(0, 0, 3, 0)), T(x64:( 0,  0,  3,  w)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) - -T(x64:(0, 0, 0, 3)), T(x64:( 0,  0,  0,  2)))
        
        XCTAssertEqual(T(x64:(0, 0, 0, w)) -  T(x64:(3, 0, 0, 0)), T(x64:(~2,  w,  w, ~1)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) -  T(x64:(0, 3, 0, 0)), T(x64:( 0, ~2,  w, ~1)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) -  T(x64:(0, 0, 3, 0)), T(x64:( 0,  0, ~2, ~1)))
        XCTAssertEqual(T(x64:(0, 0, 0, w)) -  T(x64:(0, 0, 0, 3)), T(x64:( 0,  0,  0, ~3)))
    }
    
    func testSubtractingWrappingAround() {
        XCTAssertEqual(T.min &- T( 1), T.max    )
        XCTAssertEqual(T.max &- T( 1), T.max - 1)
        
        XCTAssertEqual(T.min &- T(-1), T.min + 1)
        XCTAssertEqual(T.max &- T(-1), T.min    )
    }
    
    func testSubtractingReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(T( 1)) == (T.max,     true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T( 1)) == (T.max - 1, false) as (T, Bool))
        
        XCTAssert(T.min.subtractingReportingOverflow(T(-1)) == (T.min + 1, false) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T(-1)) == (T.min,     true ) as (T, Bool))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Subtraction
//*============================================================================*

final class UInt256TestsOnSubtraction: XCTestCase {
    
    typealias T = UInt256
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual(T(3) - T(0), T(3))
        XCTAssertEqual(T(3) - T(1), T(2))
        XCTAssertEqual(T(3) - T(2), T(1))
        XCTAssertEqual(T(3) - T(3), T(0))
        
        XCTAssertEqual(T(x64:(0, w, w, w)) - T(x64:(3, 0, 0, 0)), T(x64:(~2, ~1,  w,  w)))
        XCTAssertEqual(T(x64:(0, w, w, w)) - T(x64:(0, 3, 0, 0)), T(x64:( 0, ~3,  w,  w)))
        XCTAssertEqual(T(x64:(0, w, w, w)) - T(x64:(0, 0, 3, 0)), T(x64:( 0,  w, ~3,  w)))
        XCTAssertEqual(T(x64:(0, w, w, w)) - T(x64:(0, 0, 0, 3)), T(x64:( 0,  w,  w, ~3)))
    }
    
    func testSubtractingWrappingAround() {
        XCTAssertEqual(T.min &- T(1), T.max    )
        XCTAssertEqual(T.max &- T(1), T.max - 1)
    }
    
    func testSubtractingReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(T(1)) == (T.max,     true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T(1)) == (T.max - 1, false) as (T, Bool))
    }
}

#endif
