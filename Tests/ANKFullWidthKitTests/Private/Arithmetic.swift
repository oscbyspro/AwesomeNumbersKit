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
@testable import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * ANK x Arithmetic x Int or UInt
//*============================================================================*

final class ArithmeticTestsOnIntOrUInt: XCTestCase {
    
    typealias T = UInt
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let bitWidth = T(T.bitWidth)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDividingByBitWidth() {
        ANKAssertDividingByBitWidthAsIntOrUInt(T(0) * bitWidth + T(0), T(0), T(0))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(0) * bitWidth + T(1), T(0), T(1))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(0) * bitWidth + T(2), T(0), T(2))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(0) * bitWidth + T(3), T(0), T(3))
        
        ANKAssertDividingByBitWidthAsIntOrUInt(T(1) * bitWidth + T(0), T(1), T(0))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(1) * bitWidth + T(1), T(1), T(1))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(1) * bitWidth + T(2), T(1), T(2))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(1) * bitWidth + T(3), T(1), T(3))
        
        ANKAssertDividingByBitWidthAsIntOrUInt(T(2) * bitWidth + T(0), T(2), T(0))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(2) * bitWidth + T(1), T(2), T(1))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(2) * bitWidth + T(2), T(2), T(2))
        ANKAssertDividingByBitWidthAsIntOrUInt(T(2) * bitWidth + T(3), T(2), T(3))
        
        ANKAssertDividingByBitWidthAsIntOrUInt(T.min, T.min / bitWidth, T.min % bitWidth)
        ANKAssertDividingByBitWidthAsIntOrUInt(T.max, T.max / bitWidth, T.max % bitWidth)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities
//=----------------------------------------------------------------------------=

private func ANKAssertDividingByBitWidthAsIntOrUInt(
_ value: UInt, _ quotient: UInt, _ remainder: UInt,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    XCTAssertEqual(value .quotientDividingByBitWidth(), quotient,  file: file, line: line)
    XCTAssertEqual(value.remainderDividingByBitWidth(), remainder, file: file, line: line)
    //=------------------------------------------=
    if  let value = Int(exactly: value), let quotient = Int(exactly: quotient), let remainder = Int(exactly: remainder) {
        XCTAssertEqual(value .quotientDividingByBitWidthAssumingIsAtLeastZero(), quotient,  file: file, line: line)
        XCTAssertEqual(value.remainderDividingByBitWidthAssumingIsAtLeastZero(), remainder, file: file, line: line)
    }
}

//*============================================================================*
// MARK: * ANK x Arithmetic x Binary Integer
//*============================================================================*

final class ArithmeticTestsOnBinaryInteger: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Modulo
    //=------------------------------------------------------------------------=
    
    func testModuloPowerOf2() {
        XCTAssertEqual( Int8.min.modulo(8), 0)
        XCTAssertEqual( Int8.max.modulo(8), 7)
        
        XCTAssertEqual(UInt8.min.modulo(8), 0)
        XCTAssertEqual(UInt8.max.modulo(8), 7)
        
        XCTAssertEqual( Int8(-4).modulo(4), 0)
        XCTAssertEqual( Int8(-3).modulo(4), 1)
        XCTAssertEqual( Int8(-2).modulo(4), 2)
        XCTAssertEqual( Int8(-1).modulo(4), 3)
        XCTAssertEqual( Int8( 0).modulo(4), 0)
        XCTAssertEqual( Int8( 1).modulo(4), 1)
        XCTAssertEqual( Int8( 2).modulo(4), 2)
        XCTAssertEqual( Int8( 3).modulo(4), 3)
        XCTAssertEqual( Int8( 4).modulo(4), 0)
        
        XCTAssertEqual(UInt8( 0).modulo(4), 0)
        XCTAssertEqual(UInt8( 1).modulo(4), 1)
        XCTAssertEqual(UInt8( 2).modulo(4), 2)
        XCTAssertEqual(UInt8( 3).modulo(4), 3)
        XCTAssertEqual(UInt8( 4).modulo(4), 0)
        XCTAssertEqual(UInt8( 5).modulo(4), 1)
        XCTAssertEqual(UInt8( 6).modulo(4), 2)
        XCTAssertEqual(UInt8( 7).modulo(4), 3)
        XCTAssertEqual(UInt8( 8).modulo(4), 0)
    }
    
    func testModuloNonPowerOf2() {
        XCTAssertEqual( Int8.min.modulo(7), 5)
        XCTAssertEqual( Int8.max.modulo(7), 1)
        
        XCTAssertEqual(UInt8.min.modulo(7), 0)
        XCTAssertEqual(UInt8.max.modulo(7), 3)
        
        XCTAssertEqual( Int8(-3).modulo(3), 0)
        XCTAssertEqual( Int8(-2).modulo(3), 1)
        XCTAssertEqual( Int8(-1).modulo(3), 2)
        XCTAssertEqual( Int8( 0).modulo(3), 0)
        XCTAssertEqual( Int8( 1).modulo(3), 1)
        XCTAssertEqual( Int8( 2).modulo(3), 2)
        XCTAssertEqual( Int8( 3).modulo(3), 0)
        
        XCTAssertEqual(UInt8( 0).modulo(3), 0)
        XCTAssertEqual(UInt8( 1).modulo(3), 1)
        XCTAssertEqual(UInt8( 2).modulo(3), 2)
        XCTAssertEqual(UInt8( 3).modulo(3), 0)
        XCTAssertEqual(UInt8( 4).modulo(3), 1)
        XCTAssertEqual(UInt8( 5).modulo(3), 2)
        XCTAssertEqual(UInt8( 6).modulo(3), 0)
    }
}

#endif
