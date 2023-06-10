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
// MARK: * Int192 x Bits
//*============================================================================*

final class Int192TestsOnBits: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    func testBitWidth() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64: X( 1,  1,  1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leastSignificantBit, true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
    }
}

//*============================================================================*
// MARK: * UInt192 x Bits
//*============================================================================*

final class UInt192TestsOnBits: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        XCTAssertEqual(T(bit: false), T( ))
        XCTAssertEqual(T(bit: true ), T(1))
    }
    
    func testInitRepeatingBit() {
        XCTAssertEqual(T(repeating: false),  T( ))
        XCTAssertEqual(T(repeating: true ), ~T( ))
    }
    
    func testBitWidth() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).bitWidth, 64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).bitWidth, 64 * 3)
    }
    
    func testNonzeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).nonzeroBitCount, 0)
        XCTAssertEqual(T(x64: X( 1,  1,  1)).nonzeroBitCount, 3)
    }
    
    func testLeadingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).leadingZeroBitCount,  64 * 3 - 2)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).leadingZeroBitCount,  64 * 2 - 2)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).leadingZeroBitCount,  64 * 1 - 2)
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leadingZeroBitCount,  64 * 3)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leadingZeroBitCount,  64 * 0)
        
        XCTAssertEqual(T(x64: X( 2,  0,  0)).trailingZeroBitCount, 64 * 0 + 1)
        XCTAssertEqual(T(x64: X( 0,  2,  0)).trailingZeroBitCount, 64 * 1 + 1)
        XCTAssertEqual(T(x64: X( 0,  0,  2)).trailingZeroBitCount, 64 * 2 + 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).mostSignificantBit,  true )

        XCTAssertEqual(T(x64: X(~0,  0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).mostSignificantBit,  false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).mostSignificantBit,  true )
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual(T(x64: X( 0,  0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X(~0, ~0, ~0)).leastSignificantBit, true )
        
        XCTAssertEqual(T(x64: X(~0,  0,  0)).leastSignificantBit, true )
        XCTAssertEqual(T(x64: X( 0, ~0,  0)).leastSignificantBit, false)
        XCTAssertEqual(T(x64: X( 0,  0, ~0)).leastSignificantBit, false)
    }
}

#endif
