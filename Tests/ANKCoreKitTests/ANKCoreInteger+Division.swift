//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Division
//*============================================================================*

final class ANKCoreIntegerTestsOnDivision: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividing() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDivision(T(  ), T( 1), T(  ), T(  ))
            ANKAssertDivision(T(  ), T( 2), T(  ), T(  ))
            ANKAssertDivision(T( 7), T( 1), T( 7), T(  ))
            ANKAssertDivision(T( 7), T( 2), T( 3), T( 1))

            ANKAssertDivision(T( 7), T( 3), T( 2), T( 1))
            ANKAssertDivision(T( 7), T(-3), T(-2), T( 1))
            ANKAssertDivision(T(-7), T( 3), T(-2), T(-1))
            ANKAssertDivision(T(-7), T(-3), T( 2), T(-1))
        }
        
        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDivision(T(  ), T( 1), T(  ), T(  ))
            ANKAssertDivision(T(  ), T( 2), T(  ), T(  ))
            ANKAssertDivision(T( 7), T( 1), T( 7), T(  ))
            ANKAssertDivision(T( 7), T( 2), T( 3), T( 1))
        }

        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }

    func testDividingReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDivision(T(  ), T(  ), T(  ),     T(  ), true)
            ANKAssertDivision(T( 1), T(  ), T( 1),     T( 1), true)
            ANKAssertDivision(T( 2), T(  ), T( 2),     T( 2), true)
            ANKAssertDivision(T.min, T(-1), T.min,     T(  ), true)
            ANKAssertDivision(T.max, T(-1), T.min + 1, T(  ))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            ANKAssertDivision(T(  ), T(  ), T(  ),     T(  ), true)
            ANKAssertDivision(T( 1), T(  ), T( 1),     T( 1), true)
            ANKAssertDivision(T( 2), T(  ), T( 2),     T( 2), true)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Full Width
    //=------------------------------------------------------------------------=
    
    func testDividingFullWidth() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            var dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T.max / 2
            dividend.low  = M( 1)

            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T(  ))
            //=----------------------------------=
            dividend.high = T.max / 2
            dividend.low  = M.max / 2

            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T.max - 1)
            //=----------------------------------=
            dividend.high = T.max / 2 + 1
            dividend.low  = M(  )

            ANKAssertDivisionFullWidth(dividend, T.min, T.min, T(  ))
            //=----------------------------------=
            dividend.high = T.max / 2 + 1
            dividend.low  = M.max / 2

            ANKAssertDivisionFullWidth(dividend, T.min, T.min, T.max)
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            var dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T.max - 1
            dividend.low  = M( 1)

            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T(  ))
            //=----------------------------------=
            dividend.high = T.max - 1
            dividend.low  = M.max

            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T.max - 1)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testDividingFullWidthReportingOverflow() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            var dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T(  )
            dividend.low  = M( 7)

            ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
            //=----------------------------------=
            dividend.high = T(-1)
            dividend.low  = M( 7)
            
            ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
            //=--------------------------------------=
            dividend.high = T(-1)
            dividend.low  = M.max
            
            ANKAssertDivisionFullWidth(dividend, T( 2), T(  ), T(-1))
            //=--------------------------------------=
            dividend.high = T(  )
            dividend.low  = M( 1)
            
            ANKAssertDivisionFullWidth(dividend, T(-2), T(  ), T( 1))
            //=----------------------------------=
            dividend.high = T(  )
            dividend.low  = M(bitPattern: T.max)

            ANKAssertDivisionFullWidth(dividend, T(-1), T.min + 1, T(  ))
            //=----------------------------------=
            dividend.high = T(-1)
            dividend.low  = M(bitPattern: T.min)
            
            ANKAssertDivisionFullWidth(dividend, T(-1), T.min, T(  ), true)
            //=----------------------------------=
            dividend.high = T.max >> 1
            dividend.low  = M.max >> 1
            
            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T.max - 1)
            //=----------------------------------=
            dividend.high = T.max >> 1
            dividend.low  = M.max >> 1 + 1
            
            ANKAssertDivisionFullWidth(dividend, T.max, T.min, T(  ), true)
            //=----------------------------------=
            dividend.high = T.max >> 1 + 1
            dividend.low  = M.max >> 1
            
            ANKAssertDivisionFullWidth(dividend, T.min, T.min, T.max)
            //=----------------------------------=
            dividend.high = T.max >> 1 + 1
            dividend.low  = M.max >> 1 + 1
            
            ANKAssertDivisionFullWidth(dividend, T.min, T.max, T(  ), true)
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            var dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T(  )
            dividend.low  = M( 7)
            
            ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
            //=----------------------------------=
            dividend.high = T.max
            dividend.low  = M( 7)
            
            ANKAssertDivisionFullWidth(dividend, T(  ), T( 7), T( 7), true)
            //=----------------------------------=
            dividend.high = T.max - 1
            dividend.low  = M.max
            
            ANKAssertDivisionFullWidth(dividend, T.max, T.max, T.max - 1)
            //=----------------------------------=
            dividend.high = T.max
            dividend.low  = M.min
            
            ANKAssertDivisionFullWidth(dividend, T.max, T.min, T.min, true)
        }
                
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    func testDividingFullWidthReportingOverflowTruncatesQuotient() {
        func whereIsSigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            let dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T(repeating: true )
            dividend.low  = M(repeating: false)
            
            ANKAssertDivisionFullWidth(dividend, T( ), ~T( ) << (T.bitWidth - 0), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(1), ~T( ) << (T.bitWidth - 0), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(2), ~T( ) << (T.bitWidth - 1), T( ))
            ANKAssertDivisionFullWidth(dividend, T(4), ~T( ) << (T.bitWidth - 2), T( ))
            ANKAssertDivisionFullWidth(dividend, T(8), ~T( ) << (T.bitWidth - 3), T( ))
        }

        func whereIsUnsigned<T>(_ type: T.Type) where T: ANKCoreInteger {
            typealias M = T.Magnitude
            //=----------------------------------=
            let dividend: (high: T, low: M)
            //=----------------------------------=
            dividend.high = T(repeating: true )
            dividend.low  = M(repeating: false)
            
            ANKAssertDivisionFullWidth(dividend, T( ), ~T( ) << (T.bitWidth - 0), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(1), ~T( ) << (T.bitWidth - 0), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(2), ~T( ) << (T.bitWidth - 1), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(4), ~T( ) << (T.bitWidth - 2), T( ), true)
            ANKAssertDivisionFullWidth(dividend, T(8), ~T( ) << (T.bitWidth - 3), T( ), true)
        }
        
        for type: T in types {
            type.isSigned ? whereIsSigned(type) : whereIsUnsigned(type)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout some ANKCoreInteger) {
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
