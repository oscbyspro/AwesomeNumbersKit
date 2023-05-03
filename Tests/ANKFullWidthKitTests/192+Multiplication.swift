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
    
    func testMultiplying() {
        ANKAssertMultiplication( T(x64: X(1, 2, 3)),  T(0),  T(x64: X(0, 0, 0)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3)), -T(0), -T(x64: X(0, 0, 0)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)),  T(0), -T(x64: X(0, 0, 0)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)), -T(0),  T(x64: X(0, 0, 0)))
        
        ANKAssertMultiplication( T(x64: X(1, 2, 3)),  T(1),  T(x64: X(1, 2, 3)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3)), -T(1), -T(x64: X(1, 2, 3)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)),  T(1), -T(x64: X(1, 2, 3)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)), -T(1),  T(x64: X(1, 2, 3)))
        
        ANKAssertMultiplication( T(x64: X(1, 2, 3)),  T(2),  T(x64: X(2, 4, 6)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3)), -T(2), -T(x64: X(2, 4, 6)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)),  T(2), -T(x64: X(2, 4, 6)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3)), -T(2),  T(x64: X(2, 4, 6)))
    }
    
    func testMultiplyingUsingLargeValues() {
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(2, 0, 0)), T(x64: X( 2,  4,  6)), T(x64: X( 0,  0,  0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(0, 2, 0)), T(x64: X( 0,  2,  4)), T(x64: X( 6,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(0, 0, 2)), T(x64: X( 0,  0,  2)), T(x64: X( 4,  6,  0)), true)
        
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)), -T(x64: X(2, 0, 0)), T(x64: X(~1, ~4, ~6)), T(x64: X(~0, ~0, ~0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)), -T(x64: X(0, 2, 0)), T(x64: X( 0, ~1, ~4)), T(x64: X(~6, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)), -T(x64: X(0, 0, 2)), T(x64: X( 0,  0, ~1)), T(x64: X(~4, ~6, ~0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(2, 0, 0)), T(x64: X(~3, ~4, ~6)), T(x64: X(~0, ~0, ~0)))
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(0, 2, 0)), T(x64: X( 0, ~3, ~4)), T(x64: X(~6, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(0, 0, 2)), T(x64: X( 0,  0, ~3)), T(x64: X(~4, ~6, ~0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)), -T(x64: X(2, 0, 0)), T(x64: X( 4,  4,  6)), T(x64: X( 0,  0,  0)))
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)), -T(x64: X(0, 2, 0)), T(x64: X( 0,  4,  4)), T(x64: X( 6,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)), -T(x64: X(0, 0, 2)), T(x64: X( 0,  0,  4)), T(x64: X( 4,  6,  0)), true)
    }
    
    func testMultiplyingReportingOverflow() {
        ANKAssertMultiplication(T.min, T(-2), T( 0), T( 1), true)
        ANKAssertMultiplication(T.min, T( 2), T( 0), T(-1), true)
        ANKAssertMultiplication(T.max, T(-2), T( 2), T(-1), true)
        ANKAssertMultiplication(T.max, T( 2), T(-2), T( 0), true)
        
        ANKAssertMultiplication(T.min, T.min, T( 0), T(x64: X( 0,  0,  1 << 62)), true)
        ANKAssertMultiplication(T.min, T.max, T.min, T(x64: X( 0,  0, ~0 << 62)), true)
        ANKAssertMultiplication(T.max, T.min, T.min, T(x64: X( 0,  0, ~0 << 62)), true)
        ANKAssertMultiplication(T.max, T.max, T( 1), T(x64: X(~0, ~0, ~0 >>  2)), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultiplyingByDigit() {
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)),  Int(0),  T(x64: X(0, 0, 0)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)), -Int(0), -T(x64: X(0, 0, 0)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)),  Int(0), -T(x64: X(0, 0, 0)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)), -Int(0),  T(x64: X(0, 0, 0)))
        
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)),  Int(1),  T(x64: X(1, 2, 3)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)), -Int(1), -T(x64: X(1, 2, 3)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)),  Int(1), -T(x64: X(1, 2, 3)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)), -Int(1),  T(x64: X(1, 2, 3)))
        
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)),  Int(2),  T(x64: X(2, 4, 6)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3)), -Int(2), -T(x64: X(2, 4, 6)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)),  Int(2), -T(x64: X(2, 4, 6)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3)), -Int(2),  T(x64: X(2, 4, 6)))
    }
    
    func testMultiplyingByDigitUsingLargeValues() {
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3)),  Int(2), T(x64: X( 2,  4,  6)),  Int(0))
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3)), -Int(2), T(x64: X(~1, ~4, ~6)), -Int(1))
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3)),  Int(2), T(x64: X(~3, ~4, ~6)), -Int(1))
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3)), -Int(2), T(x64: X( 4,  4,  6)),  Int(0))
    }
    
    func testMultiplyingByDigitReportingOverflow() {
        ANKAssertMultiplicationByDigit(T.min, Int(-2), T( 0), Int( 1), true)
        ANKAssertMultiplicationByDigit(T.min, Int( 2), T( 0), Int(-1), true)
        ANKAssertMultiplicationByDigit(T.max, Int(-2), T( 2), Int(-1), true)
        ANKAssertMultiplicationByDigit(T.max, Int( 2), T(-2), Int( 0), true)
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
    
    func testMultiplying() {
        ANKAssertMultiplication(T(x64: X(1, 2, 3)), T(0), T(x64: X(0, 0, 0)))
        ANKAssertMultiplication(T(x64: X(1, 2, 3)), T(1), T(x64: X(1, 2, 3)))
        ANKAssertMultiplication(T(x64: X(1, 2, 3)), T(2), T(x64: X(2, 4, 6)))
    }
    
    func testMultiplyingUsingLargeValues() {
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(2, 0, 0)), T(x64: X( 2,  4,  6)), T(x64: X( 0,  0,  0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(0, 2, 0)), T(x64: X( 0,  2,  4)), T(x64: X( 6,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3)),  T(x64: X(0, 0, 2)), T(x64: X( 0,  0,  2)), T(x64: X( 4,  6,  0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(2, 0, 0)), T(x64: X(~3, ~4, ~6)), T(x64: X( 1,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(0, 2, 0)), T(x64: X( 0, ~3, ~4)), T(x64: X(~6,  1,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3)),  T(x64: X(0, 0, 2)), T(x64: X( 0,  0, ~3)), T(x64: X(~4, ~6,  1)), true)
    }
    
    func testMultiplyingReportingOverflow() {
        ANKAssertMultiplication(T.max, T( 2), ~T(1),  T(1), true)
        ANKAssertMultiplication(T.max, T.max,  T(1), ~T(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3)), UInt(0), T(x64: X(0, 0, 0)))
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3)), UInt(1), T(x64: X(1, 2, 3)))
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3)), UInt(2), T(x64: X(2, 4, 6)))
    }
    
    func testMultiplyingByDigitUsingLargeValues() {
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3)), UInt(2), T(x64: X(~3, ~4, ~6)), UInt(1), true )
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3)), UInt(2), T(x64: X( 2,  4,  6)), UInt(0), false)
    }
    
    func testMultipliedByDigitReportingOverflow() {
        ANKAssertMultiplicationByDigit(T.min, UInt(2),  T(0), UInt(0), false)
        ANKAssertMultiplicationByDigit(T.max, UInt(2), ~T(1), UInt(1), true )
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
