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
// MARK: * Int192 x Multiplication
//*============================================================================*

final class Int192TestsOnMultiplication: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -T(0),  T(x64: X(0, 0, 0)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  T(0), -T(x64: X(0, 0, 0)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -T(0), -T(x64: X(0, 0, 0)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  T(0),  T(x64: X(0, 0, 0)))
        
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -T(1),  T(x64: X(1, 2, 3)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  T(1), -T(x64: X(1, 2, 3)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -T(1), -T(x64: X(1, 2, 3)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  T(1),  T(x64: X(1, 2, 3)))
        
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -T(2),  T(x64: X(2, 4, 6)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  T(2), -T(x64: X(2, 4, 6)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -T(2), -T(x64: X(2, 4, 6)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  T(2),  T(x64: X(2, 4, 6)))

        XCTAssertEqual( T(x64: X(1, 2, 3)) *  T(x64: X(2, 0, 0)), T(x64: X(2, 4, 6)))
        XCTAssertEqual( T(x64: X(1, 2, 0)) *  T(x64: X(0, 2, 0)), T(x64: X(0, 2, 4)))
        XCTAssertEqual( T(x64: X(1, 0, 0)) *  T(x64: X(0, 0, 2)), T(x64: X(0, 0, 2)))
    }
    
    func testMultipliedWrappingAround() {
        XCTAssertEqual(T.min &* T.min, T( 0))
        XCTAssertEqual(T.min &* T.max, T.min)
        XCTAssertEqual(T.max &* T.min, T.min)
        XCTAssertEqual(T.max &* T.max, T( 1))
        
        XCTAssertEqual(T.min &* T(-2), T( 0))
        XCTAssertEqual(T.min &* T( 2), T( 0))
        XCTAssertEqual(T.max &* T(-2), T( 2))
        XCTAssertEqual(T.max &* T( 2), T(-2))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* T(-2), T(x64: X( 4,  4,  6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* T( 2), T(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* T(-2), T(x64: X(~1, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* T( 2), T(x64: X( 2,  4,  6)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T( 0), true) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T.min, true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.min) == (T.min, true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T( 1), true) as (T, Bool))
        
        XCTAssert(T.min.multipliedReportingOverflow(by: T(-2)) == (T( 0), true) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T( 2)) == (T( 0), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T(-2)) == (T( 2), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T( 2)) == (T(-2), true) as (T, Bool))
        
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: T(-2)) == (T(x64: X( 4,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: T( 2)) == (T(x64: X(~3, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: T(-2)) == (T(x64: X(~1, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: T( 2)) == (T(x64: X( 2,  4,  6)), false) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64: X( 0,  0,  0      )))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64: X( 0,  0,  1 << 62)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64: X( 0,  0, ~0 << 63)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64: X( 0,  0, ~0 << 62)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).low,   M(x64: X( 0,  0, ~0 << 63)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).high,  T(x64: X( 0,  0, ~0 << 62)))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64: X( 1,  0,  0      )))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64: X(~0, ~0, ~0 >>  2)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T(-2)).low,   M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T(-2)).high,  T( 1))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T( 2)).low,   M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T( 2)).high,  T(-1))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T(-2)).low,   M( 2))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T(-2)).high,  T(-1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).low,  ~M( 1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).high,  T( 0))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T(-2)).low,  M(x64: X( 4,  4,  6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T(-2)).high, T( 0))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T( 2)).low,  M(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T( 2)).high, T(-1))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T(-2)).low,  M(x64: X(~1, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T(-2)).high, T(-1))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T( 2)).low,  M(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T( 2)).high, T( 0))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -Int(0),  T(x64: X(0, 0, 0)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  Int(0), -T(x64: X(0, 0, 0)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -Int(0), -T(x64: X(0, 0, 0)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  Int(0),  T(x64: X(0, 0, 0)))
        
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -Int(1),  T(x64: X(1, 2, 3)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  Int(1), -T(x64: X(1, 2, 3)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -Int(1), -T(x64: X(1, 2, 3)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  Int(1),  T(x64: X(1, 2, 3)))
        
        XCTAssertEqual(-T(x64: X(1, 2, 3)) * -Int(2),  T(x64: X(2, 4, 6)))
        XCTAssertEqual(-T(x64: X(1, 2, 3)) *  Int(2), -T(x64: X(2, 4, 6)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) * -Int(2), -T(x64: X(2, 4, 6)))
        XCTAssertEqual( T(x64: X(1, 2, 3)) *  Int(2),  T(x64: X(2, 4, 6)))
    }
    
    func testMultipliedByDigitWrappingAround() {
        XCTAssertEqual(T.min &* Int(-2), T( 0))
        XCTAssertEqual(T.min &* Int( 2), T( 0))
        XCTAssertEqual(T.max &* Int(-2), T( 2))
        XCTAssertEqual(T.max &* Int( 2), T(-2))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* Int(-2), T(x64: X( 4,  4,  6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* Int( 2), T(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* Int(-2), T(x64: X(~1, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* Int( 2), T(x64: X( 2,  4,  6)))
    }
    
    func testMultipliedByDigitReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: Int(-2)) == (T( 0), true))
        XCTAssert(T.min.multipliedReportingOverflow(by: Int( 2)) == (T( 0), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int(-2)) == (T( 2), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int( 2)) == (T(-2), true))
        
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: Int(-2)) == (T(x64: X( 4,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: Int( 2)) == (T(x64: X(~3, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: Int(-2)) == (T(x64: X(~1, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: Int( 2)) == (T(x64: X( 2,  4,  6)), false) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int(-2)).low,    M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int(-2)).high, Int( 1))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int( 2)).low,    M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int( 2)).high, Int(-1))

        XCTAssertEqual(T.max.multipliedFullWidth(by: Int(-2)).low,    M( 2))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int(-2)).high, Int(-1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int( 2)).low,   ~M( 1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int( 2)).high, Int( 0))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: Int(-2)).low,  M(x64: X( 4,  4,  6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: Int(-2)).high, Int( 0))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: Int( 2)).low,  M(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: Int( 2)).high, Int(-1))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: Int(-2)).low,  M(x64: X(~1, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: Int(-2)).high, Int(-1))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: Int( 2)).low,  M(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: Int( 2)).high, Int( 0))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  *= 0)
            XCTAssertNotNil(x &*= 0)
            XCTAssertNotNil(x.multiplyReportingOverflow(by: 0))
            XCTAssertNotNil(x.multiplyFullWidth(by: 0))
            
            XCTAssertNotNil(x  *  0)
            XCTAssertNotNil(x &*  0)
            XCTAssertNotNil(x.multipliedReportingOverflow(by: 0))
            XCTAssertNotNil(x.multipliedFullWidth(by: 0))
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Multiplication
//*============================================================================*

final class UInt192TestsOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) * T(0), T(x64: X(0, 0, 0)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) * T(1), T(x64: X(1, 2, 3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) * T(2), T(x64: X(2, 4, 6)))
        
        XCTAssertEqual(T(x64: X(1, 2, 3)) * T(x64: X(2, 0, 0)), T(x64: X(2, 4, 6)))
        XCTAssertEqual(T(x64: X(1, 2, 0)) * T(x64: X(0, 2, 0)), T(x64: X(0, 2, 4)))
        XCTAssertEqual(T(x64: X(1, 0, 0)) * T(x64: X(0, 0, 2)), T(x64: X(0, 0, 2)))
    }
    
    func testMultipliedWrappingAround() {
        XCTAssertEqual(T.max &* T( 2), ~T(1))
        XCTAssertEqual(T.max &* T.max,  T(1))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* T(2), T(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* T(2), T(x64: X( 2,  4,  6)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.max.multipliedReportingOverflow(by: T( 2)) == (~T(1), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == ( T(1), true) as (T, Bool))
        
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: T(2)) == (T(x64: X(~3, ~4, ~6)), true ) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: T(2)) == (T(x64: X( 2,  4,  6)), false) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).low,  ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).high,  T(1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high, ~T(1))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T(2)).low,  M(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: T(2)).high, T(x64: X( 1,  0,  0)))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T(2)).low,  M(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: T(2)).high, T(x64: X( 0,  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(T(x64: X(1, 2, 3)) * UInt(0), T(x64: X(0, 0, 0)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) * UInt(1), T(x64: X(1, 2, 3)))
        XCTAssertEqual(T(x64: X(1, 2, 3)) * UInt(2), T(x64: X(2, 4, 6)))
    }
    
    func testMultipliedByDigitWeappingAround() {
        XCTAssertEqual(T.min &* UInt(2),  T(0))
        XCTAssertEqual(T.max &* UInt(2), ~T(1))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)) &* UInt(2), T(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)) &* UInt(2), T(x64: X( 2,  4,  6)))
    }
    
    func testMultipliedByDigitReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt(2)) == ( T(0), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: UInt(2)) == (~T(1), true ) as (T, Bool))
        
        XCTAssert(T(x64: X(~1, ~2, ~3)).multipliedReportingOverflow(by: UInt(2)) == (T(x64: X(~3, ~4, ~6)), true ) as (T, Bool))
        XCTAssert(T(x64: X( 1,  2,  3)).multipliedReportingOverflow(by: UInt(2)) == (T(x64: X( 2,  4,  6)), false) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).low,     M(0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).high, UInt(0))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).low,    ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).high, UInt(1))
        
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: UInt(2)).low,  M(x64: X(~3, ~4, ~6)))
        XCTAssertEqual(T(x64: X(~1, ~2, ~3)).multipliedFullWidth(by: UInt(2)).high, UInt(1))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: UInt(2)).low,  M(x64: X( 2,  4,  6)))
        XCTAssertEqual(T(x64: X( 1,  2,  3)).multipliedFullWidth(by: UInt(2)).high, UInt(0))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  *= 0)
            XCTAssertNotNil(x &*= 0)
            XCTAssertNotNil(x.multiplyReportingOverflow(by: 0))
            XCTAssertNotNil(x.multiplyFullWidth(by: 0))
            
            XCTAssertNotNil(x  *  0)
            XCTAssertNotNil(x &*  0)
            XCTAssertNotNil(x.multipliedReportingOverflow(by: 0))
            XCTAssertNotNil(x.multipliedFullWidth(by: 0))
        }
    }
}

#endif
