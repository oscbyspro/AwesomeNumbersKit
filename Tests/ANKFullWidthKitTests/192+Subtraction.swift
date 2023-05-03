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
// MARK: * Int192 x Subtraction
//*============================================================================*

final class Int192TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        ANKAssertSubtraction(T( 1), T( 2), T(-1))
        ANKAssertSubtraction(T( 1), T( 1), T( 0))
        ANKAssertSubtraction(T( 1), T( 0), T( 1))
        ANKAssertSubtraction(T( 1), T(-1), T( 2))
        ANKAssertSubtraction(T( 1), T(-2), T( 3))
        
        ANKAssertSubtraction(T( 0), T( 2), T(-2))
        ANKAssertSubtraction(T( 0), T( 1), T(-1))
        ANKAssertSubtraction(T( 0), T( 0), T( 0))
        ANKAssertSubtraction(T( 0), T(-1), T( 1))
        ANKAssertSubtraction(T( 0), T(-2), T( 2))
        
        ANKAssertSubtraction(T(-1), T( 2), T(-3))
        ANKAssertSubtraction(T(-1), T( 1), T(-2))
        ANKAssertSubtraction(T(-1), T( 0), T(-1))
        ANKAssertSubtraction(T(-1), T(-1), T( 0))
        ANKAssertSubtraction(T(-1), T(-2), T( 1))
    }
    
    func testSubtractingUsingLargeValues() {
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)), -T(x64: X(3, 0, 0)), T(x64: X( 2,  0,  1)))
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)), -T(x64: X(0, 3, 0)), T(x64: X(~0,  2,  1)))
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)), -T(x64: X(0, 0, 3)), T(x64: X(~0, ~0,  3)))
        
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)),  T(x64: X(3, 0, 0)), T(x64: X(~3, ~0,  0)))
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)),  T(x64: X(0, 3, 0)), T(x64: X(~0, ~3,  0)))
        ANKAssertSubtraction(T(x64: X(~0, ~0,  0)),  T(x64: X(0, 0, 3)), T(x64: X(~0, ~0, ~2)))
        
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)), -T(x64: X(3, 0, 0)), T(x64: X( 3,  0, ~0)))
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)), -T(x64: X(0, 3, 0)), T(x64: X( 0,  3, ~0)))
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)), -T(x64: X(0, 0, 3)), T(x64: X( 0,  0,  2)))
        
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)),  T(x64: X(3, 0, 0)), T(x64: X(~2, ~0, ~1)))
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)),  T(x64: X(0, 3, 0)), T(x64: X( 0, ~2, ~1)))
        ANKAssertSubtraction(T(x64: X( 0,  0, ~0)),  T(x64: X(0, 0, 3)), T(x64: X( 0,  0, ~3)))
    }
    
    func testSubtractingAtEdges() {
        ANKAssertSubtraction(T.min, T( 2), T.max - T(1), true)
        ANKAssertSubtraction(T.max, T( 2), T.max - T(2))
        
        ANKAssertSubtraction(T.min, T(-2), T.min + T(2))
        ANKAssertSubtraction(T.max, T(-2), T.min + T(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        ANKAssertSubtractionByDigit(T( 1), Int( 2), T(-1))
        ANKAssertSubtractionByDigit(T( 1), Int( 1), T( 0))
        ANKAssertSubtractionByDigit(T( 1), Int( 0), T( 1))
        ANKAssertSubtractionByDigit(T( 1), Int(-1), T( 2))
        ANKAssertSubtractionByDigit(T( 1), Int(-2), T( 3))
        
        ANKAssertSubtractionByDigit(T( 0), Int( 2), T(-2))
        ANKAssertSubtractionByDigit(T( 0), Int( 1), T(-1))
        ANKAssertSubtractionByDigit(T( 0), Int( 0), T( 0))
        ANKAssertSubtractionByDigit(T( 0), Int(-1), T( 1))
        ANKAssertSubtractionByDigit(T( 0), Int(-2), T( 2))
        
        ANKAssertSubtractionByDigit(T(-1), Int( 2), T(-3))
        ANKAssertSubtractionByDigit(T(-1), Int( 1), T(-2))
        ANKAssertSubtractionByDigit(T(-1), Int( 0), T(-1))
        ANKAssertSubtractionByDigit(T(-1), Int(-1), T( 0))
        ANKAssertSubtractionByDigit(T(-1), Int(-2), T( 1))
    }
    
    func testSubtractingDigitUsingLargeValues() {
        ANKAssertSubtractionByDigit(T(x64: X(~0, ~0,  0)), -Int(3), T(x64: X( 2,  0,  1)))
        ANKAssertSubtractionByDigit(T(x64: X(~0, ~0,  0)),  Int(3), T(x64: X(~3, ~0,  0)))
        ANKAssertSubtractionByDigit(T(x64: X( 0,  0, ~0)), -Int(3), T(x64: X( 3,  0, ~0)))
        ANKAssertSubtractionByDigit(T(x64: X( 0,  0, ~0)),  Int(3), T(x64: X(~2, ~0, ~1)))
    }
    
    func testSubtractingDigitAtEdges() {
        ANKAssertSubtractionByDigit(T.min, Int( 2), T.max - T(1), true)
        ANKAssertSubtractionByDigit(T.max, Int( 2), T.max - T(2))
        
        ANKAssertSubtractionByDigit(T.min, Int(-2), T.min + T(2))
        ANKAssertSubtractionByDigit(T.max, Int(-2), T.min + T(1), true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Subtraction
//*============================================================================*

final class UInt192TestsOnSubtraction: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testSubtracting() {
        ANKAssertSubtraction(T(3), T(0), T(3))
        ANKAssertSubtraction(T(3), T(1), T(2))
        ANKAssertSubtraction(T(3), T(2), T(1))
        ANKAssertSubtraction(T(3), T(3), T(0))
    }
    
    func testSubtractingUsingLargeValues() {
        ANKAssertSubtraction(T(x64: X(0, ~0, ~0)), T(x64: X(3, 0, 0)), T(x64: X(~2, ~1, ~0)))
        ANKAssertSubtraction(T(x64: X(0, ~0, ~0)), T(x64: X(0, 3, 0)), T(x64: X( 0, ~3, ~0)))
        ANKAssertSubtraction(T(x64: X(0, ~0, ~0)), T(x64: X(0, 0, 3)), T(x64: X( 0, ~0, ~3)))
    }
    
    func testSubtractingAtEdges() {
        ANKAssertSubtraction(T.min, T(2), T.max - T(1), true)
        ANKAssertSubtraction(T.max, T(2), T.max - T(2))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testSubtractingDigit() {
        ANKAssertSubtractionByDigit(T(3), UInt(0), T(3))
        ANKAssertSubtractionByDigit(T(3), UInt(1), T(2))
        ANKAssertSubtractionByDigit(T(3), UInt(2), T(1))
        ANKAssertSubtractionByDigit(T(3), UInt(3), T(0))
    }
    
    func testSubtractingDigitUsingLargeValues() {
        ANKAssertSubtractionByDigit(T(x64: X(~0, ~0, ~0)), UInt(3), T(x64: X(~3, ~0, ~0)))
        ANKAssertSubtractionByDigit(T(x64: X( 0, ~0, ~0)), UInt(3), T(x64: X(~2, ~1, ~0)))
        ANKAssertSubtractionByDigit(T(x64: X( 0,  0, ~0)), UInt(3), T(x64: X(~2, ~0, ~1)))
    }
    
    func testSubtractingDigitAtEdges() {
        ANKAssertSubtractionByDigit(T.min, UInt(2), T.max - T(1), true)
        ANKAssertSubtractionByDigit(T.max, UInt(2), T.max - T(2))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  -= 0)
            XCTAssertNotNil(x &-= 0)
            XCTAssertNotNil(x.subtractReportingOverflow(0))
            
            XCTAssertNotNil(x  -  0)
            XCTAssertNotNil(x &-  0)
            XCTAssertNotNil(x.subtractingReportingOverflow(0))
        }
    }
}

#endif
