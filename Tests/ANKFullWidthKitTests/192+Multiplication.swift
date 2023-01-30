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
        XCTAssertEqual(T( 2) * T( 3), T( 6))
        XCTAssertEqual(T( 2) * T(-3), T(-6))
        XCTAssertEqual(T(-2) * T( 3), T(-6))
        XCTAssertEqual(T(-2) * T(-3), T( 6))
        
        XCTAssertEqual(T(x64:(1, 2, 0)) * T(x64:(3, 4, 0)),  T(x64:(3, 10, 8)))
        XCTAssertEqual(T(x64:(3, 4, 0)) * T(x64:(1, 2, 0)),  T(x64:(3, 10, 8)))
        
        XCTAssertEqual(T(b),               T(x64:(~0,  0,  0)))
        XCTAssertEqual(T(b) * T(b),        T(x64:( 1, ~1,  0)))
        XCTAssertEqual(T(b) * T(b) * T(b), T(x64:(~0,  2, ~2)))

        XCTAssertEqual(T(x64:(b, 0, 0)) * T(x64:(b, 0, 0)), T(x64:(1, ~1,  0)))
        XCTAssertEqual(T(x64:(b, 0, 0)) * T(x64:(b, b, 0)), T(x64:(1, ~0, ~1)))
        XCTAssertEqual(T(x64:(b, b, 0)) * T(x64:(b, 0, 0)), T(x64:(1, ~0, ~1)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:( 0,  0,  0)),            true) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:( 0,  0,  1 << (64 - 1))), true) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:( 1,  0,  0)),            true) as (T, Bool))

        XCTAssert(T(x64:(1, 2, 3)).multipliedReportingOverflow(by: T(x64:(b, b, b))) == (T(x64:(~0, ~2, ~3)), false))
        XCTAssert(T(x64:(3, 2, 1)).multipliedReportingOverflow(by: T(x64:(b, b, b))) == (T(x64:(~2, ~2, ~1)), false))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:( 0,  0,  0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:( 0,  0,  1 << (64 - 2))))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:( 0,  0,  1 << (64 - 1))))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:( 0,  0,  b << (64 - 2))))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:( 1,  0,  0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(~0, ~0,  b >> (0 + 2))))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: T(x64:(b, b, b))).low,  M(x64:(~0, ~2, ~3)))
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: T(x64:(b, b, b))).high, T(x64:(~0, ~0, ~0)))

        XCTAssertEqual(T(x64:(3, 2, 1)).multipliedFullWidth(by: T(x64:(b, b, b))).low,  M(x64:(~2, ~2, ~1)))
        XCTAssertEqual(T(x64:(3, 2, 1)).multipliedFullWidth(by: T(x64:(b, b, b))).high, T(x64:(~0, ~0, ~0)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testMultipliedByInt() {
        XCTAssertEqual(T( 2) * Int( 3), T( 6))
        XCTAssertEqual(T( 2) * Int(-3), T(-6))
        XCTAssertEqual(T(-2) * Int( 3), T(-6))
        XCTAssertEqual(T(-2) * Int(-3), T( 6))
    }

    func testMultipliedByUIntReportingOverflow() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssert(T.min.multipliedReportingOverflow(by: Int.min) == (T(x64:(      0,  0,          (0))), true))
        XCTAssert(T.min.multipliedReportingOverflow(by: Int.max) == (T(x64:(      0,  0, 1 << (64 - 1))), true))
        XCTAssert(T.max.multipliedReportingOverflow(by: Int.max) == (T(x64:(2 + b/2,  b,      (b / 2))), true))
    }
    
    func testMultipliedFullWidthByUInt() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.min).low,   M(x64:(0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.min).high,  Int( 1 << (64 - 2)))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.max).low,   M(x64:(0, 0, 1 << (64 - 1))))
        XCTAssertEqual(T.min.multipliedFullWidth(by: Int.max).high,  Int(~0 << (64 - 2)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: Int.max).low,   M(x64:(2 + b/2, b, b/2)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: Int.max).high,  Int( b >> (0 + 2)))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: Int(5)).low,   M(x64:(5, 10, 15)))
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: Int(5)).high,  0 as Int)

        XCTAssertEqual(T(x64:(b, b, b)).multipliedFullWidth(by: Int(5)).low,   M(x64:(~4, b,  b)))
        XCTAssertEqual(T(x64:(b, b, b)).multipliedFullWidth(by: Int(5)).high, -1 as Int)
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
        XCTAssertEqual(T(2) * T(3), T(6))
        XCTAssertEqual(T(3) * T(2), T(6))
                
        XCTAssertEqual(T(x64:(1, 2, 0)) * T(x64:(3, 4, 0)),  T(x64:(3, 10, 8)))
        XCTAssertEqual(T(x64:(3, 4, 0)) * T(x64:(1, 2, 0)),  T(x64:(3, 10, 8)))
        
        XCTAssertEqual(T(b),               T(x64:(~0,  0,  0)))
        XCTAssertEqual(T(b) * T(b),        T(x64:( 1, ~1,  0)))
        XCTAssertEqual(T(b) * T(b) * T(b), T(x64:(~0,  2, ~2)))
        
        XCTAssertEqual(T(x64:(b, 0, 0)) * T(x64:(b, 0, 0)), T(x64:(1, ~1,  0)))
        XCTAssertEqual(T(x64:(b, 0, 0)) * T(x64:(b, b, 0)), T(x64:(1, ~0, ~1)))
        XCTAssertEqual(T(x64:(b, b, 0)) * T(x64:(b, 0, 0)), T(x64:(1, ~0, ~1)))
    }
    
    func testMultipliedReportingOverflow() {
        XCTAssert(T.min.multipliedReportingOverflow(by: T.min) == (T(x64:(0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: T.max) == (T(x64:(0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: T.max) == (T(x64:(1, 0, 0)), true ) as (T, Bool))

        XCTAssert(T(x64:(1, 2, 3)).multipliedReportingOverflow(by: T(x64:(b, b, b))) == (T(x64:(~0, ~2, ~3)), true))
        XCTAssert(T(x64:(3, 2, 1)).multipliedReportingOverflow(by: T(x64:(b, b, b))) == (T(x64:(~2, ~2, ~1)), true))
    }
    
    func testMultipliedFullWidth() {
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).low,   M(x64:( 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.min).high,  T(x64:( 0, 0, 0)))

        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).low,   M(x64:( 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: T.max).high,  T(x64:( 0, 0, 0)))

        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).low,   M(x64:( 1, 0, 0)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: T.max).high,  T(x64:(~1, b, b)))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: T(x64:(b, b, b))).low,  T(x64:(~0, ~2, ~3)))
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: T(x64:(b, b, b))).high, T(x64:( 0,  2,  3)))
        
        XCTAssertEqual(T(x64:(3, 2, 1)).multipliedFullWidth(by: T(x64:(b, b, b))).low,  T(x64:(~2, ~2, ~1)))
        XCTAssertEqual(T(x64:(3, 2, 1)).multipliedFullWidth(by: T(x64:(b, b, b))).high, T(x64:( 2,  2,  1)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x UInt
    //=------------------------------------------------------------------------=
    
    func testMultipliedByUInt() {
        XCTAssertEqual(T(2) * UInt(3), 6)
        XCTAssertEqual(T(3) * UInt(2), 6)
    }
    
    func testMultipliedByUIntReportingOverflow() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt.min) == (T(x64:(0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.min.multipliedReportingOverflow(by: UInt.max) == (T(x64:(0, 0, 0)), false) as (T, Bool))
        XCTAssert(T.max.multipliedReportingOverflow(by: UInt.max) == (T(x64:(1, b, b)), true ) as (T, Bool))
        
        XCTAssert(T(x64:(1, 2, 3)).multipliedReportingOverflow(by: UInt(5)) == (T(x64:( 5, 10, 15)), false) as (T, Bool))
        XCTAssert(T(x64:(b, b, b)).multipliedReportingOverflow(by: UInt(5)) == (T(x64:(~4,  b,  b)),  true) as (T, Bool))
    }
    
    func testMultipliedByUIntFullWidth() throws {
        guard MemoryLayout<UInt>.size == 8 else { throw XCTSkip() }
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.min).low,   M(x64:( 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.min).high,  UInt(0))
        
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.max).low,   M(x64:( 0, 0, 0)))
        XCTAssertEqual(T.min.multipliedFullWidth(by: UInt.max).high,  UInt(0))

        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt.max).low,   M(x64:( 1, b, b)))
        XCTAssertEqual(T.max.multipliedFullWidth(by: UInt.max).high, ~UInt(1))
        
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: UInt(5)).low,  M(x64:(5, 10, 15)))
        XCTAssertEqual(T(x64:(1, 2, 3)).multipliedFullWidth(by: UInt(5)).high, 0 as UInt)
        
        XCTAssertEqual(T(x64:(b, b, b)).multipliedFullWidth(by: UInt(5)).low,  M(x64:(~4, b,  b)))
        XCTAssertEqual(T(x64:(b, b, b)).multipliedFullWidth(by: UInt(5)).high, 4 as UInt)
    }
}

#endif
