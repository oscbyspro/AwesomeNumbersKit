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
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(T( 2) * T( 3), T( 6))
        XCTAssertEqual(T( 2) * T(-3), T(-6))
        XCTAssertEqual(T(-2) * T( 3), T(-6))
        XCTAssertEqual(T(-2) * T(-3), T( 6))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 0)) * T(x64:(4, 5, 0, 0)),  T(x64:(4, 13, 22, 15)))
        XCTAssertEqual(T(x64:(4, 5, 0, 0)) * T(x64:(1, 2, 3, 0)),  T(x64:(4, 13, 22, 15)))
        
        XCTAssertEqual(T(w),                      T(x64:(~0,  0,  0,  0)))
        XCTAssertEqual(T(w) * T(w),               T(x64:( 1, ~1,  0,  0)))
        XCTAssertEqual(T(w) * T(w) * T(w),        T(x64:(~0,  2, ~2,  0)))
        XCTAssertEqual(T(w) * T(w) * T(w) * T(w), T(x64:( 1, ~3,  5, ~3)))

        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~1,  0,  0)))
        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1,  0, ~1, ~0)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:( 0,  0,  0,  0)),            true) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:( 0,  0,  0,  1 << (s - 1))), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:( 1,  0,  0,  0)),            true) as (T, Bool))

        XCTAssert(T(x64:(1, 2, 3, 4)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~0, ~2, ~3, ~4)), false))
        XCTAssert(T(x64:(4, 3, 2, 1)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~3, ~3, ~2, ~1)), false))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:( 0,  0,  0,  0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:( 0,  0,  0,  1 << (s - 2))))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:( 0,  0,  0,  1 << (s - 1))))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:( 0,  0,  0,  w << (s - 2))))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:( 1,  0,  0,  0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(~0, ~0, ~0,  w >> (0 + 2))))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  M(x64:(~0, ~2, ~3, ~4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:(~0, ~0, ~0, ~0)))

        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  M(x64:(~3, ~3, ~2, ~1)))
        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:(~0, ~0, ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(T( 2) * Int( 3), T( 6))
        XCTAssertEqual(T( 2) * Int(-3), T(-6))
        XCTAssertEqual(T(-2) * Int( 3), T(-6))
        XCTAssertEqual(T(-2) * Int(-3), T( 6))
    }

    func testMultipliedByDigitReportingOverflow() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssert(T.min.multipliedReportingOverflow(by: Int.min) == (T(x64:(      0,  0,  0,          (0))), true))
        XCTAssert(T.min.multipliedReportingOverflow(by: Int.max) == (T(x64:(      0,  0,  0, 1 << (s - 1))), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int.max) == (T(x64:(2 + w/2,  w,  w,      (w / 2))), true))
    }
    
    func testMultipliedByDigitFullWidth() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.min).low,   M(x64:(0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.min).high,  Int(+1 << (s - 2)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.max).low,   M(x64:(0, 0, 0, 1 << (s - 1))))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.max).high,  Int(~0 << (s - 2)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: Int.max).low,   M(x64:(2 + w/2, w, w, w/2)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int.max).high,  Int( w >> (0 + 2)))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: Int(5)).low,   M(x64:(5, 10, 15, 20)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: Int(5)).high,  0 as Int)

        XCTAssertEqual(T(x64:(w, w, w, w)).multipliedFullWidth(by: Int(5)).low,   M(x64:(~4, w,  w,  w)))
        XCTAssertEqual(T(x64:(w, w, w, w)).multipliedFullWidth(by: Int(5)).high, -1 as Int)
    }
}

//*============================================================================*
// MARK: * UInt256 x Multiplication
//*============================================================================*

final class UInt256TestsOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplied() {
        XCTAssertEqual(T(2) * T(3), T(6))
        XCTAssertEqual(T(3) * T(2), T(6))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 0)) * T(x64:(4, 5, 0, 0)),  T(x64:(4, 13, 22, 15)))
        XCTAssertEqual(T(x64:(4, 5, 0, 0)) * T(x64:(1, 2, 3, 0)),  T(x64:(4, 13, 22, 15)))
        
        XCTAssertEqual(T(w),                      T(x64:(~0,  0,  0,  0)))
        XCTAssertEqual(T(w) * T(w),               T(x64:( 1, ~1,  0,  0)))
        XCTAssertEqual(T(w) * T(w) * T(w),        T(x64:(~0,  2, ~2,  0)))
        XCTAssertEqual(T(w) * T(w) * T(w) * T(w), T(x64:( 1, ~3,  5, ~3)))

        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~1,  0,  0)))
        XCTAssertEqual(T(x64:(w, 0, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, 0, 0, 0)), T(x64:(1, ~0, ~1,  0)))
        XCTAssertEqual(T(x64:(w, w, 0, 0)) * T(x64:(w, w, 0, 0)), T(x64:(1,  0, ~1, ~0)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:(1, 0, 0, 0)), true ) as (T, Bool))

        XCTAssert(T(x64:(1, 2, 3, 4)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~0, ~2, ~3, ~4)), true))
        XCTAssert(T(x64:(4, 3, 2, 1)).multipliedReportingOverflow(by: T(x64:(w, w, w, w))) == (T(x64:(~3, ~3, ~2, ~1)), true))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:( 0, 0, 0, 0)))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:( 0, 0, 0, 0)))
        
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:( 1, 0, 0, 0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(~1, w, w, w)))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  T(x64:(~0, ~2, ~3, ~4)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:( 0,  2,  3,  4)))

        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).low,  T(x64:(~3, ~3, ~2, ~1)))
        XCTAssertEqual(T(x64:(4, 3, 2, 1)).multipliedFullWidth(by: T(x64:(w, w, w, w))).high, T(x64:( 3,  3,  2,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        XCTAssertEqual(T(2) * UInt(3), 6)
        XCTAssertEqual(T(3) * UInt(2), 6)
    }
    
    func testMultipliedByDigitReportingOverflow() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt.min) == (T(x64:(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt.max) == (T(x64:(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: UInt.max) == (T(x64:(1, w, w, w)), true ) as (T, Bool))
        
        XCTAssert(T(x64:(1, 2, 3, 4)).multipliedReportingOverflow(by: UInt(5)) == (T(x64:( 5, 10, 15, 20)), false) as (T, Bool))
        XCTAssert(T(x64:(w, w, w, w)).multipliedReportingOverflow(by: UInt(5)) == (T(x64:(~4,  w,  w,  w)),  true) as (T, Bool))
    }
    
    func testMultipliedByDigitFullWidth() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.min).low,   M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.min).high,  UInt(0))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.max).low,   M(x64:( 0, 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.max).high,  UInt(0))

        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt.max).low,   M(x64:( 1, w, w, w)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt.max).high, ~UInt(1))
        
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: UInt(5)).low,  M(x64:(5, 10, 15, 20)))
        XCTAssertEqual(T(x64:(1, 2, 3, 4)).multipliedFullWidth(by: UInt(5)).high, 0 as UInt)
        
        XCTAssertEqual(T(x64:(w, w, w, w)).multipliedFullWidth(by: UInt(5)).low,  M(x64:(~4, w,  w,  w)))
        XCTAssertEqual(T(x64:(w, w, w, w)).multipliedFullWidth(by: UInt(5)).high, 4 as UInt)
    }
}

#endif
