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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Division
//*============================================================================*

final class ANKSignedTestsOnDivision: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    typealias M = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        XCTAssertEqual( T(0) /  T(1),  T(0))
        XCTAssertEqual( T(0) /  T(2),  T(0))
        XCTAssertEqual( T(0) %  T(1),  T(0))
        XCTAssertEqual( T(0) %  T(2),  T(0))
        
        XCTAssertEqual( T(7) /  T(1),  T(7))
        XCTAssertEqual( T(7) /  T(2),  T(3))
        XCTAssertEqual( T(7) %  T(1),  T(0))
        XCTAssertEqual( T(7) %  T(2),  T(1))
        
        XCTAssertEqual( T(7) /  T(3),  T(2))
        XCTAssertEqual( T(7) / -T(3), -T(2))
        XCTAssertEqual(-T(7) /  T(3), -T(2))
        XCTAssertEqual(-T(7) / -T(3),  T(2))
        
        XCTAssertEqual( T(7) %  T(3),  T(1))
        XCTAssertEqual( T(7) % -T(3),  T(1))
        XCTAssertEqual(-T(7) %  T(3), -T(1))
        XCTAssertEqual(-T(7) % -T(3), -T(1))
    }
    
    func testQuotientReportingOverflow() {
        XCTAssert((T.min).dividedReportingOverflow(by:  T(0)) == ((T.min),  true) as (T, Bool))
        XCTAssert((T.min).dividedReportingOverflow(by: -T(1)) == ((T.max), false) as (T, Bool))
        
        XCTAssert(( T(7)).dividedReportingOverflow(by:  T(3)) == (( T(2)), false) as (T, Bool))
        XCTAssert(( T(7)).dividedReportingOverflow(by: -T(3)) == ((-T(2)), false) as (T, Bool))
        XCTAssert((-T(7)).dividedReportingOverflow(by:  T(3)) == ((-T(2)), false) as (T, Bool))
        XCTAssert((-T(7)).dividedReportingOverflow(by: -T(3)) == (( T(2)), false) as (T, Bool))
    }

    func testRemainderReportingOverflow() {
        XCTAssert((T.min).remainderReportingOverflow(dividingBy:  T(0)) == ((T.min),  true) as (T, Bool))
        XCTAssert((T.min).remainderReportingOverflow(dividingBy: -T(1)) == (( T(0)), false) as (T, Bool))
        
        XCTAssert(( T(7)).remainderReportingOverflow(dividingBy:  T(3)) == (( T(1)), false) as (T, Bool))
        XCTAssert(( T(7)).remainderReportingOverflow(dividingBy: -T(3)) == (( T(1)), false) as (T, Bool))
        XCTAssert((-T(7)).remainderReportingOverflow(dividingBy:  T(3)) == ((-T(1)), false) as (T, Bool))
        XCTAssert((-T(7)).remainderReportingOverflow(dividingBy: -T(3)) == ((-T(1)), false) as (T, Bool))
    }
    
    func testQuotientAndRemainderReportingOverflow() {
        var x: PVO<QR<T, T>>
        //=--------------------------------------=
        // Divisor: 0, -1
        //=--------------------------------------=
        x = T(7).quotientAndRemainderReportingOverflow(dividingBy: T( 0))
        XCTAssertEqual(x.partialValue.quotient,  T( 7))
        XCTAssertEqual(x.partialValue.remainder, T( 7))
        XCTAssertEqual(x.overflow, true)
        //=--------------------------------------=
        x = T.min.quotientAndRemainderReportingOverflow(dividingBy: T(-1))
        XCTAssertEqual(x.partialValue.quotient,  T.max)
        XCTAssertEqual(x.partialValue.remainder, T( 0))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        // Standard
        //=--------------------------------------=
        x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T( 3))
        XCTAssertEqual(x.partialValue.quotient,  T( 2))
        XCTAssertEqual(x.partialValue.remainder, T( 1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: T(-3))
        XCTAssertEqual(x.partialValue.quotient,  T(-2))
        XCTAssertEqual(x.partialValue.remainder, T( 1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: T( 3))
        XCTAssertEqual(x.partialValue.quotient,  T(-2))
        XCTAssertEqual(x.partialValue.remainder, T(-1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: T(-3))
        XCTAssertEqual(x.partialValue.quotient,  T( 2))
        XCTAssertEqual(x.partialValue.remainder, T(-1))
        XCTAssertEqual(x.overflow, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testDividingByDigit() {
        XCTAssertEqual( T(0) /  D(1),  T(0))
        XCTAssertEqual( T(0) /  D(2),  T(0))
        XCTAssertEqual( T(0) %  D(1),  D(0))
        XCTAssertEqual( T(0) %  D(2),  D(0))

        XCTAssertEqual( T(7) /  D(1),  T(7))
        XCTAssertEqual( T(7) /  D(2),  T(3))
        XCTAssertEqual( T(7) %  D(1),  D(0))
        XCTAssertEqual( T(7) %  D(2),  D(1))
                
        XCTAssertEqual( T(7) /  D(3),  T(2))
        XCTAssertEqual( T(7) / -D(3), -T(2))
        XCTAssertEqual(-T(7) /  D(3), -T(2))
        XCTAssertEqual(-T(7) / -D(3),  T(2))
        
        XCTAssertEqual( T(7) %  D(3),  D(1))
        XCTAssertEqual( T(7) % -D(3),  D(1))
        XCTAssertEqual(-T(7) %  D(3), -D(1))
        XCTAssertEqual(-T(7) % -D(3), -D(1))
    }
    
    func testQuotientReportingOverflowDividingByDigit() {
        XCTAssert((T.min).dividedReportingOverflow(by:  D(0)) == ((T.min),  true) as (T, Bool))
        XCTAssert((T.min).dividedReportingOverflow(by: -D(1)) == ((T.max), false) as (T, Bool))
        
        XCTAssert(( T(7)).dividedReportingOverflow(by:  D(3)) == (( T(2)), false) as (T, Bool))
        XCTAssert(( T(7)).dividedReportingOverflow(by: -D(3)) == ((-T(2)), false) as (T, Bool))
        XCTAssert((-T(7)).dividedReportingOverflow(by:  D(3)) == ((-T(2)), false) as (T, Bool))
        XCTAssert((-T(7)).dividedReportingOverflow(by: -D(3)) == (( T(2)), false) as (T, Bool))
    }

    func testRemainderReportingOverflowDividingByDigit() {
        XCTAssert((T.min).remainderReportingOverflow(dividingBy:  D(0)) == (( D(0)),  true) as (D, Bool))
        XCTAssert((T.min).remainderReportingOverflow(dividingBy: -D(1)) == (( D(0)), false) as (D, Bool))
        
        XCTAssert(( T(7)).remainderReportingOverflow(dividingBy:  D(3)) == (( D(1)), false) as (D, Bool))
        XCTAssert(( T(7)).remainderReportingOverflow(dividingBy: -D(3)) == (( D(1)), false) as (D, Bool))
        XCTAssert((-T(7)).remainderReportingOverflow(dividingBy:  D(3)) == ((-D(1)), false) as (D, Bool))
        XCTAssert((-T(7)).remainderReportingOverflow(dividingBy: -D(3)) == ((-D(1)), false) as (D, Bool))
    }
    
    func testQuotientAndRemainderDividingByDigitReportingOverflow() {
        var x: PVO<QR<T, T.Digit>>
        //=--------------------------------------=
        // Divisor: 0, -1
        //=--------------------------------------=
        x = T(7).quotientAndRemainderReportingOverflow(dividingBy: D( 0))
        XCTAssertEqual(x.partialValue.quotient,  T( 7))
        XCTAssertEqual(x.partialValue.remainder, D( 0))
        XCTAssertEqual(x.overflow, true)
        //=--------------------------------------=
        x = T.min.quotientAndRemainderReportingOverflow(dividingBy: D(-1))
        XCTAssertEqual(x.partialValue.quotient,  T.max)
        XCTAssertEqual(x.partialValue.remainder, D( 0))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        // Standard
        //=--------------------------------------=
        x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: D( 3))
        XCTAssertEqual(x.partialValue.quotient,  T( 2))
        XCTAssertEqual(x.partialValue.remainder, D( 1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T( 7).quotientAndRemainderReportingOverflow(dividingBy: D(-3))
        XCTAssertEqual(x.partialValue.quotient,  T(-2))
        XCTAssertEqual(x.partialValue.remainder, D( 1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: D( 3))
        XCTAssertEqual(x.partialValue.quotient,  T(-2))
        XCTAssertEqual(x.partialValue.remainder, D(-1))
        XCTAssertEqual(x.overflow, false)
        //=--------------------------------------=
        x = T(-7).quotientAndRemainderReportingOverflow(dividingBy: D(-3))
        XCTAssertEqual(x.partialValue.quotient,  T( 2))
        XCTAssertEqual(x.partialValue.remainder, D(-1))
        XCTAssertEqual(x.overflow, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        XCTAssert(T.max.dividingFullWidth(( T(1), M( 1))) == ( T(1),  T(2)) as (T, T))
        XCTAssert(T.max.dividingFullWidth((-T(1), M( 1))) == (-T(1), -T(2)) as (T, T))
        XCTAssert(T.min.dividingFullWidth(( T(1), M( 1))) == (-T(1),  T(2)) as (T, T))
        XCTAssert(T.min.dividingFullWidth((-T(1), M( 1))) == ( T(1), -T(2)) as (T, T))
        
        XCTAssert(( T(2)).dividingFullWidth(( T(1), M( 1))) == (T.max/T(2) + T(1),  T(1)) as (T, T))
        XCTAssert(( T(2)).dividingFullWidth((-T(1), M( 1))) == (T.min/T(2) - T(1), -T(1)) as (T, T))
        XCTAssert((-T(2)).dividingFullWidth(( T(1), M( 1))) == (T.min/T(2) - T(1),  T(1)) as (T, T))
        XCTAssert((-T(2)).dividingFullWidth((-T(1), M( 1))) == (T.max/T(2) + T(1), -T(1)) as (T, T))
    }
    
    func testDividingFullWidthTruncatesQuotient() {
        XCTAssert(T.max.dividingFullWidth((T.max, M.max)) == ( T(1),  T(0)) as (T, T))
        XCTAssert(T.max.dividingFullWidth((T.min, M.max)) == (-T(1),  T(0)) as (T, T))
        XCTAssert(T.min.dividingFullWidth((T.max, M.max)) == (-T(1),  T(0)) as (T, T))
        XCTAssert(T.min.dividingFullWidth((T.min, M.max)) == ( T(1),  T(0)) as (T, T))
        
        XCTAssert(( T(2)).dividingFullWidth((T.max, M.max)) == (T.max,  T(1)) as (T, T))
        XCTAssert(( T(2)).dividingFullWidth((T.min, M.max)) == (T.min, -T(1)) as (T, T))
        XCTAssert((-T(2)).dividingFullWidth((T.max, M.max)) == (T.min,  T(1)) as (T, T))
        XCTAssert((-T(2)).dividingFullWidth((T.min, M.max)) == (T.max, -T(1)) as (T, T))
        
        XCTAssert(( T(1)).dividingFullWidth(( T(2), M( 3))) == ( T(3),  T(0)) as (T, T))
        XCTAssert(( T(1)).dividingFullWidth((-T(2), M( 3))) == (-T(3), -T(0)) as (T, T))
        XCTAssert((-T(1)).dividingFullWidth(( T(2), M( 3))) == (-T(3),  T(0)) as (T, T))
        XCTAssert((-T(1)).dividingFullWidth((-T(2), M( 3))) == ( T(3), -T(0)) as (T, T))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhereDigitIsSelf() {
        func becauseThisCompilesSuccessfully(_ x: inout D.Digit) {
            XCTAssertNotNil(x /= D(0))
            XCTAssertNotNil(x %= D(0))
            XCTAssertNotNil(x.divideReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.formRemainderReportingOverflow(dividingBy: D(0)))
            
            XCTAssertNotNil(x /  D(0))
            XCTAssertNotNil(x %  D(0))
            XCTAssertNotNil(x.dividedReportingOverflow(by: D(0)))
            XCTAssertNotNil(x.remainderReportingOverflow(dividingBy: D(0)))
            XCTAssertNotNil(x.quotientAndRemainder(dividingBy: D(0)))
            XCTAssertNotNil(x.quotientAndRemainderReportingOverflow(dividingBy: D(0)))
            XCTAssertNotNil(x.dividingFullWidth((D(0), UInt(0))))
        }
    }
    
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
