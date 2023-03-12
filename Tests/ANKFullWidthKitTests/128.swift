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

private typealias X = ANK128X64
private typealias Y = ANK128X32

//*============================================================================*
// MARK: * Int128
//*============================================================================*

final class Int128Tests: XCTestCase {
    
    typealias T =  ANKInt128
    typealias M = ANKUInt128
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(x64: X(0, 0)), T())
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1)), T(1) <<  64)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1)), T(1) <<  96)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        XCTAssertEqual(T.min,  (T(1) << (T.bitWidth - 1)))
    }
    
    func testInitMax() {
        XCTAssertEqual(T.max, ~(T(1) << (T.bitWidth - 1)))
    }
    
    func testInitZero() {
        XCTAssertEqual(T.zero,  T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        XCTAssertEqual(T(ascending:  (T.Low(1), T.High(2))), T(x64: X(1, 2)))
    }

    func testInitDescending() {
        XCTAssertEqual(T(descending: (T.High(2), T.Low(1))), T(x64: X(1, 2)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        XCTAssertEqual(T(bitPattern: M.min), T(  ))
        XCTAssertEqual(T(bitPattern: M.max), T(-1))
        
        XCTAssertEqual(T(bitPattern:  (M(1) << (M.bitWidth - 1))), T.min)
        XCTAssertEqual(T(bitPattern: ~(M(1) << (M.bitWidth - 1))), T.max)
    }
    
    func testValueAsBitPattern() {
        XCTAssertEqual(T(  ).bitPattern, M.min)
        XCTAssertEqual(T(-1).bitPattern, M.max)
        
        XCTAssertEqual(T.min.bitPattern,  (M(1) << (M.bitWidth - 1)))
        XCTAssertEqual(T.max.bitPattern, ~(M(1) << (M.bitWidth - 1)))
    }
}

//*============================================================================*
// MARK: * UInt128
//*============================================================================*

final class UInt128Tests: XCTestCase {
    
    typealias T = ANKUInt128
    typealias M = ANKUInt128

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(x64: X(0, 0)), T())
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1)), T(1) <<  64)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1)), T(1) <<  96)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Constants
    //=------------------------------------------------------------------------=
    
    func testInitMin() {
        XCTAssertEqual(T.min,  T( ))
    }
    
    func testInitMax() {
        XCTAssertEqual(T.max, ~T( ))
    }
    
    func testInitZero() {
        XCTAssertEqual(T.zero, T( ))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Components
    //=------------------------------------------------------------------------=
    
    func testInitAscending() {
        XCTAssertEqual(T(ascending:  (T.Low(1), T.High(2))), T(x64: X(1, 2)))
    }
    
    func testInitDescending() {
        XCTAssertEqual(T(descending: (T.High(2), T.Low(1))), T(x64: X(1, 2)))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit Pattern
    //=------------------------------------------------------------------------=
    
    func testInitBitPattern() {
        XCTAssertEqual(T(bitPattern: M.min), T.min)
        XCTAssertEqual(T(bitPattern: M.max), T.max)
    }
    
    func testValueAsBitPattern() {
        XCTAssertEqual(T.min.bitPattern, M.min)
        XCTAssertEqual(T.max.bitPattern, M.max)
    }
}

#endif
