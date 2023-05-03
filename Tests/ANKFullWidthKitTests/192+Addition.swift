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
// MARK: * Int192 x Addition
//*============================================================================*

final class Int192TestsOnAddition: XCTestCase {
    
    typealias T = ANKInt192
    
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
        ANKAssertAddition(T(x64: X(~0, ~0,  0)),  T(x64: X(3, 0, 0)), T(x64: X( 2,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0,  0)),  T(x64: X(0, 3, 0)), T(x64: X(~0,  2,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0,  0)),  T(x64: X(0, 0, 3)), T(x64: X(~0, ~0,  3)))
        
        ANKAssertAddition(T(x64: X(~0, ~0,  0)), -T(x64: X(3, 0, 0)), T(x64: X(~3, ~0,  0)))
        ANKAssertAddition(T(x64: X(~0, ~0,  0)), -T(x64: X(0, 3, 0)), T(x64: X(~0, ~3,  0)))
        ANKAssertAddition(T(x64: X(~0, ~0,  0)), -T(x64: X(0, 0, 3)), T(x64: X(~0, ~0, ~2)))
        
        ANKAssertAddition(T(x64: X( 0,  0, ~0)),  T(x64: X(3, 0, 0)), T(x64: X( 3,  0, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)),  T(x64: X(0, 3, 0)), T(x64: X( 0,  3, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)),  T(x64: X(0, 0, 3)), T(x64: X( 0,  0,  2)))
        
        ANKAssertAddition(T(x64: X( 0,  0, ~0)), -T(x64: X(3, 0, 0)), T(x64: X(~2, ~0, ~1)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)), -T(x64: X(0, 3, 0)), T(x64: X( 0, ~2, ~1)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)), -T(x64: X(0, 0, 3)), T(x64: X( 0,  0, ~3)))
    }
    
    func testAddingAtEdges() {
        ANKAssertAddition(T.min, T( 1), T.min + T(1))
        ANKAssertAddition(T.min, T(-1), T.max,  true)
        
        ANKAssertAddition(T.max, T( 1), T.min,  true)
        ANKAssertAddition(T.max, T(-1), T.max - T(1))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        ANKAssertAddition(T( 1), Int( 2), T( 3))
        ANKAssertAddition(T( 1), Int( 1), T( 2))
        ANKAssertAddition(T( 1), Int( 0), T( 1))
        ANKAssertAddition(T( 1), Int(-1), T( 0))
        ANKAssertAddition(T( 1), Int(-2), T(-1))
        
        ANKAssertAddition(T( 0), Int( 2), T( 2))
        ANKAssertAddition(T( 0), Int( 1), T( 1))
        ANKAssertAddition(T( 0), Int( 0), T( 0))
        ANKAssertAddition(T( 0), Int(-1), T(-1))
        ANKAssertAddition(T( 0), Int(-2), T(-2))
        
        ANKAssertAddition(T(-1), Int( 2), T( 1))
        ANKAssertAddition(T(-1), Int( 1), T( 0))
        ANKAssertAddition(T(-1), Int( 0), T(-1))
        ANKAssertAddition(T(-1), Int(-1), T(-2))
        ANKAssertAddition(T(-1), Int(-2), T(-3))
    }
    
    func testAddingDigitUsingLargeValues() {
        ANKAssertAddition(T(x64: X(~0, ~0,  0)),  Int(3), T(x64: X( 2,  0,  1)))
        ANKAssertAddition(T(x64: X(~0, ~0,  0)), -Int(3), T(x64: X(~3, ~0,  0)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)),  Int(3), T(x64: X( 3,  0, ~0)))
        ANKAssertAddition(T(x64: X( 0,  0, ~0)), -Int(3), T(x64: X(~2, ~0, ~1)))
    }
    
    func testAddingDigitAtEdges() {
        ANKAssertAddition(T.min, Int( 1), T.min + T(1))
        ANKAssertAddition(T.min, Int(-1), T.max,  true)
        
        ANKAssertAddition(T.max, Int( 1), T.min,  true)
        ANKAssertAddition(T.max, Int(-1), T.max - T(1))
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
// MARK: * UInt192 x Addition
//*============================================================================*

final class UInt192TestsOnAddition: XCTestCase {

    typealias T = ANKUInt192
    
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
        ANKAssertAddition(T(x64: X(~0, ~0, 0)), T(x64: X(3, 0, 0)), T(x64: X( 2,  0, 1)))
        ANKAssertAddition(T(x64: X(~0, ~0, 0)), T(x64: X(0, 3, 0)), T(x64: X(~0,  2, 1)))
        ANKAssertAddition(T(x64: X(~0, ~0, 0)), T(x64: X(0, 0, 3)), T(x64: X(~0, ~0, 3)))
    }
    
    func testAddingAtEdges() {
        ANKAssertAddition(T.min, T(1), T.min + T(1))
        ANKAssertAddition(T.max, T(1), T.min,  true)
    }

    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=

    func testAddingDigit() {
        ANKAssertAddition(T(0), UInt(0), T(0))
        ANKAssertAddition(T(0), UInt(1), T(1))
        ANKAssertAddition(T(0), UInt(2), T(2))
        
        ANKAssertAddition(T(1), UInt(0), T(1))
        ANKAssertAddition(T(1), UInt(1), T(2))
        ANKAssertAddition(T(1), UInt(2), T(3))
    }
    
    func testAddingDigitUsingLargeValues() {
        ANKAssertAddition(T(x64: X(~0, ~0, 0)), UInt(3), T(x64: X(2, 0, 1)))
        ANKAssertAddition(T(x64: X(~0,  0, 0)), UInt(3), T(x64: X(2, 1, 0)))
        ANKAssertAddition(T(x64: X( 0,  0, 0)), UInt(3), T(x64: X(3, 0, 0)))
    }
    
    func testAddingDigitAtEdges() {
        ANKAssertAddition(T.min, UInt(1), T.min + T(1))
        ANKAssertAddition(T.max, UInt(1), T.min,  true)
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
