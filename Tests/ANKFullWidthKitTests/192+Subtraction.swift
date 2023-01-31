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
        
        XCTAssertEqual(T(x64:(~0, ~0,  0)) - -T(x64:(3, 0, 0)), T(x64:( 2,  0,  1)))
        XCTAssertEqual(T(x64:(~0, ~0,  0)) - -T(x64:(0, 3, 0)), T(x64:(~0,  2,  1)))
        XCTAssertEqual(T(x64:(~0, ~0,  0)) - -T(x64:(0, 0, 3)), T(x64:(~0, ~0,  3)))
        
        XCTAssertEqual(T(x64:(~0, ~0,  0)) -  T(x64:(3, 0, 0)), T(x64:(~3, ~0,  0)))
        XCTAssertEqual(T(x64:(~0, ~0,  0)) -  T(x64:(0, 3, 0)), T(x64:(~0, ~3,  0)))
        XCTAssertEqual(T(x64:(~0, ~0,  0)) -  T(x64:(0, 0, 3)), T(x64:(~0, ~0, ~2)))
        
        XCTAssertEqual(T(x64:( 0,  0, ~0)) - -T(x64:(3, 0, 0)), T(x64:( 3,  0, ~0)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) - -T(x64:(0, 3, 0)), T(x64:( 0,  3, ~0)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) - -T(x64:(0, 0, 3)), T(x64:( 0,  0,  2)))
        
        XCTAssertEqual(T(x64:( 0,  0, ~0)) -  T(x64:(3, 0, 0)), T(x64:(~2, ~0, ~1)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) -  T(x64:(0, 3, 0)), T(x64:( 0, ~2, ~1)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) -  T(x64:(0, 0, 3)), T(x64:( 0,  0, ~3)))
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
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
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
        
        XCTAssertEqual(T(x64:(~0, ~0,  0)) - -Int(3), T(x64:( 2,  0,  1)))
        XCTAssertEqual(T(x64:(~0, ~0,  0)) -  Int(3), T(x64:(~3, ~0,  0)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) - -Int(3), T(x64:( 3,  0, ~0)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) -  Int(3), T(x64:(~2, ~0, ~1)))
    }
    
    func testSubtractingDigitWrappingAround() {
        XCTAssertEqual(T.min &- Int( 2), T.max - Int(1))
        XCTAssertEqual(T.max &- Int( 2), T.max - Int(2))
        
        XCTAssertEqual(T.min &- Int(-2), T.min + Int(2))
        XCTAssertEqual(T.max &- Int(-2), T.min + Int(1))
    }
    
    func testSubtractingDigitReportingOverflow() {
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
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual(T(3) - T(0), T(3))
        XCTAssertEqual(T(3) - T(1), T(2))
        XCTAssertEqual(T(3) - T(2), T(1))
        XCTAssertEqual(T(3) - T(3), T(0))
        
        XCTAssertEqual(T(x64:(0, ~0, ~0)) - T(x64:(3, 0, 0)), T(x64:(~2, ~1, ~0)))
        XCTAssertEqual(T(x64:(0, ~0, ~0)) - T(x64:(0, 3, 0)), T(x64:( 0, ~3, ~0)))
        XCTAssertEqual(T(x64:(0, ~0, ~0)) - T(x64:(0, 0, 3)), T(x64:( 0, ~0, ~3)))
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
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        XCTAssertEqual(T(3) - UInt(0), T(3))
        XCTAssertEqual(T(3) - UInt(1), T(2))
        XCTAssertEqual(T(3) - UInt(2), T(1))
        XCTAssertEqual(T(3) - UInt(3), T(0))
        
        XCTAssertEqual(T(x64:(~0, ~0, ~0)) - UInt(3), T(x64:(~3, ~0, ~0)))
        XCTAssertEqual(T(x64:( 0, ~0, ~0)) - UInt(3), T(x64:(~2, ~1, ~0)))
        XCTAssertEqual(T(x64:( 0,  0, ~0)) - UInt(3), T(x64:(~2, ~0, ~1)))
    }
    
    func testSubtractingDigitWrappingAround() {
        XCTAssertEqual(T.min &- UInt(2), T.max - UInt(1))
        XCTAssertEqual(T.max &- UInt(2), T.max - UInt(2))
    }
    
    func testSubtractingDigitReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(2), false) as (T, Bool))
    }
}

#endif
