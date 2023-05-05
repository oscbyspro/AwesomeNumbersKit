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
// MARK: * Int256 x Multiplication
//*============================================================================*

final class Int256TestsOnMultiplication: XCTestCase {
    
    typealias T =  ANKInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)),  T(0),  T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)), -T(0), -T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)),  T(0), -T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)), -T(0),  T(x64: X(0, 0, 0, 0)))
        
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)),  T(1),  T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)), -T(1), -T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)),  T(1), -T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)), -T(1),  T(x64: X(1, 2, 3, 4)))
        
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)),  T(2),  T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplication( T(x64: X(1, 2, 3, 4)), -T(2), -T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)),  T(2), -T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplication(-T(x64: X(1, 2, 3, 4)), -T(2),  T(x64: X(2, 4, 6, 8)))
    }
    
    func testMultiplyingUsingLargeValues() {
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(2, 0, 0, 0)), T(x64: X( 2,  4,  6,  8)), T(x64: X( 0,  0,  0,  0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 2, 0, 0)), T(x64: X( 0,  2,  4,  6)), T(x64: X( 8,  0,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0,  2,  4)), T(x64: X( 6,  8,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0,  2)), T(x64: X( 4,  6,  8,  0)), true)
        
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)), -T(x64: X(2, 0, 0, 0)), T(x64: X(~1, ~4, ~6, ~8)), T(x64: X(~0, ~0, ~0, ~0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)), -T(x64: X(0, 2, 0, 0)), T(x64: X( 0, ~1, ~4, ~6)), T(x64: X(~8, ~0, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)), -T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0, ~1, ~4)), T(x64: X(~6, ~8, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)), -T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0, ~1)), T(x64: X(~4, ~6, ~8, ~0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(2, 0, 0, 0)), T(x64: X(~3, ~4, ~6, ~8)), T(x64: X(~0, ~0, ~0, ~0)))
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 2, 0, 0)), T(x64: X( 0, ~3, ~4, ~6)), T(x64: X(~8, ~0, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0, ~3, ~4)), T(x64: X(~6, ~8, ~0, ~0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0, ~3)), T(x64: X(~4, ~6, ~8, ~0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)), -T(x64: X(2, 0, 0, 0)), T(x64: X( 4,  4,  6,  8)), T(x64: X( 0,  0,  0,  0)))
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)), -T(x64: X(0, 2, 0, 0)), T(x64: X( 0,  4,  4,  6)), T(x64: X( 8,  0,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)), -T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0,  4,  4)), T(x64: X( 6,  8,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)), -T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0,  4)), T(x64: X( 4,  6,  8,  0)), true)
    }
    
    func testMultiplyingReportingOverflow() {
        ANKAssertMultiplication(T.max, T( 1), T.max,        T( 0), false)
        ANKAssertMultiplication(T.max, T(-1), T.min + T(1), T(-1), false)
        ANKAssertMultiplication(T.min, T( 1), T.min,        T(-1), false)
        ANKAssertMultiplication(T.min, T(-1), T.min,        T( 0), true )
        
        ANKAssertMultiplication(T.max, T( 2), T(-2),        T( 0), true )
        ANKAssertMultiplication(T.max, T(-2), T( 2),        T(-1), true )
        ANKAssertMultiplication(T.min, T( 2), T( 0),        T(-1), true )
        ANKAssertMultiplication(T.min, T(-2), T( 0),        T( 1), true )
        
        ANKAssertMultiplication(T.max, T.max, T( 1), T(x64: X(~0, ~0, ~0, ~0 >>  2)), true)
        ANKAssertMultiplication(T.max, T.min, T.min, T(x64: X( 0,  0,  0, ~0 << 62)), true)
        ANKAssertMultiplication(T.min, T.max, T.min, T(x64: X( 0,  0,  0, ~0 << 62)), true)
        ANKAssertMultiplication(T.min, T.min, T( 0), T(x64: X( 0,  0,  0,  1 << 62)), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultiplyingByDigit() {
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)),  Int(0),  T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)), -Int(0), -T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)),  Int(0), -T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)), -Int(0),  T(x64: X(0, 0, 0, 0)))
        
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)),  Int(1),  T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)), -Int(1), -T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)),  Int(1), -T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)), -Int(1),  T(x64: X(1, 2, 3, 4)))
        
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)),  Int(2),  T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplicationByDigit( T(x64: X(1, 2, 3, 4)), -Int(2), -T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)),  Int(2), -T(x64: X(2, 4, 6, 8)))
        ANKAssertMultiplicationByDigit(-T(x64: X(1, 2, 3, 4)), -Int(2),  T(x64: X(2, 4, 6, 8)))
    }
    
    func testMultiplyingByDigitUsingLargeValues() {
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3,  4)),  Int(2), T(x64: X( 2,  4,  6,  8)),  Int(0))
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3,  4)), -Int(2), T(x64: X(~1, ~4, ~6, ~8)), -Int(1))
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3, ~4)),  Int(2), T(x64: X(~3, ~4, ~6, ~8)), -Int(1))
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3, ~4)), -Int(2), T(x64: X( 4,  4,  6,  8)),  Int(0))
    }
    
    func testMultiplyingByDigitReportingOverflow() {
        ANKAssertMultiplicationByDigit(T.max, Int( 1), T.max,        Int( 0), false)
        ANKAssertMultiplicationByDigit(T.max, Int(-1), T.min + T(1), Int(-1), false)
        ANKAssertMultiplicationByDigit(T.min, Int( 1), T.min,        Int(-1), false)
        ANKAssertMultiplicationByDigit(T.min, Int(-1), T.min,        Int( 0), true )
        
        ANKAssertMultiplicationByDigit(T.max, Int( 2), T(-2),        Int( 0), true )
        ANKAssertMultiplicationByDigit(T.max, Int(-2), T( 2),        Int(-1), true )
        ANKAssertMultiplicationByDigit(T.min, Int( 2), T( 0),        Int(-1), true )
        ANKAssertMultiplicationByDigit(T.min, Int(-2), T( 0),        Int( 1), true )
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
// MARK: * UInt256 x Multiplication
//*============================================================================*

final class UInt256TestsOnMultiplication: XCTestCase {
    
    typealias T = ANKUInt256
    typealias M = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMultiplying() {
        ANKAssertMultiplication(T(x64: X(1, 2, 3, 4)), T(0), T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplication(T(x64: X(1, 2, 3, 4)), T(1), T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplication(T(x64: X(1, 2, 3, 4)), T(2), T(x64: X(2, 4, 6, 8)))
    }
    
    func testMultiplyingUsingLargeValues() {
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(2, 0, 0, 0)), T(x64: X( 2,  4,  6,  8)), T(x64: X( 0,  0,  0,  0)))
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 2, 0, 0)), T(x64: X( 0,  2,  4,  6)), T(x64: X( 8,  0,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0,  2,  4)), T(x64: X( 6,  8,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X( 1,  2,  3,  4)),  T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0,  2)), T(x64: X( 4,  6,  8,  0)), true)
        
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(2, 0, 0, 0)), T(x64: X(~3, ~4, ~6, ~8)), T(x64: X( 1,  0,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 2, 0, 0)), T(x64: X( 0, ~3, ~4, ~6)), T(x64: X(~8,  1,  0,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 0, 2, 0)), T(x64: X( 0,  0, ~3, ~4)), T(x64: X(~6, ~8,  1,  0)), true)
        ANKAssertMultiplication(T(x64: X(~1, ~2, ~3, ~4)),  T(x64: X(0, 0, 0, 2)), T(x64: X( 0,  0,  0, ~3)), T(x64: X(~4, ~6, ~8,  1)), true)
    }

    func testMultiplyingReportingOverflow() {
        ANKAssertMultiplication(T.max, T( 2), ~T(1),  T(1), true)
        ANKAssertMultiplication(T.max, T.max,  T(1), ~T(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testMultipliedByDigit() {
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3, 4)), UInt(0), T(x64: X(0, 0, 0, 0)))
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3, 4)), UInt(1), T(x64: X(1, 2, 3, 4)))
        ANKAssertMultiplicationByDigit(T(x64: X(1, 2, 3, 4)), UInt(2), T(x64: X(2, 4, 6, 8)))
    }
    
    func testMultiplyingByDigitUsingLargeValues() {
        ANKAssertMultiplicationByDigit(T(x64: X(~1, ~2, ~3, ~4)), UInt(2), T(x64: X(~3, ~4, ~6, ~8)), UInt(1), true )
        ANKAssertMultiplicationByDigit(T(x64: X( 1,  2,  3,  4)), UInt(2), T(x64: X( 2,  4,  6,  8)), UInt(0), false)
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
