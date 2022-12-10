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
// MARK: * Int256 x Tests x Division
//*============================================================================*

final class Int256TestsOnDivision: XCTestCase {
    
    typealias T =  Int256
    typealias M = UInt256
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T( 0) / T( 1),  0)
        XCTAssertEqual(T( 0) / T( 2),  0)
        XCTAssertEqual(T( 0) % T( 1),  0)
        XCTAssertEqual(T( 0) % T( 2),  0)

        XCTAssertEqual(T( 7) / T( 1),  7)
        XCTAssertEqual(T( 7) / T( 2),  3)
        XCTAssertEqual(T( 7) % T( 1),  0)
        XCTAssertEqual(T( 7) % T( 2),  1)
                
        XCTAssertEqual(T( 7) / T( 3),  2)
        XCTAssertEqual(T( 7) / T(-3), -2)
        XCTAssertEqual(T(-7) / T( 3), -2)
        XCTAssertEqual(T(-7) / T(-3),  2)
        
        XCTAssertEqual(T( 7) % T( 3),  1)
        XCTAssertEqual(T( 7) % T(-3),  1)
        XCTAssertEqual(T(-7) % T( 3), -1)
        XCTAssertEqual(T(-7) % T(-3), -1)
        
        XCTAssertEqual(T(x64:(~2, ~0, ~0, 2)) / T(3), T(x64:(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64:(~5, ~6, ~9, 2)) / T(3), T(x64:(~1, ~2, ~3, 0)))
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(T.min.dividedReportingOverflow(by:  0) == (T.min, true))
        XCTAssert(T.min.dividedReportingOverflow(by: -1) == (T.min, true))

        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T(-2)) == (-T(x64:(0, 2 + w/2, 1, 2)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T(-1)) == (-T(x64:(1, 2,       3, 4)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T( 1)) == ( T(x64:(1, 2,       3, 4)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T( 2)) == ( T(x64:(0, 2 + w/2, 1, 2)), false))
    }

    func testRemainderReportingOverflow() {
        XCTAssert(T.min.remainderReportingOverflow(dividingBy:  0) == (T.min, true))
        XCTAssert(T.min.remainderReportingOverflow(dividingBy: -1) == (T( 0), true))
        
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(-2)) == (T(x64:(1, 0, 0, 0)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(-1)) == (T(x64:(0, 0, 0, 0)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T( 1)) == (T(x64:(0, 0, 0, 0)), false))
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T( 2)) == (T(x64:(1, 0, 0, 0)), false))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var dividend: (high: T, low: M)
        
        dividend.low  = M(x64:( 6, 17, 35, 61))
        dividend.high = T(x64:(61, 52, 32,  0))
        
        XCTAssert(T(x64:(1, 2, 3, 4)).dividingFullWidth(dividend) == (T(x64:( 5,  6,  7,  8)), T(x64:( 1,  1,  1,  1))))
        XCTAssert(T(x64:(5, 6, 7, 8)).dividingFullWidth(dividend) == (T(x64:( 1,  2,  3,  4)), T(x64:( 1,  1,  1,  1))))
        
        dividend.low  = M(x64:(34, 54, 63, 62))
        dividend.high = T(x64:(34, 16,  5,  0))
        
        XCTAssert(T(x64:(4, 3, 2, 1)).dividingFullWidth(dividend) == (T(x64:( 9,  7,  6,  5)), T(x64:(~1, ~1, ~0,  0))))
        XCTAssert(T(x64:(8, 7, 6, 5)).dividingFullWidth(dividend) == (T(x64:( 4,  3,  2,  1)), T(x64:( 2,  2,  2,  2))))
        
        dividend.low  = M(x64:(~1,  w,  w,  w))
        dividend.high = T(x64:( w,  w,  w,  w))
        
        XCTAssert(T(x64:(1, 0, 0, 0)).dividingFullWidth(dividend) == (T(x64:(~1,  w,  w,  w)), T(x64:( 0,  0,  0,  0))))
        XCTAssert(T(x64:(w, w, w, w)).dividingFullWidth(dividend) == (T(x64:( 2,  0,  0,  0)), T(x64:( 0,  0,  0,  0))))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        var dividend: (high: T, low: M)
        
        dividend.low  = M(x64:(0, 0, 0, 0))
        dividend.high = T(x64:(w, w, w, w))
        
        XCTAssert(T(1).dividingFullWidth(dividend) == ( T(0),   T(0)) as (T, T))
        XCTAssert(T(2).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 1), T(0)) as (T, T))
        XCTAssert(T(4).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 2), T(0)) as (T, T))
        XCTAssert(T(8).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 3), T(0)) as (T, T))
    }
}

//*============================================================================*
// MARK: * UInt256 x Tests x Division
//*============================================================================*

final class UInt256TestsOnDivision: XCTestCase {
    
    typealias T = UInt256
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let w = UInt64.max
    let s = UInt64.bitWidth
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual(T(0) / T(1), T(0))
        XCTAssertEqual(T(0) / T(2), T(0))
        XCTAssertEqual(T(0) % T(1), T(0))
        XCTAssertEqual(T(0) % T(2), T(0))

        XCTAssertEqual(T(7) / T(1), T(7))
        XCTAssertEqual(T(7) / T(2), T(3))
        XCTAssertEqual(T(7) % T(1), T(0))
        XCTAssertEqual(T(7) % T(2), T(1))
                
        XCTAssertEqual(T(x64:(~2, ~0, ~0, 2)) / T(3), T(x64:(~0, ~0, ~0, 0)))
        XCTAssertEqual(T(x64:(~5, ~6, ~9, 2)) / T(3), T(x64:(~1, ~2, ~3, 0)))
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T(0)) == (T(x64:(1, 2,       3, 4)), true ) as (T, Bool))
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T(1)) == (T(x64:(1, 2,       3, 4)), false) as (T, Bool))
        XCTAssert(T(x64:(1, 2, 3, 4)).dividedReportingOverflow(by: T(2)) == (T(x64:(0, 2 + w/2, 1, 2)), false) as (T, Bool))
    }
    
    func testRemainderReportingOverflow() {
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(0)) == (T(x64:(1, 2, 3, 4)), true ) as (T, Bool))
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(1)) == (T(x64:(0, 0, 0, 0)), false) as (T, Bool))
        XCTAssert(T(x64:(1, 2, 3, 4)).remainderReportingOverflow(dividingBy: T(2)) == (T(x64:(1, 0, 0, 0)), false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var dividend: (high: T, low: T)
        
        dividend.low  = T(x64:( 6, 17, 35, 61))
        dividend.high = T(x64:(61, 52, 32,  0))
        
        XCTAssert(T(x64:(1, 2, 3, 4)).dividingFullWidth(dividend) == (T(x64:(5, 6, 7, 8)), T(x64:(1, 1, 1, 1))))
        XCTAssert(T(x64:(5, 6, 7, 8)).dividingFullWidth(dividend) == (T(x64:(1, 2, 3, 4)), T(x64:(1, 1, 1, 1))))
        
        dividend.low  = T(x64:(34, 54, 63, 62))
        dividend.high = T(x64:(34, 16,  5,  0))
        
        XCTAssert(T(x64:(4, 3, 2, 1)).dividingFullWidth(dividend) == (T(x64:(9, 7, 6, 5)), T(x64:(~1, ~1, ~0, 0))))
        XCTAssert(T(x64:(8, 7, 6, 5)).dividingFullWidth(dividend) == (T(x64:(4, 3, 2, 1)), T(x64:( 2,  2,  2, 2))))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        var dividend: (high: T, low: T)
        
        dividend.low  = T(x64:(0, 0, 0, 0))
        dividend.high = T(x64:(w, w, w, w))
        
        XCTAssert(T(1).dividingFullWidth(dividend) == ( T(0),   T(0)) as (T, T))
        XCTAssert(T(2).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 1), T(0)) as (T, T))
        XCTAssert(T(4).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 2), T(0)) as (T, T))
        XCTAssert(T(8).dividingFullWidth(dividend) == (~T(0) << (T.bitWidth - 3), T(0)) as (T, T))
    }
}

#endif
