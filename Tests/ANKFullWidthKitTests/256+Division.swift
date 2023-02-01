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
// MARK: * Int256 x Division
//*============================================================================*

final class Int256TestsOnDivision: XCTestCase {
    
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T( 0) / T( 1),  0 as T)
        XCTAssertEqual(T( 0) / T( 2),  0 as T)
        XCTAssertEqual(T( 0) % T( 1),  0 as T)
        XCTAssertEqual(T( 0) % T( 2),  0 as T)

        XCTAssertEqual(T( 7) / T( 1),  7 as T)
        XCTAssertEqual(T( 7) / T( 2),  3 as T)
        XCTAssertEqual(T( 7) % T( 1),  0 as T)
        XCTAssertEqual(T( 7) % T( 2),  1 as T)
                
        XCTAssertEqual(T( 7) / T( 3),  2 as T)
        XCTAssertEqual(T( 7) / T(-3), -2 as T)
        XCTAssertEqual(T(-7) / T( 3), -2 as T)
        XCTAssertEqual(T(-7) / T(-3),  2 as T)
        
        XCTAssertEqual(T( 7) % T( 3),  1 as T)
        XCTAssertEqual(T( 7) % T(-3),  1 as T)
        XCTAssertEqual(T(-7) % T( 3), -1 as T)
        XCTAssertEqual(T(-7) % T(-3), -1 as T)
        
        XCTAssertEqual(T(x64: X(~2, ~0, ~0, 2)) / T(3), T(x64: X(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~5, ~6, ~9, 2)) / T(3), T(x64: X(~1, ~2, ~3, 0)))
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(T.min.dividedReportingOverflow(by:  T(0)) == (T.min, true) as (T, Bool))
        XCTAssert(T.min.dividedReportingOverflow(by: -T(1)) == (T.min, true) as (T, Bool))

        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T(-2)) == (-T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T(-1)) == (-T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T( 1)) == ( T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T( 2)) == ( T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
    }

    func testRemainderReportingOverflow() {
        XCTAssert(T.min.remainderReportingOverflow(dividingBy:  T(0)) == (T.min, true) as (T, Bool))
        XCTAssert(T.min.remainderReportingOverflow(dividingBy: -T(1)) == (T( 0), true) as (T, Bool))
        
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(-2)) == (T(x64: X(1, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(-1)) == (T(x64: X(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T( 1)) == (T(x64: X(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T( 2)) == (T(x64: X(1, 0, 0, 0)), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Int
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        XCTAssertEqual(T( 0) / Int( 1),  0 as T)
        XCTAssertEqual(T( 0) / Int( 2),  0 as T)
        XCTAssertEqual(T( 0) % Int( 1),  0 as Int)
        XCTAssertEqual(T( 0) % Int( 2),  0 as Int)

        XCTAssertEqual(T( 7) / Int( 1),  7 as T)
        XCTAssertEqual(T( 7) / Int( 2),  3 as T)
        XCTAssertEqual(T( 7) % Int( 1),  0 as Int)
        XCTAssertEqual(T( 7) % Int( 2),  1 as Int)
                
        XCTAssertEqual(T( 7) / Int( 3),  2 as T)
        XCTAssertEqual(T( 7) / Int(-3), -2 as T)
        XCTAssertEqual(T(-7) / Int( 3), -2 as T)
        XCTAssertEqual(T(-7) / Int(-3),  2 as T)
        
        XCTAssertEqual(T( 7) % Int( 3),  1 as Int)
        XCTAssertEqual(T( 7) % Int(-3),  1 as Int)
        XCTAssertEqual(T(-7) % Int( 3), -1 as Int)
        XCTAssertEqual(T(-7) % Int(-3), -1 as Int)
        
        XCTAssertEqual(T(x64: X(~2, ~0, ~0, 2)) / Int(3), T(x64: X(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~5, ~6, ~9, 2)) / Int(3), T(x64: X(~1, ~2, ~3, 0)))
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        XCTAssert(T.min.dividedReportingOverflow(by:  Int(0)) == (T.min, true) as (T, Bool))
        XCTAssert(T.min.dividedReportingOverflow(by: -Int(1)) == (T.min, true) as (T, Bool))

        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: Int(-2)) == (-T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: Int(-1)) == (-T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: Int( 1)) == ( T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: Int( 2)) == ( T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
    }

    func testRemainderDividingByDigitReportingOverflow() {
        XCTAssert(T.min.remainderReportingOverflow(dividingBy:  Int(0)) == (Int(0), true) as (Int, Bool))
        XCTAssert(T.min.remainderReportingOverflow(dividingBy: -Int(1)) == (Int(0), true) as (Int, Bool))
        
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: Int(-2)) == (Int(1), false) as (Int, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: Int(-1)) == (Int(0), false) as (Int, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: Int( 1)) == (Int(0), false) as (Int, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: Int( 2)) == (Int(1), false) as (Int, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var x: (high: T, low: M)
        //=--------------------------------------=
        x.low  = M(x64: X( 6, 17, 35, 61))
        x.high = T(x64: X(61, 52, 32,  0))
        
        XCTAssertEqual(T(x64: X( 1,  2,  3,  4)).dividingFullWidth(x).quotient,  T(x64: X( 5,  6,  7,  8)))
        XCTAssertEqual(T(x64: X( 1,  2,  3,  4)).dividingFullWidth(x).remainder, T(x64: X( 1,  1,  1,  1)))
        
        XCTAssertEqual(T(x64: X( 5,  6,  7,  8)).dividingFullWidth(x).quotient,  T(x64: X( 1,  2,  3,  4)))
        XCTAssertEqual(T(x64: X( 5,  6,  7,  8)).dividingFullWidth(x).remainder, T(x64: X( 1,  1,  1,  1)))
        //=--------------------------------------=
        x.low  = M(x64: X(34, 54, 63, 62))
        x.high = T(x64: X(34, 16,  5,  0))
        
        XCTAssertEqual(T(x64: X( 4,  3,  2,  1)).dividingFullWidth(x).quotient,  T(x64: X( 9,  7,  6,  5)))
        XCTAssertEqual(T(x64: X( 4,  3,  2,  1)).dividingFullWidth(x).remainder, T(x64: X(~1, ~1, ~0,  0)))
        
        XCTAssertEqual(T(x64: X( 8,  7,  6,  5)).dividingFullWidth(x).quotient,  T(x64: X( 4,  3,  2,  1)))
        XCTAssertEqual(T(x64: X( 8,  7,  6,  5)).dividingFullWidth(x).remainder, T(x64: X( 2,  2,  2,  2)))
        //=--------------------------------------=
        x.low  = M(x64: X(~1, ~0, ~0, ~0))
        x.high = T(x64: X(~0, ~0, ~0, ~0))
        
        XCTAssertEqual(T(x64: X( 1,  0,  0,  0)).dividingFullWidth(x).quotient,  T(x64: X(~1, ~0, ~0, ~0)))
        XCTAssertEqual(T(x64: X( 1,  0,  0,  0)).dividingFullWidth(x).remainder, T(x64: X( 0,  0,  0,  0)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)).dividingFullWidth(x).quotient,  T(x64: X( 2,  0,  0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0, ~0)).dividingFullWidth(x).remainder, T(x64: X( 0,  0,  0,  0)))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        var x: (high: T, low: M)
        //=--------------------------------------=
        x.low  = M(x64: X( 0,  0,  0,  0))
        x.high = T(x64: X(~0, ~0, ~0, ~0))
        
        XCTAssert(T(1).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 0), T(0)) as (T, T))
        XCTAssert(T(2).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 1), T(0)) as (T, T))
        XCTAssert(T(4).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 2), T(0)) as (T, T))
        XCTAssert(T(8).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 3), T(0)) as (T, T))
    }
}

//*============================================================================*
// MARK: * UInt256 x Division
//*============================================================================*

final class UInt256TestsOnDivision: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T(0) / T(1), 0 as T)
        XCTAssertEqual(T(0) / T(2), 0 as T)
        XCTAssertEqual(T(0) % T(1), 0 as T)
        XCTAssertEqual(T(0) % T(2), 0 as T)

        XCTAssertEqual(T(7) / T(1), 7 as T)
        XCTAssertEqual(T(7) / T(2), 3 as T)
        XCTAssertEqual(T(7) % T(1), 0 as T)
        XCTAssertEqual(T(7) % T(2), 1 as T)
                
        XCTAssertEqual(T(x64: X(~2, ~0, ~0, 2)) / T(3), T(x64: X(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~5, ~6, ~9, 2)) / T(3), T(x64: X(~1, ~2, ~3, 0)))
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T(0)) == (T(x64: X(1,        2, 3, 4)), true ) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T(1)) == (T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: T(2)) == (T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
    }
    
    func testRemainderReportingOverflow() {
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(0)) == (T(x64: X(1, 2, 3, 4)), true ) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(1)) == (T(x64: X(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(2)) == (T(x64: X(1, 0, 0, 0)), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        XCTAssertEqual(T(0) / UInt(1), 0 as T)
        XCTAssertEqual(T(0) / UInt(2), 0 as T)
        XCTAssertEqual(T(0) % UInt(1), 0 as UInt)
        XCTAssertEqual(T(0) % UInt(2), 0 as UInt)

        XCTAssertEqual(T(7) / UInt(1), 7 as T)
        XCTAssertEqual(T(7) / UInt(2), 3 as T)
        XCTAssertEqual(T(7) % UInt(1), 0 as UInt)
        XCTAssertEqual(T(7) % UInt(2), 1 as UInt)
                
        XCTAssertEqual(T(x64: X(~2, ~0, ~0, 2)) / UInt(3), T(x64: X(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64: X(~5, ~6, ~9, 2)) / UInt(3), T(x64: X(~1, ~2, ~3, 0)))
    }
    
    func testQuotientDividingByDigitReportingOverflow() {
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: UInt(0)) == (T(x64: X(1,        2, 3, 4)), true ) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: UInt(1)) == (T(x64: X(1,        2, 3, 4)), false) as (T, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).dividedReportingOverflow(by: UInt(2)) == (T(x64: X(0, ~0/2 + 2, 1, 2)), false) as (T, Bool))
    }
    
    func testRemainderDividingByDigitReportingOverflow() {
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: UInt(0)) == (UInt(0), true ) as (UInt, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: UInt(1)) == (UInt(0), false) as (UInt, Bool))
        XCTAssert(T(x64: X(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: UInt(2)) == (UInt(1), false) as (UInt, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var x: (high: T, low: T)
        //=--------------------------------------=
        x.low  = T(x64: X( 6, 17, 35, 61))
        x.high = T(x64: X(61, 52, 32,  0))
        
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)).dividingFullWidth(x).quotient,  T(x64: X( 5,  6,  7,  8)))
        XCTAssertEqual(T(x64: X(1, 2, 3, 4)).dividingFullWidth(x).remainder, T(x64: X( 1,  1,  1,  1)))
        
        XCTAssertEqual(T(x64: X(5, 6, 7, 8)).dividingFullWidth(x).quotient,  T(x64: X( 1,  2,  3,  4)))
        XCTAssertEqual(T(x64: X(5, 6, 7, 8)).dividingFullWidth(x).remainder, T(x64: X( 1,  1,  1,  1)))
        //=--------------------------------------=
        x.low  = T(x64: X(34, 54, 63, 62))
        x.high = T(x64: X(34, 16,  5,  0))
        
        XCTAssertEqual(T(x64: X(4, 3, 2, 1)).dividingFullWidth(x).quotient,  T(x64: X( 9,  7,  6,  5)))
        XCTAssertEqual(T(x64: X(4, 3, 2, 1)).dividingFullWidth(x).remainder, T(x64: X(~1, ~1, ~0,  0)))
        
        XCTAssertEqual(T(x64: X(8, 7, 6, 5)).dividingFullWidth(x).quotient,  T(x64: X( 4,  3,  2,  1)))
        XCTAssertEqual(T(x64: X(8, 7, 6, 5)).dividingFullWidth(x).remainder, T(x64: X( 2,  2,  2,  2)))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        var x: (high: T, low: T)
        //=--------------------------------------=
        x.low  = T(x64: X( 0,  0,  0,  0))
        x.high = T(x64: X(~0, ~0, ~0, ~0))
        
        XCTAssert(T(1).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 0), T(0)) as (T, T))
        XCTAssert(T(2).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 1), T(0)) as (T, T))
        XCTAssert(T(4).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 2), T(0)) as (T, T))
        XCTAssert(T(8).dividingFullWidth(x) == (~T(0) << (T.bitWidth - 3), T(0)) as (T, T))
    }
}

#endif
