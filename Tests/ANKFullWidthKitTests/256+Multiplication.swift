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
// MARK: * Int256 x Multiplication
//*============================================================================*

final class Int256TestsOnMultiplication: XCTestCase {
    
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -T(0),  T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  T(0), -T(x64:(0, 0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -T(0), -T(x64:(0, 0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  T(0),  T(x64:(0, 0, 0, 0)))
        
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -T(1),  T(x64:(1, 2, 3, 4)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  T(1), -T(x64:(1, 2, 3, 4)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -T(1), -T(x64:(1, 2, 3, 4)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  T(1),  T(x64:(1, 2, 3, 4)))
        
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -T(2),  T(x64:(2, 4, 6, 8)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  T(2), -T(x64:(2, 4, 6, 8)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -T(2), -T(x64:(2, 4, 6, 8)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  T(2),  T(x64:(2, 4, 6, 8)))

        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * T(x64:(2, 0, 0, 0)), T(x64:(2, 4, 6, 8)))
        XCTAssertEqual( T(x64:(1, 2, 3, 0)) * T(x64:(0, 2, 0, 0)), T(x64:(0, 2, 4, 6)))
        XCTAssertEqual( T(x64:(1, 2, 0, 0)) * T(x64:(0, 0, 2, 0)), T(x64:(0, 0, 2, 4)))
        XCTAssertEqual( T(x64:(1, 0, 0, 0)) * T(x64:(0, 0, 0, 2)), T(x64:(0, 0, 0, 2)))
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

        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: T(-2)) == (T(x64:(~1, ~4, ~6, ~8)), false) as (T, Bool))
        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: T( 2)) == (T(x64:( 2,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: T(-2)) == (T(x64:( 4,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: T( 2)) == (T(x64:(~3, ~4, ~6, ~8)), false) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:( 0,  0,  0,  0      )))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:( 0,  0,  0,  1 << 62)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:( 0,  0,  0, ~0 << 63)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:( 0,  0,  0, ~0 << 62)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).low,   M(x64:( 0,  0,  0, ~0 << 63)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.min).high,  T(x64:( 0,  0,  0, ~0 << 62)))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:( 1,  0,  0,  0      )))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(~0, ~0, ~0, ~0 >>  2)))
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
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T(-2)).low,  M(x64:(~1, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T(-2)).high, T(-1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T( 2)).low,  M(x64:( 2,  4,  6,  8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T( 2)).high, T( 0))

        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T(-2)).low,  M(x64:( 4,  4,  6,  8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T(-2)).high, T( 0))
        
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T( 2)).low,  M(x64:(~3, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T( 2)).high, T(-1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -Int(0),  T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  Int(0), -T(x64:(0, 0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -Int(0), -T(x64:(0, 0, 0, 0)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  Int(0),  T(x64:(0, 0, 0, 0)))
        
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -Int(1),  T(x64:(1, 2, 3, 4)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  Int(1), -T(x64:(1, 2, 3, 4)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -Int(1), -T(x64:(1, 2, 3, 4)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  Int(1),  T(x64:(1, 2, 3, 4)))
        
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) * -Int(2),  T(x64:(2, 4, 6, 8)))
        XCTAssertEqual(-T(x64:(1, 2, 3, 4)) *  Int(2), -T(x64:(2, 4, 6, 8)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) * -Int(2), -T(x64:(2, 4, 6, 8)))
        XCTAssertEqual( T(x64:(1, 2, 3, 4)) *  Int(2),  T(x64:(2, 4, 6, 8)))
    }
    
    func testMultipliedByDigitReportingOverflow() throws {
        XCTAssert(T.min.multipliedReportingOverflow(by: Int(-2)) == (T( 0), true))
        XCTAssert(T.min.multipliedReportingOverflow(by: Int( 2)) == (T( 0), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int(-2)) == (T( 2), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int( 2)) == (T(-2), true))
        
        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: Int(-2)) == (T(x64:(~1, ~4, ~6, ~8)), false) as (T, Bool))
        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: Int( 2)) == (T(x64:( 2,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: Int(-2)) == (T(x64:( 4,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: Int( 2)) == (T(x64:(~3, ~4, ~6, ~8)), false) as (T, Bool))
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
        
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: Int(-2)).low,  M(x64:(~1, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: Int(-2)).high, Int(-1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: Int( 2)).low,  M(x64:( 2,  4,  6,  8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: Int( 2)).high, Int( 0))

        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: Int(-2)).low,  M(x64:( 4,  4,  6,  8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: Int(-2)).high, Int( 0))
        
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: Int( 2)).low,  M(x64:(~3, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: Int( 2)).high, Int(-1))
    }
}

//*============================================================================*
// MARK: * UInt256 x Multiplication
//*============================================================================*

final class UInt256TestsOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * T(0), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * T(1), T(x64:(1, 2, 3, 4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * T(2), T(x64:(2, 4, 6, 8)))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * T(x64:(2, 0, 0, 0)), T(x64:(2, 4, 6, 8)))
        XCTAssertEqual(T(x64:(1, 2, 3, 0)) * T(x64:(0, 2, 0, 0)), T(x64:(0, 2, 4, 6)))
        XCTAssertEqual(T(x64:(1, 2, 0, 0)) * T(x64:(0, 0, 2, 0)), T(x64:(0, 0, 2, 4)))
        XCTAssertEqual(T(x64:(1, 0, 0, 0)) * T(x64:(0, 0, 0, 2)), T(x64:(0, 0, 0, 2)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.max.multipliedReportingOverflow(by: T( 2)) == (~T(1), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == ( T(1), true) as (T, Bool))

        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: T(2)) == (T(x64:( 2,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: T(2)) == (T(x64:(~3, ~4, ~6, ~8)),  true) as (T, Bool))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).low,  ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T( 2)).high,  T(1))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high, ~T(1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T(2)).low,  M(x64:( 2,  4,  6,  8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: T(2)).high, T(x64:( 0,  0,  0,  0)))
                
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T(2)).low,  M(x64:(~3, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: T(2)).high, T(x64:( 1,  0,  0,  0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * UInt(0), T(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * UInt(1), T(x64:(1, 2, 3, 4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)) * UInt(2), T(x64:(2, 4, 6, 8)))
    }
    
    func testMultipliedByDigitReportingOverflow() throws {
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt(2)) == ( T(0), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: UInt(2)) == (~T(1), true ) as (T, Bool))
        
        XCTAssert(T(x64:( 1,  2,  3,  4)).multipliedReportingOverflow(by: UInt(2)) == (T(x64:( 2,  4,  6,  8)), false) as (T, Bool))
        XCTAssert(T(x64:(~1, ~2, ~3, ~4)).multipliedReportingOverflow(by: UInt(2)) == (T(x64:(~3, ~4, ~6, ~8)),  true) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() throws {
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).low,     M(0))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt(2)).high, UInt(0))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).low,    ~M(1))
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt(2)).high, UInt(1))
        
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: UInt(2)).low,  M(x64:( 2,  4,  6,  8)))
        XCTAssertEqual(T(x64:( 1,  2,  3,  4)).multipliedFullWidth(by: UInt(2)).high, UInt(0))
                
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: UInt(2)).low,  M(x64:(~3, ~4, ~6, ~8)))
        XCTAssertEqual(T(x64:(~1, ~2, ~3, ~4)).multipliedFullWidth(by: UInt(2)).high, UInt(1))
    }
}

#endif
