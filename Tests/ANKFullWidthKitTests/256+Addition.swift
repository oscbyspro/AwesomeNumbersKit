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
// MARK: * ANK x Int256 x Addition
//*============================================================================*

final class Int256TestsOnAddition: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        ANKAssertAddition(T( 1), T( 2), T( 3))
        ANKAssertAddition(T( 1), T( 1), T( 2))
        ANKAssertAddition(T( 1), T( 0), T( 1))
        ANKAssertAddition(T( 1), T(-1), T( 0))
        ANKAssertAddition(T( 1), T(-2), T(-1))
        
        ANKAssertAddition(T( 0), T( 2), T( 2))
        ANKAssertAddition(T( 0), T( 1), T( 1))
        ANKAssertAddition(T( 0), T( 0), T( 0))
        ANKAssertAddition(T( 0), T(-1), T(-1))
        ANKAssertAddition(T( 0), T(-2), T(-2))
        
        ANKAssertAddition(T(-1), T( 2), T( 1))
        ANKAssertAddition(T(-1), T( 1), T( 0))
        ANKAssertAddition(T(-1), T( 0), T(-1))
        ANKAssertAddition(T(-1), T(-1), T(-2))
        ANKAssertAddition(T(-1), T(-2), T(-3))
    }
    
    func testAddingUsingLargeValues() {
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)),  T(x64: X(3, 0, 0, 0)), T(x64: X( 2,  0,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)),  T(x64: X(0, 3, 0, 0)), T(x64: X(~0,  2,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)),  T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0,  2,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)),  T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0,  3)))
        
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), -T(x64: X(3, 0, 0, 0)), T(x64: X(~3, ~0, ~0,  0)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), -T(x64: X(0, 3, 0, 0)), T(x64: X(~0, ~3, ~0,  0)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), -T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0, ~3,  0)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), -T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0, ~2)))
        
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)),  T(x64: X(3, 0, 0, 0)), T(x64: X( 3,  0,  0, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)),  T(x64: X(0, 3, 0, 0)), T(x64: X( 0,  3,  0, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)),  T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0,  3, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)),  T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0,  2)))
        
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)), -T(x64: X(3, 0, 0, 0)), T(x64: X(~2, ~0, ~0, ~1)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)), -T(x64: X(0, 3, 0, 0)), T(x64: X( 0, ~2, ~0, ~1)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)), -T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0, ~2, ~1)))
        ANKAssertAddition(T(x64: X( 0,  0,  0, ~0)), -T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0, ~3)))
    }
    
    func testAddingReportingOverflow() {
        ANKAssertAddition(T.min, T( 1), T.min + T(1))
        ANKAssertAddition(T.min, T(-1), T.max,  true)
        
        ANKAssertAddition(T.max, T( 1), T.min,  true)
        ANKAssertAddition(T.max, T(-1), T.max - T(1))
        
        ANKAssertAddition(T(high: .max, low: .max), T(-1), T(high: .max, low: .max - 1), false) // carry 1st
        ANKAssertAddition(T(high: .min, low: .max), T(-1), T(high: .min, low: .max - 1), false) // carry 2nd
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        ANKAssertAdditionByDigit(T( 1), Int( 2), T( 3))
        ANKAssertAdditionByDigit(T( 1), Int( 1), T( 2))
        ANKAssertAdditionByDigit(T( 1), Int( 0), T( 1))
        ANKAssertAdditionByDigit(T( 1), Int(-1), T( 0))
        ANKAssertAdditionByDigit(T( 1), Int(-2), T(-1))
        
        ANKAssertAdditionByDigit(T( 0), Int( 2), T( 2))
        ANKAssertAdditionByDigit(T( 0), Int( 1), T( 1))
        ANKAssertAdditionByDigit(T( 0), Int( 0), T( 0))
        ANKAssertAdditionByDigit(T( 0), Int(-1), T(-1))
        ANKAssertAdditionByDigit(T( 0), Int(-2), T(-2))
        
        ANKAssertAdditionByDigit(T(-1), Int( 2), T( 1))
        ANKAssertAdditionByDigit(T(-1), Int( 1), T( 0))
        ANKAssertAdditionByDigit(T(-1), Int( 0), T(-1))
        ANKAssertAdditionByDigit(T(-1), Int(-1), T(-2))
        ANKAssertAdditionByDigit(T(-1), Int(-2), T(-3))
    }
    
    func testAddingDigitUsingLargeValues() {
        ANKAssertAdditionByDigit(T(x64: X(~0, ~0, ~0,  0)),  Int(3), T(x64: X( 2,  0,  0,  1)))
        ANKAssertAdditionByDigit(T(x64: X(~0, ~0, ~0,  0)), -Int(3), T(x64: X(~3, ~0, ~0,  0)))
        ANKAssertAdditionByDigit(T(x64: X( 0,  0,  0, ~0)),  Int(3), T(x64: X( 3,  0,  0, ~0)))
        ANKAssertAdditionByDigit(T(x64: X( 0,  0,  0, ~0)), -Int(3), T(x64: X(~2, ~0, ~0, ~1)))
    }
    
    func testAddingDigitReportingOverflow() {
        ANKAssertAdditionByDigit(T.min, Int( 1), T.min + T(1))
        ANKAssertAdditionByDigit(T.min, Int(-1), T.max,  true)
        ANKAssertAdditionByDigit(T.max, Int( 1), T.min,  true)
        ANKAssertAdditionByDigit(T.max, Int(-1), T.max - T(1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  += 0)
            XCTAssertNotNil(x &+= 0)
            XCTAssertNotNil(x.addReportingOverflow(0))
            
            XCTAssertNotNil(x  +  0)
            XCTAssertNotNil(x &+  0)
            XCTAssertNotNil(x.addingReportingOverflow(0))
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Addition
//*============================================================================*

final class UInt256TestsOnAddition: XCTestCase {

    typealias T = UInt256

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=

    func testAdding() {
        ANKAssertAddition(T(0), T(0), T(0))
        ANKAssertAddition(T(0), T(1), T(1))
        ANKAssertAddition(T(0), T(2), T(2))
        
        ANKAssertAddition(T(1), T(0), T(1))
        ANKAssertAddition(T(1), T(1), T(2))
        ANKAssertAddition(T(1), T(2), T(3))
    }
    
    func testAddingUsingLargeValues() {
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), T(x64: X(3, 0, 0, 0)), T(x64: X( 2,  0,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), T(x64: X(0, 3, 0, 0)), T(x64: X(~0,  2,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0,  2,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0, ~0,  0)), T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0,  3)))
    }
    
    func testAddingReportingOverflow() {
        ANKAssertAddition(T.min, T(1), T.min + T(1))
        ANKAssertAddition(T.max, T(1), T.min,  true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=

    func testAddingDigit() {
        ANKAssertAdditionByDigit(T(0), UInt(0), T(0))
        ANKAssertAdditionByDigit(T(0), UInt(1), T(1))
        ANKAssertAdditionByDigit(T(0), UInt(2), T(2))
        
        ANKAssertAdditionByDigit(T(1), UInt(0), T(1))
        ANKAssertAdditionByDigit(T(1), UInt(1), T(2))
        ANKAssertAdditionByDigit(T(1), UInt(2), T(3))
    }
    
    func testAddingDigitUsingLargeValues() {
        ANKAssertAdditionByDigit(T(x64: X( 0,  0,  0,  0)), UInt(3), T(x64: X(3, 0, 0, 0)))
        ANKAssertAdditionByDigit(T(x64: X(~0,  0,  0,  0)), UInt(3), T(x64: X(2, 1, 0, 0)))
        ANKAssertAdditionByDigit(T(x64: X(~0, ~0,  0,  0)), UInt(3), T(x64: X(2, 0, 1, 0)))
        ANKAssertAdditionByDigit(T(x64: X(~0, ~0, ~0,  0)), UInt(3), T(x64: X(2, 0, 0, 1)))
    }
    
    func testAddingDigitReportingOverflow() {
        ANKAssertAdditionByDigit(T.min, UInt(1), T.min + T(1))
        ANKAssertAdditionByDigit(T.max, UInt(1), T.min,  true)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        func becauseThisCompilesSuccessfully(_ x: inout T) {
            XCTAssertNotNil(x  += 0)
            XCTAssertNotNil(x &+= 0)
            XCTAssertNotNil(x.addReportingOverflow(0))
            
            XCTAssertNotNil(x  +  0)
            XCTAssertNotNil(x &+  0)
            XCTAssertNotNil(x.addingReportingOverflow(0))
        }
    }
}

#endif
