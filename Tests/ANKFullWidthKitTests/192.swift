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
// MARK: * Int192
//*============================================================================*

final class Int192Tests: XCTestCase {
    
    typealias T =  ANKInt192
    typealias M = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(x64: X(0, 0, 0)), T())
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1)), T(1) << 128)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1)), T(1) << 160)
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
        XCTAssertEqual(T(ascending:  (T.Low(x64:(1, 2)), T.High(3))), T(x64: X(1, 2, 3)))
    }

    func testInitDescending() {
        XCTAssertEqual(T(descending: (T.High(3), T.Low(x64:(1, 2)))), T(x64: X(1, 2, 3)))
    }
}

//*============================================================================*
// MARK: * UInt192
//*============================================================================*

final class UInt192Tests: XCTestCase {
    
    typealias T = ANKUInt192
    typealias M = ANKUInt192

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInit() {
        XCTAssertEqual(T(x64: X(0, 0, 0)), T())
    }
    
    func testInitX64() {
        XCTAssertEqual(T(x64: X(1, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x64: X(0, 1, 0)), T(1) <<  64)
        XCTAssertEqual(T(x64: X(0, 0, 1)), T(1) << 128)
    }
    
    func testInitX32() {
        XCTAssertEqual(T(x32: Y(1, 0, 0, 0, 0, 0)), T(1) <<   0)
        XCTAssertEqual(T(x32: Y(0, 1, 0, 0, 0, 0)), T(1) <<  32)
        XCTAssertEqual(T(x32: Y(0, 0, 1, 0, 0, 0)), T(1) <<  64)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 1, 0, 0)), T(1) <<  96)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 1, 0)), T(1) << 128)
        XCTAssertEqual(T(x32: Y(0, 0, 0, 0, 0, 1)), T(1) << 160)
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
        XCTAssertEqual(T(ascending:  (T.Low(x64:(1, 2)), T.High(3))), T(x64: X(1, 2, 3)))
    }

    func testInitDescending() {
        XCTAssertEqual(T(descending: (T.High(3), T.Low(x64:(1, 2)))), T(x64: X(1, 2, 3)))
    }
}

#endif
