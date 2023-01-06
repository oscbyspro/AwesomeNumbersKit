//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * Signed x Words
//*============================================================================*

final class SignedTestsOnWords: XCTestCase {
    
    typealias T = Signed<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testBitWidth() {
        XCTAssertEqual(T/**/.bitWidth, UInt.bitWidth + 1)
        XCTAssertEqual(T(  ).bitWidth, UInt.bitWidth + 1)
        XCTAssertEqual(T.min.bitWidth, UInt.bitWidth + 1)
        XCTAssertEqual(T.max.bitWidth, UInt.bitWidth + 1)
    }
    
    #warning("TODO")
    func testNonzeroBitCount() {
        
    }
    
    #warning("TODO")
    func testLeadingZeroBitCount() {
        
    }
    
    func testTrailingZeroBitCount() {
        XCTAssertEqual((-T(2)).trailingZeroBitCount, 1)
        XCTAssertEqual((-T(1)).trailingZeroBitCount, 0)
        XCTAssertEqual((-T(0)).trailingZeroBitCount, T.bitWidth)
        XCTAssertEqual(( T(0)).trailingZeroBitCount, T.bitWidth)
        XCTAssertEqual(( T(1)).trailingZeroBitCount, 0)
        XCTAssertEqual(( T(2)).trailingZeroBitCount, 1)
    }
    
    func testMostSignificantBit() {
        XCTAssertEqual((-T(2)).mostSignificantBit, true )
        XCTAssertEqual((-T(1)).mostSignificantBit, true )
        XCTAssertEqual((-T(0)).mostSignificantBit, false)
        XCTAssertEqual(( T(0)).mostSignificantBit, false)
        XCTAssertEqual(( T(1)).mostSignificantBit, false)
        XCTAssertEqual(( T(2)).mostSignificantBit, false)
    }
    
    func testLeastSignificantBit() {
        XCTAssertEqual((-T(2)).leastSignificantBit, false)
        XCTAssertEqual((-T(1)).leastSignificantBit, true )
        XCTAssertEqual((-T(0)).leastSignificantBit, false)
        XCTAssertEqual(( T(0)).leastSignificantBit, false)
        XCTAssertEqual(( T(1)).leastSignificantBit, true )
        XCTAssertEqual(( T(2)).leastSignificantBit, false)
    }
}

#endif
