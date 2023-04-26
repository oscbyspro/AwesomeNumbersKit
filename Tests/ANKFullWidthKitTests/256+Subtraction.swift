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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Subtraction
//*============================================================================*

final class Int256TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKInt256
    
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
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) - -T(x64: X(3, 0, 0, 0)), T(x64: X( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) - -T(x64: X(0, 3, 0, 0)), T(x64: X(~0,  2,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) - -T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0,  2,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) - -T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0,  3)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) -  T(x64: X(3, 0, 0, 0)), T(x64: X(~3, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) -  T(x64: X(0, 3, 0, 0)), T(x64: X(~0, ~3, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) -  T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0, ~3,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) -  T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0, ~2)))
        
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - -T(x64: X(3, 0, 0, 0)), T(x64: X( 3,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - -T(x64: X(0, 3, 0, 0)), T(x64: X( 0,  3,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - -T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0,  3, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - -T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0,  2)))
        
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) -  T(x64: X(3, 0, 0, 0)), T(x64: X(~2, ~0, ~0, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) -  T(x64: X(0, 3, 0, 0)), T(x64: X( 0, ~2, ~0, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) -  T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0, ~2, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) -  T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0, ~3)))
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
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) - -Int(3), T(x64: X( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) -  Int(3), T(x64: X(~3, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - -Int(3), T(x64: X( 3,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) -  Int(3), T(x64: X(~2, ~0, ~0, ~1)))
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
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Subtraction
//*============================================================================*

final class UInt256TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        XCTAssertEqual(T(3) - T(0), T(3))
        XCTAssertEqual(T(3) - T(1), T(2))
        XCTAssertEqual(T(3) - T(2), T(1))
        XCTAssertEqual(T(3) - T(3), T(0))
        
        XCTAssertEqual(T(x64: X(0, ~0, ~0, ~0)) - T(x64: X(3, 0, 0, 0)), T(x64: X(~2, ~1, ~0, ~0)))
        XCTAssertEqual(T(x64: X(0, ~0, ~0, ~0)) - T(x64: X(0, 3, 0, 0)), T(x64: X( 0, ~3, ~0, ~0)))
        XCTAssertEqual(T(x64: X(0, ~0, ~0, ~0)) - T(x64: X(0, 0, 3, 0)), T(x64: X( 0, ~0, ~3, ~0)))
        XCTAssertEqual(T(x64: X(0, ~0, ~0, ~0)) - T(x64: X(0, 0, 0, 3)), T(x64: X( 0, ~0, ~0, ~3)))
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
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)) - UInt(3), T(x64: X(~3, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0, ~0, ~0, ~0)) - UInt(3), T(x64: X(~2, ~1, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0, ~0, ~0)) - UInt(3), T(x64: X(~2, ~0, ~1, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) - UInt(3), T(x64: X(~2, ~0, ~0, ~1)))
    }
    
    func testSubtractingDigitWrappingAround() {
        XCTAssertEqual(T.min &- UInt(2), T.max - UInt(1))
        XCTAssertEqual(T.max &- UInt(2), T.max - UInt(2))
    }
    
    func testSubtractingDigitReportingOverflow() {
        XCTAssert(T.min.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(1), true ) as (T, Bool))
        XCTAssert(T.max.subtractingReportingOverflow(UInt(2)) == (T.max - UInt(2), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
}

#endif
