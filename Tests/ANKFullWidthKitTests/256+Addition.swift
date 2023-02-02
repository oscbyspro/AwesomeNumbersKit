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
// MARK: * Int256 x Addition
//*============================================================================*

final class Int256TestsOnAddition: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testAdding() {
        XCTAssertEqual(T( 1) + T(-2), T(-1))
        XCTAssertEqual(T( 1) + T(-1), T( 0))
        XCTAssertEqual(T( 1) + T( 0), T( 1))
        XCTAssertEqual(T( 1) + T( 1), T( 2))
        XCTAssertEqual(T( 1) + T( 2), T( 3))
        
        XCTAssertEqual(T( 0) + T(-2), T(-2))
        XCTAssertEqual(T( 0) + T(-1), T(-1))
        XCTAssertEqual(T( 0) + T( 0), T( 0))
        XCTAssertEqual(T( 0) + T( 1), T( 1))
        XCTAssertEqual(T( 0) + T( 2), T( 2))

        XCTAssertEqual(T(-1) + T(-2), T(-3))
        XCTAssertEqual(T(-1) + T(-1), T(-2))
        XCTAssertEqual(T(-1) + T( 0), T(-1))
        XCTAssertEqual(T(-1) + T( 1), T( 0))
        XCTAssertEqual(T(-1) + T( 2), T( 1))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) +  T(x64: X(3, 0, 0, 0)), T(x64: X( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) +  T(x64: X(0, 3, 0, 0)), T(x64: X(~0,  2,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) +  T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0,  2,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) +  T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0,  3)))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + -T(x64: X(3, 0, 0, 0)), T(x64: X(~3, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + -T(x64: X(0, 3, 0, 0)), T(x64: X(~0, ~3, ~0,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + -T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0, ~3,  0)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + -T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0, ~2)))
        
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) +  T(x64: X(3, 0, 0, 0)), T(x64: X( 3,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) +  T(x64: X(0, 3, 0, 0)), T(x64: X( 0,  3,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) +  T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0,  3, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) +  T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0,  2)))
        
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) + -T(x64: X(3, 0, 0, 0)), T(x64: X(~2, ~0, ~0, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) + -T(x64: X(0, 3, 0, 0)), T(x64: X( 0, ~2, ~0, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) + -T(x64: X(0, 0, 3, 0)), T(x64: X( 0,  0, ~2, ~1)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) + -T(x64: X(0, 0, 0, 3)), T(x64: X( 0,  0,  0, ~3)))
    }
    
    func testAddingWrappingAround() {
        XCTAssertEqual(T.min &+ T( 1), T.min + T(1))
        XCTAssertEqual(T.max &+ T( 1), T.min)

        XCTAssertEqual(T.min &+ T(-1), T.max)
        XCTAssertEqual(T.max &+ T(-1), T.max - T(1))
    }
    
    func testAddingReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(T( 1)) == (T.min + 1, false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(T( 1)) == (T.min,     true ) as (T, Bool))

        XCTAssert(T.min.addingReportingOverflow(T(-1)) == (T.max,     true ) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(T(-1)) == (T.max - 1, false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=
    
    func testAddingDigit() {
        XCTAssertEqual(T( 1) + Int(-2), T(-1))
        XCTAssertEqual(T( 1) + Int(-1), T( 0))
        XCTAssertEqual(T( 1) + Int( 0), T( 1))
        XCTAssertEqual(T( 1) + Int( 1), T( 2))
        XCTAssertEqual(T( 1) + Int( 2), T( 3))
        
        XCTAssertEqual(T( 0) + Int(-2), T(-2))
        XCTAssertEqual(T( 0) + Int(-1), T(-1))
        XCTAssertEqual(T( 0) + Int( 0), T( 0))
        XCTAssertEqual(T( 0) + Int( 1), T( 1))
        XCTAssertEqual(T( 0) + Int( 2), T( 2))

        XCTAssertEqual(T(-1) + Int(-2), T(-3))
        XCTAssertEqual(T(-1) + Int(-1), T(-2))
        XCTAssertEqual(T(-1) + Int( 0), T(-1))
        XCTAssertEqual(T(-1) + Int( 1), T( 0))
        XCTAssertEqual(T(-1) + Int( 2), T( 1))
        
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) +  Int(3), T(x64: X( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + -Int(3), T(x64: X(~3, ~0, ~0,  0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) +  Int(3), T(x64: X( 3,  0,  0, ~0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0, ~0)) + -Int(3), T(x64: X(~2, ~0, ~0, ~1)))
    }
    
    func testAddingDigitWrappingAround() {
        XCTAssertEqual(T.min &+ Int( 1), T.min + T(1))
        XCTAssertEqual(T.max &+ Int( 1), T.min)

        XCTAssertEqual(T.min &+ Int(-1), T.max)
        XCTAssertEqual(T.max &+ Int(-1), T.max - T(1))
    }
    
    func testAddingDigitReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(Int( 1)) == (T.min + 1, false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(Int( 1)) == (T.min,     true ) as (T, Bool))

        XCTAssert(T.min.addingReportingOverflow(Int(-1)) == (T.max,     true ) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(Int(-1)) == (T.max - 1, false) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        var x = T()
        
        XCTAssertNotNil(x  += 0)
        XCTAssertNotNil(x &+= 0)
        XCTAssertNotNil(x.addReportingOverflow(0))
        
        XCTAssertNotNil(x  +  0)
        XCTAssertNotNil(x &+  0)
        XCTAssertNotNil(x.addingReportingOverflow(0))
    }
}

//*============================================================================*
// MARK: * UInt256 x Addition
//*============================================================================*

final class UInt256TestsOnAddition: XCTestCase {

    typealias T = ANKUInt256

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=

    func testAdding() {
        XCTAssertEqual(T(0) + T(0), T(0))
        XCTAssertEqual(T(0) + T(1), T(1))
        XCTAssertEqual(T(0) + T(2), T(2))

        XCTAssertEqual(T(1) + T(0), T(1))
        XCTAssertEqual(T(1) + T(1), T(2))
        XCTAssertEqual(T(1) + T(2), T(3))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + T(x64: X(3, 0, 0, 0)), T(x64: X( 2,  0,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + T(x64: X(0, 3, 0, 0)), T(x64: X(~0,  2,  0,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + T(x64: X(0, 0, 3, 0)), T(x64: X(~0, ~0,  2,  1)))
        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + T(x64: X(0, 0, 0, 3)), T(x64: X(~0, ~0, ~0,  3)))
    }

    func testAddingWrappingAround() {
        XCTAssertEqual(T.min &+ T(1), T.min + T(1))
        XCTAssertEqual(T.max &+ T(1), T.min)
    }

    func testAddingReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(T(1)) == (T.min + (1 as UInt), false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(T(1)) == (T.min,               true ) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Digit
    //=------------------------------------------------------------------------=

    func testAddingDigit() {
        XCTAssertEqual(T(0) + UInt(0), T(0))
        XCTAssertEqual(T(0) + UInt(1), T(1))
        XCTAssertEqual(T(0) + UInt(2), T(2))

        XCTAssertEqual(T(1) + UInt(0), T(1))
        XCTAssertEqual(T(1) + UInt(1), T(2))
        XCTAssertEqual(T(1) + UInt(2), T(3))

        XCTAssertEqual(T(x64: X(~0, ~0, ~0,  0)) + UInt(3), T(x64: X(2, 0, 0, 1)))
        XCTAssertEqual(T(x64: X(~0, ~0,  0,  0)) + UInt(3), T(x64: X(2, 0, 1, 0)))
        XCTAssertEqual(T(x64: X(~0,  0,  0,  0)) + UInt(3), T(x64: X(2, 1, 0, 0)))
        XCTAssertEqual(T(x64: X( 0,  0,  0,  0)) + UInt(3), T(x64: X(3, 0, 0, 0)))
    }

    func testAddingDigitWrappingAround() {
        XCTAssertEqual(T.min &+ UInt(1), T.min + T(1))
        XCTAssertEqual(T.max &+ UInt(1), T.min)
    }

    func testAddingDigitReportingOverflow() {
        XCTAssert(T.min.addingReportingOverflow(UInt(1)) == (T.min + (1 as UInt), false) as (T, Bool))
        XCTAssert(T.max.addingReportingOverflow(UInt(1)) == (T.min,               true ) as (T, Bool))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Miscellaneous
    //=------------------------------------------------------------------------=
    
    func testOverloadsAreUnambiguousWhenUsingIntegerLiterals() {
        var x = T()
        
        XCTAssertNotNil(x  += 0)
        XCTAssertNotNil(x &+= 0)
        XCTAssertNotNil(x.addReportingOverflow(0))
        
        XCTAssertNotNil(x  +  0)
        XCTAssertNotNil(x &+  0)
        XCTAssertNotNil(x.addingReportingOverflow(0))
    }
}

#endif
