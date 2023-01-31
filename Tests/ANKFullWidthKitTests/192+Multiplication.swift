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
// MARK: * Int192 x Multiplication
//*============================================================================*

final class Int192TestsOnMultiplication: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual( T(x64:(1, 2, 3)) * -T(0), -T(x64:(0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  T(0),  T(x64:(0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -T(0),  T(x64:(0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  T(0), -T(x64:(0, 0, 0)))
        
        XCTAssertEqual( T(x64:(1, 2, 3)) * -T(1), -T(x64:(1, 2, 3)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  T(1),  T(x64:(1, 2, 3)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -T(1),  T(x64:(1, 2, 3)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  T(1), -T(x64:(1, 2, 3)))
        
        XCTAssertEqual( T(x64:(1, 2, 3)) * -T(2), -T(x64:(2, 4, 6)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  T(2),  T(x64:(2, 4, 6)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -T(2),  T(x64:(2, 4, 6)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  T(2), -T(x64:(2, 4, 6)))

        XCTAssertEqual( T(x64:(1, 2, 3)) * T(x64:(2, 0, 0)), T(x64:(2, 4, 6)))
        XCTAssertEqual( T(x64:(1, 2, 0)) * T(x64:(0, 2, 0)), T(x64:(0, 2, 4)))
        XCTAssertEqual( T(x64:(1, 0, 0)) * T(x64:(0, 0, 2)), T(x64:(0, 0, 2)))
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

        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: T(-2)) == (T(x64:(~1, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: T( 2)) == (T(x64:( 2,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: T(-2)) == (T(x64:( 4,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: T( 2)) == (T(x64:(~3, ~4, ~6)), false) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:(0, 0, 0      )))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:(0, 0, 1 << 62)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:(0, 0, 1 << 63)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:(0, 0, b << 62)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).low,   M(x64:(0, 0, 1 << 63)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).high,  T(x64:(0, 0, b << 62)))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:(1, 0, 0      )))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(b, b, b >>  2)))
        //=--------------------------------------=
        XCTAssertEqual(T.min.multipliedFullWidth(by: T(-2)).low,   M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T(-2)).high,  T( 1))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T( 2)).low,   M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T( 2)).high,  T(-1))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T(-2)).low,   M( 2))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T(-2)).high,  T(-1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).low,  ~M( 1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).high,  T( 0))
        //=--------------------------------------=
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T(-2)).low,  M(x64:(~1, ~4, ~6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T(-2)).high, T(-1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T( 2)).low,  M(x64:( 2,  4,  6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T( 2)).high, T( 0))

        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T(-2)).low,  M(x64:( 4,  4,  6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T(-2)).high, T( 0))
        
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T( 2)).low,  M(x64:(~3, ~4, ~6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T( 2)).high, T(-1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual( T(x64:(1, 2, 3)) * -Int(0), -T(x64:(0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  Int(0),  T(x64:(0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -Int(0),  T(x64:(0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  Int(0), -T(x64:(0, 0, 0)))
        
        XCTAssertEqual( T(x64:(1, 2, 3)) * -Int(1), -T(x64:(1, 2, 3)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  Int(1),  T(x64:(1, 2, 3)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -Int(1),  T(x64:(1, 2, 3)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  Int(1), -T(x64:(1, 2, 3)))
        
        XCTAssertEqual( T(x64:(1, 2, 3)) * -Int(2), -T(x64:(2, 4, 6)))
        XCTAssertEqual( T(x64:(1, 2, 3)) *  Int(2),  T(x64:(2, 4, 6)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) * -Int(2),  T(x64:(2, 4, 6)))
        XCTAssertEqual(-T(x64:(1, 2, 3)) *  Int(2), -T(x64:(2, 4, 6)))
    }
    
    func testMultipliedByDigitReportingOverflow() throws {
        XCTAssert(T.min.multipliedReportingOverflow(by: Int(-2)) == (T( 0), true))
        XCTAssert(T.min.multipliedReportingOverflow(by: Int( 2)) == (T( 0), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int(-2)) == (T( 2), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int( 2)) == (T(-2), true))
        
        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: Int(-2)) == (T(x64:(~1, ~4, ~6)), false) as (T, Bool))
        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: Int( 2)) == (T(x64:( 2,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: Int(-2)) == (T(x64:( 4,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: Int( 2)) == (T(x64:(~3, ~4, ~6)), false) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() throws {
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int(-2)).low,    M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int(-2)).high, Int( 1))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int( 2)).low,    M( 0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int( 2)).high, Int(-1))

        XCTAssertEqual(T.max.multipliedFullWidth(by: Int(-2)).low,    M( 2))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int(-2)).high, Int(-1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int( 2)).low,   ~M( 1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int( 2)).high, Int( 0))
        
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: Int(-2)).low,  M(x64:(~1, ~4, ~6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: Int(-2)).high, Int(-1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: Int( 2)).low,  M(x64:( 2,  4,  6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: Int( 2)).high, Int( 0))

        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: Int(-2)).low,  M(x64:( 4,  4,  6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: Int(-2)).high, Int( 0))
        
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: Int( 2)).low,  M(x64:(~3, ~4, ~6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: Int( 2)).high, Int(-1))
    }
}

//*============================================================================*
// MARK: * UInt192 x Multiplication
//*============================================================================*

final class UInt192TestsOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let a = UInt  .max
    let b = UInt64.max
    let c = UInt32.max
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(T(x64:(1, 2, 3)) * T(0), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(1, 2, 3)) * T(1), T(x64:(1, 2, 3)))
        XCTAssertEqual(T(x64:(1, 2, 3)) * T(2), T(x64:(2, 4, 6)))
        
        XCTAssertEqual(T(x64:(1, 2, 3)) * T(x64:(2, 0, 0)), T(x64:(2, 4, 6)))
        XCTAssertEqual(T(x64:(1, 2, 0)) * T(x64:(0, 2, 0)), T(x64:(0, 2, 4)))
        XCTAssertEqual(T(x64:(1, 0, 0)) * T(x64:(0, 0, 2)), T(x64:(0, 0, 2)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.max.multipliedReportingOverflow(by: T( 2)) == (~T(1), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == ( T(1), true) as (T, Bool))

        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: T(2)) == (T(x64:( 2,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: T(2)) == (T(x64:(~3, ~4, ~6)),  true) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).low,  ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).high,  T(1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high, ~T(1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T(2)).low,  M(x64:( 2,  4,  6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: T(2)).high, T(x64:( 0,  0,  0)))
                
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T(2)).low,  M(x64:(~3, ~4, ~6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: T(2)).high, T(x64:( 1,  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(T(x64:(1, 2, 3)) * UInt(0), T(x64:(0, 0, 0)))
        XCTAssertEqual(T(x64:(1, 2, 3)) * UInt(1), T(x64:(1, 2, 3)))
        XCTAssertEqual(T(x64:(1, 2, 3)) * UInt(2), T(x64:(2, 4, 6)))
    }
    
    func testMultipliedByDigitReportingOverflow() throws {
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt(2)) == ( T(0), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: UInt(2)) == (~T(1), true ) as (T, Bool))
        
        XCTAssert(T(x64:( 1,  2,  3)).multipliedReportingOverflow(by: UInt(2)) == (T(x64:( 2,  4,  6)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3)).multipliedReportingOverflow(by: UInt(2)) == (T(x64:(~3, ~4, ~6)),  true) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() throws {
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).low,     M(0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).high, UInt(0))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).low,    ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).high, UInt(1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: UInt(2)).low,  M(x64:( 2,  4,  6)))
        XCTAssertEqual(T(x64:( 1,  2,  3)).multipliedFullWidth(by: UInt(2)).high, UInt(0))
                
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: UInt(2)).low,  M(x64:(~3, ~4, ~6)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3)).multipliedFullWidth(by: UInt(2)).high, UInt(1))
    }
}

#endif
