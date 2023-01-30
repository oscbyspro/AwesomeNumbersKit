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
// MARK: * Int192 x Subtraction
//*============================================================================*

final class Int192TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
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
        
        XCTAssertEqual(T(x64:(b, b, 0)) - -T(x64:(3, 0, 0)), T(x64:( 2,  0,  1)))
        XCTAssertEqual(T(x64:(b, b, 0)) - -T(x64:(0, 3, 0)), T(x64:( b,  2,  1)))
        XCTAssertEqual(T(x64:(b, b, 0)) - -T(x64:(0, 0, 3)), T(x64:( b,  b,  3)))
        
        XCTAssertEqual(T(x64:(b, b, 0)) -  T(x64:(3, 0, 0)), T(x64:(~3,  b,  0)))
        XCTAssertEqual(T(x64:(b, b, 0)) -  T(x64:(0, 3, 0)), T(x64:( b, ~3,  0)))
        XCTAssertEqual(T(x64:(b, b, 0)) -  T(x64:(0, 0, 3)), T(x64:( b,  b, ~2)))
        
        XCTAssertEqual(T(x64:(0, 0, b)) - -T(x64:(3, 0, 0)), T(x64:( 3,  0,  b)))
        XCTAssertEqual(T(x64:(0, 0, b)) - -T(x64:(0, 3, 0)), T(x64:( 0,  3,  b)))
        XCTAssertEqual(T(x64:(0, 0, b)) - -T(x64:(0, 0, 3)), T(x64:( 0,  0,  2)))
        
        XCTAssertEqual(T(x64:(0, 0, b)) -  T(x64:(3, 0, 0)), T(x64:(~2,  b, ~1)))
        XCTAssertEqual(T(x64:(0, 0, b)) -  T(x64:(0, 3, 0)), T(x64:( 0, ~2, ~1)))
        XCTAssertEqual(T(x64:(0, 0, b)) -  T(x64:(0, 0, 3)), T(x64:( 0,  0, ~3)))
    }
    
    func testSubtractingWrappingAround() {
        XCTAssertEqual(T.min &- T( 2), T.max - T(1))
        XCTAssertEqual(T.max &- T( 2), T.max - T(2))
        
        XCTAssertEqual(T.min &- T(-2), T.min + T(2))
        XCTAssertEqual(T.max &- T(-2), T.min + T(1))
    }
    
    func testSubtractingReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(T( 2)) == (T.max - T(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T( 2)) == (T.max - T(2), false) as (T, Bool))
        
        XCTAssert(T.min.subtractingReportingOverflow(T(-2)) == (T.min + T(2), false) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T(-2)) == (T.min + T(1), true ) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testSubtractingInt() {
        XCTAssertEqual(T( 1) - Int(-2), T( 3))
        XCTAssertEqual(T( 1) - Int(-1), T( 2))
        XCTAssertEqual(T( 1) - Int( 0), T( 1))
        XCTAssertEqual(T( 1) - Int( 1), T( 0))
        XCTAssertEqual(T( 1) - Int( 2), T(-1))
        
        XCTAssertEqual(T( 0) - Int(-2), T( 2))
        XCTAssertEqual(T( 0) - Int(-1), T( 1))
        XCTAssertEqual(T( 0) - Int( 0), T( 0))
        XCTAssertEqual(T( 0) - Int( 1), T(-1))
        XCTAssertEqual(T( 0) - Int( 2), T(-2))
        
        XCTAssertEqual(T(-1) - Int(-2), T( 1))
        XCTAssertEqual(T(-1) - Int(-1), T( 0))
        XCTAssertEqual(T(-1) - Int( 0), T(-1))
        XCTAssertEqual(T(-1) - Int( 1), T(-2))
        XCTAssertEqual(T(-1) - Int( 2), T(-3))
        
        XCTAssertEqual(T(x64:(b, b, 0)) - -Int(3), T(x64:( 2,  0,  1)))
        XCTAssertEqual(T(x64:(b, b, 0)) -  Int(3), T(x64:(~3,  b,  0)))
        XCTAssertEqual(T(x64:(0, 0, b)) - -Int(3), T(x64:( 3,  0,  b)))
        XCTAssertEqual(T(x64:(0, 0, b)) -  Int(3), T(x64:(~2,  b, ~1)))
    }
    
    func testSubtractingIntWrappingAround() {
        XCTAssertEqual(T.min &- Int( 2), T.max - Int(1))
        XCTAssertEqual(T.max &- Int( 2), T.max - Int(2))
        
        XCTAssertEqual(T.min &- Int(-2), T.min + Int(2))
        XCTAssertEqual(T.max &- Int(-2), T.min + Int(1))
    }
    
    func testSubtractingIntReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(Int( 2)) == (T.max - Int(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(Int( 2)) == (T.max - Int(2), false) as (T, Bool))
        
        XCTAssert(T.min.subtractingReportingOverflow(Int(-2)) == (T.min + Int(2), false) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(Int(-2)) == (T.min + Int(1), true ) as (T, Bool))
    }
}

//*============================================================================*
// MARK: * UInt192 x Subtraction
//*============================================================================*

final class UInt192TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKUInt192
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual(T(3) - T(0), T(3))
        XCTAssertEqual(T(3) - T(1), T(2))
        XCTAssertEqual(T(3) - T(2), T(1))
        XCTAssertEqual(T(3) - T(3), T(0))
        
        XCTAssertEqual(T(x64:(0, b, b)) - T(x64:(3, 0, 0)), T(x64:(~2, ~1,  b)))
        XCTAssertEqual(T(x64:(0, b, b)) - T(x64:(0, 3, 0)), T(x64:( 0, ~3,  b)))
        XCTAssertEqual(T(x64:(0, b, b)) - T(x64:(0, 0, 3)), T(x64:( 0,  b, ~3)))
    }
    
    func testSubtractingWrappingAround() {
        XCTAssertEqual(T.min &- T(2), T.max - T(1))
        XCTAssertEqual(T.max &- T(2), T.max - T(2))
    }
    
    func testSubtractingReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(T(2)) == (T.max - T(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(T(2)) == (T.max - T(2), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testSubtractingUInt() {
        XCTAssertEqual(T(3) - UInt(0), T(3))
        XCTAssertEqual(T(3) - UInt(1), T(2))
        XCTAssertEqual(T(3) - UInt(2), T(1))
        XCTAssertEqual(T(3) - UInt(3), T(0))
        
        XCTAssertEqual(T(x64:(b, b, b)) - UInt(3), T(x64:(~3,  b,  b)))
        XCTAssertEqual(T(x64:(0, b, b)) - UInt(3), T(x64:(~2, ~1,  b)))
        XCTAssertEqual(T(x64:(0, 0, b)) - UInt(3), T(x64:(~2,  b, ~1)))
    }
    
    func testSubtractingUIntWrappingAround() {
        XCTAssertEqual(T.min &- UInt(2), T.max - UInt(1))
        XCTAssertEqual(T.max &- UInt(2), T.max - UInt(2))
    }
    
    func testSubtractingUIntReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(2), false) as (T, Bool))
    }
}

#endif
