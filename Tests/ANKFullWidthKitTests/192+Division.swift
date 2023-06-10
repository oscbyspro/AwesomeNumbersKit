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
// MARK: * Int192 x Division
//*============================================================================*

final class Int192TestsOnDivision: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        ANKAssertDivision( T(0),  T(1),  T(0),  T(0))
        ANKAssertDivision( T(0),  T(2),  T(0),  T(0))
        ANKAssertDivision( T(7),  T(1),  T(7),  T(0))
        ANKAssertDivision( T(7),  T(2),  T(3),  T(1))
                
        ANKAssertDivision( T(7),  T(3),  T(2),  T(1))
        ANKAssertDivision( T(7), -T(3), -T(2),  T(1))
        ANKAssertDivision(-T(7),  T(3), -T(2), -T(1))
        ANKAssertDivision(-T(7), -T(3),  T(2), -T(1))
    }
    
    func testDividingUsingLargeValues() {
        ANKAssertDivision( T(x64: X(1, 2, 3)),  T(2),  T(x64: X(0, ~0/2 + 2, 1)),  T(1))
        ANKAssertDivision( T(x64: X(1, 2, 3)), -T(2), -T(x64: X(0, ~0/2 + 2, 1)),  T(1))
        ANKAssertDivision(-T(x64: X(1, 2, 3)),  T(2), -T(x64: X(0, ~0/2 + 2, 1)), -T(1))
        ANKAssertDivision(-T(x64: X(1, 2, 3)), -T(2),  T(x64: X(0, ~0/2 + 2, 1)), -T(1))
    }
    
    func testDividingReportingOverflow() {
        ANKAssertDivision(T( 0),  T(0), T( 0), T(0), true)
        ANKAssertDivision(T( 1),  T(0), T( 1), T(1), true)
        ANKAssertDivision(T( 2),  T(0), T( 2), T(2), true)
        ANKAssertDivision(T.min, -T(1), T.min, T(0), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        ANKAssertDivisionByDigit( T(0),  Int(1),  T(0),  Int(0))
        ANKAssertDivisionByDigit( T(0),  Int(2),  T(0),  Int(0))
        ANKAssertDivisionByDigit( T(7),  Int(1),  T(7),  Int(0))
        ANKAssertDivisionByDigit( T(7),  Int(2),  T(3),  Int(1))
                
        ANKAssertDivisionByDigit( T(7),  Int(3),  T(2),  Int(1))
        ANKAssertDivisionByDigit( T(7), -Int(3), -T(2),  Int(1))
        ANKAssertDivisionByDigit(-T(7),  Int(3), -T(2), -Int(1))
        ANKAssertDivisionByDigit(-T(7), -Int(3),  T(2), -Int(1))
    }
    
    func testDividingByDigitUsingLargeValues() {
        ANKAssertDivisionByDigit( T(x64: X(1, 2, 3)),  Int(2),  T(x64: X(0, ~0/2 + 2, 1)),  Int(1))
        ANKAssertDivisionByDigit( T(x64: X(1, 2, 3)), -Int(2), -T(x64: X(0, ~0/2 + 2, 1)),  Int(1))
        ANKAssertDivisionByDigit(-T(x64: X(1, 2, 3)),  Int(2), -T(x64: X(0, ~0/2 + 2, 1)), -Int(1))
        ANKAssertDivisionByDigit(-T(x64: X(1, 2, 3)), -Int(2),  T(x64: X(0, ~0/2 + 2, 1)), -Int(1))
    }
    
    func testDividingByDigitReportingOverflow() {
        ANKAssertDivisionByDigit(T( 0),  Int(0), T( 0), Int(0), true)
        ANKAssertDivisionByDigit(T( 1),  Int(0), T( 1), Int(0), true)
        ANKAssertDivisionByDigit(T( 2),  Int(0), T( 2), Int(0), true)
        ANKAssertDivisionByDigit(T.min, -Int(1), T.min, Int(0), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var x: (high: T, low: M)
        //=--------------------------------------=
        x.low  = M(x64: X(5,  14, 29))
        x.high = T(x64: X(27, 18,  0))
        
        ANKAssertDivisionFullWidth(x, T(x64: X( 1,  2,  3)), T(x64: X( 4,  5,  6)), T(x64: X( 1,  1,  1)))
        ANKAssertDivisionFullWidth(x, T(x64: X( 4,  5,  6)), T(x64: X( 1,  2,  3)), T(x64: X( 1,  1,  1)))
        //=--------------------------------------=
        x.low  = M(x64: X(20, 29, 30))
        x.high = T(x64: X(13,  4,  0))

        ANKAssertDivisionFullWidth(x, T(x64: X( 3,  2,  1)), T(x64: X( 7,  5,  4)), T(x64: X(~0, ~0,  0)))
        ANKAssertDivisionFullWidth(x, T(x64: X( 6,  5,  4)), T(x64: X( 3,  2,  1)), T(x64: X( 2,  2,  2)))
        //=--------------------------------------=
        x.low  = M(x64: X(~1, ~0, ~0))
        x.high = T(x64: X(~0, ~0, ~0))

        ANKAssertDivisionFullWidth(x, T(x64: X( 1,  0,  0)), T(x64: X(~1, ~0, ~0)), T(x64: X( 0,  0,  0)))
        ANKAssertDivisionFullWidth(x, T(x64: X(~0, ~0, ~0)), T(x64: X( 2,  0,  0)), T(x64: X( 0,  0,  0)))
    }
    
    func testDividingFullWidthReportingOverflow() {
        var dividend: (high: T, low: M)
        //=--------------------------------------=
        dividend.high = T(  )
        dividend.low  = M( 7)

        ANKAssertDivisionFullWidth(dividend, T( 0),  T( 7), T( 7), true)
        //=--------------------------------------=
        dividend.high = T(-1)
        dividend.low  = M( 7)
        
        ANKAssertDivisionFullWidth(dividend, T( 0),  T( 7), T( 7), true)
        //=--------------------------------------=
        dividend.high = T(-1)
        dividend.low  = M.max
        
        ANKAssertDivisionFullWidth(dividend, T( 2),  T(  ), T(-1))
        //=--------------------------------------=
        dividend.high = T(  )
        dividend.low  = M( 1)
        
        ANKAssertDivisionFullWidth(dividend, T(-2),  T(  ), T( 1))
        //=--------------------------------------=
        dividend.high = T(  )
        dividend.low  = M(bitPattern: T.max)

        ANKAssertDivisionFullWidth(dividend, T(-1), -T.max, T(  ))
        //=--------------------------------------=
        dividend.high = T(-1)
        dividend.low  = M(bitPattern: T.min)
        
        ANKAssertDivisionFullWidth(dividend, T(-1),  T.min, T(  ), true)
        //=--------------------------------------=
        dividend.high = T.max >> 1
        dividend.low  = M.max >> 1
        
        ANKAssertDivisionFullWidth(dividend, T.max,  T.max, T.max - 1)
        //=--------------------------------------=
        dividend.high = T.max >> 1
        dividend.low  = M.max >> 1 + 1
        
        ANKAssertDivisionFullWidth(dividend, T.max,  T.min, T(  ), true)
        //=--------------------------------------=
        dividend.high = T.max >> 1 + 1
        dividend.low  = M.max >> 1
        
        ANKAssertDivisionFullWidth(dividend, T.min,  T.min, T.max)
        //=--------------------------------------=
        dividend.high = T.max >> 1 + 1
        dividend.low  = M.max >> 1 + 1
        
        ANKAssertDivisionFullWidth(dividend, T.min,  T.max, T(  ), true)
    }
    
    func testDividingFullWidthReportingOverflowTruncatesQuotient() {
        let dividend: (high: T, low: M)
        //=--------------------------------------=
        dividend.high = T(repeating: true )
        dividend.low  = M(repeating: false)
        
        ANKAssertDivisionFullWidth(dividend, T( ), ~T( ) << (T.bitWidth - 0), T( ), true)
        ANKAssertDivisionFullWidth(dividend, T(1), ~T( ) << (T.bitWidth - 0), T( ), true)
        ANKAssertDivisionFullWidth(dividend, T(2), ~T( ) << (T.bitWidth - 1), T( ))
        ANKAssertDivisionFullWidth(dividend, T(4), ~T( ) << (T.bitWidth - 2), T( ))
        ANKAssertDivisionFullWidth(dividend, T(8), ~T( ) << (T.bitWidth - 3), T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x /= 0)
            XCTAssertNotNil(x %= 0)
            XCTAssertNotNil(x.divideReportingOverflow(by: 0))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: 0))
            
            XCTAssertNotNil(x /  0)
            XCTAssertNotNil(x %  0)
            XCTAssertNotNil(x.dividedReportingOverflow(by: 0))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.dividingFullWidth((0, 0)))
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Division
//*============================================================================*

final class UInt192TestsOnDivision: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        ANKAssertDivision(T(0), T(1), T(0), T(0))
        ANKAssertDivision(T(0), T(2), T(0), T(0))
        ANKAssertDivision(T(7), T(1), T(7), T(0))
        ANKAssertDivision(T(7), T(2), T(3), T(1))
    }
    
    func testDividingUsingLargeValues() {
        ANKAssertDivision(T(x64: X(~2,  ~4,  7)), T(2), T(x64: X(~1, ~2, 3)), T(1))
        ANKAssertDivision(T(x64: X(~3,  ~6, 11)), T(3), T(x64: X(~1, ~2, 3)), T(2))
        ANKAssertDivision(T(x64: X(~4,  ~8, 15)), T(4), T(x64: X(~1, ~2, 3)), T(3))
        ANKAssertDivision(T(x64: X(~5, ~10, 19)), T(5), T(x64: X(~1, ~2, 3)), T(4))
    }
    
    func testDividingReportingOverflow() {
        ANKAssertDivision(T(0), T(0), T(0), T(0), true)
        ANKAssertDivision(T(1), T(0), T(1), T(1), true)
        ANKAssertDivision(T(2), T(0), T(2), T(2), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        ANKAssertDivisionByDigit(T(0), UInt(1), T(0), UInt(0))
        ANKAssertDivisionByDigit(T(0), UInt(2), T(0), UInt(0))
        ANKAssertDivisionByDigit(T(7), UInt(1), T(7), UInt(0))
        ANKAssertDivisionByDigit(T(7), UInt(2), T(3), UInt(1))
    }
    
    func testDividingByDigitUsingLargeValues() {
        ANKAssertDivisionByDigit(T(x64: X(~2,  ~4,  7)), UInt(2), T(x64: X(~1, ~2, 3)), UInt(1))
        ANKAssertDivisionByDigit(T(x64: X(~3,  ~6, 11)), UInt(3), T(x64: X(~1, ~2, 3)), UInt(2))
        ANKAssertDivisionByDigit(T(x64: X(~4,  ~8, 15)), UInt(4), T(x64: X(~1, ~2, 3)), UInt(3))
        ANKAssertDivisionByDigit(T(x64: X(~5, ~10, 19)), UInt(5), T(x64: X(~1, ~2, 3)), UInt(4))
    }
    
    func testDividingByDigitReportingOverflow() {
        ANKAssertDivisionByDigit(T(0), UInt(0), T(0), UInt(0), true)
        ANKAssertDivisionByDigit(T(1), UInt(0), T(1), UInt(0), true)
        ANKAssertDivisionByDigit(T(2), UInt(0), T(2), UInt(0), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        var x: (high: T, low: T)
        //=--------------------------------------=
        x.low  = T(x64: X(5,  14, 29))
        x.high = T(x64: X(27, 18,  0))
        
        ANKAssertDivisionFullWidth(x, T(x64: X(1, 2, 3)), T(x64: X(4, 5, 6)), T(x64: X( 1,  1,  1)))
        ANKAssertDivisionFullWidth(x, T(x64: X(4, 5, 6)), T(x64: X(1, 2, 3)), T(x64: X( 1,  1,  1)))
        //=--------------------------------------=
        x.low  = T(x64: X(20, 29, 30))
        x.high = T(x64: X(13,  4,  0))

        ANKAssertDivisionFullWidth(x, T(x64: X(3, 2, 1)), T(x64: X(7, 5, 4)), T(x64: X(~0, ~0,  0)))
        ANKAssertDivisionFullWidth(x, T(x64: X(6, 5, 4)), T(x64: X(3, 2, 1)), T(x64: X( 2,  2,  2)))
    }
    
    func testDividingFullWidthReportingOverflow() {
        var dividend: (high: T, low: M)
        //=--------------------------------------=
        dividend.high = T(  )
        dividend.low  = M( 7)
        
        ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
        //=--------------------------------------=
        dividend.high = T.max
        dividend.low  = M( 7)
        
        ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
        //=--------------------------------------=
        dividend.high = T.max - 1
        dividend.low  = M.max
        
        ANKAssertDivisionFullWidth(dividend, T.max, T.max, T.max - 1)
        //=--------------------------------------=
        dividend.high = T.max
        dividend.low  = M.min
        
        ANKAssertDivisionFullWidth(dividend, T.max, T(  ), T(  ), true)
    }
    
    func testDividingFullWidthReportingOverflowTruncatesQuotient() {
        let dividend: (high: T, low: M)
        //=--------------------------------------=
        dividend.high = T(repeating: true )
        dividend.low  = M(repeating: false)
        
        ANKAssertDivisionFullWidth(dividend, T(0), ~T(0) << (T.bitWidth - 0), T(0), true)
        ANKAssertDivisionFullWidth(dividend, T(1), ~T(0) << (T.bitWidth - 0), T(0), true)
        ANKAssertDivisionFullWidth(dividend, T(2), ~T(0) << (T.bitWidth - 1), T(0), true)
        ANKAssertDivisionFullWidth(dividend, T(4), ~T(0) << (T.bitWidth - 2), T(0), true)
        ANKAssertDivisionFullWidth(dividend, T(8), ~T(0) << (T.bitWidth - 3), T(0), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {            
            XCTAssertNotNil(x /= 0)
            XCTAssertNotNil(x %= 0)
            XCTAssertNotNil(x.divideReportingOverflow(by: 0))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: 0))
            
            XCTAssertNotNil(x /  0)
            XCTAssertNotNil(x %  0)
            XCTAssertNotNil(x.dividedReportingOverflow(by: 0))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: 0))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: 0))
            XCTAssertNotNil(x.dividingFullWidth((0, 0)))
        }
    }
}

#endif
