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
    
    #warning("TODO")
    func testTrailingZeroBitCount() {
        
    }
    
    #warning("TODO")
    func testMostSignificantBit() {
        
    }
    
    #warning("TODO")
    func testLeastSignificantBit() {
        
    }
}

#endif
