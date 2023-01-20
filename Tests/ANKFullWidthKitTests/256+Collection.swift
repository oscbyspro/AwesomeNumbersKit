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

//*============================================================================*
// MARK: * Int256 x Collection
//*============================================================================*

final class Int256TestsOnCollection: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Contiguous Bytes
    //=------------------------------------------------------------------------=

    func testWithUnsafeBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeBytes { BYTES in
            XCTAssert(BYTES.allSatisfy({ $0 == 0x00 }))
            XCTAssertEqual(BYTES.count,  x0.bitWidth/8)
        }
        
        x1.withUnsafeBytes { BYTES in
            XCTAssert(BYTES.allSatisfy({ $0 == 0xff }))
            XCTAssertEqual(BYTES.count,  x1.bitWidth/8)
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Collection
//*============================================================================*

final class UInt256TestsOnCollection: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Contiguous Bytes
    //=------------------------------------------------------------------------=

    func testWithUnsafeBytes() {
        let x0 = T(truncatingIfNeeded:  0)
        let x1 = T(truncatingIfNeeded: -1)
        
        x0.withUnsafeBytes { BYTES in
            XCTAssert(BYTES.allSatisfy({ $0 == 0x00 }))
            XCTAssertEqual(BYTES.count,  x0.bitWidth/8)
        }
        
        x1.withUnsafeBytes { BYTES in
            XCTAssert(BYTES.allSatisfy({ $0 == 0xff }))
            XCTAssertEqual(BYTES.count,  x1.bitWidth/8)
        }
    }
}

#endif
