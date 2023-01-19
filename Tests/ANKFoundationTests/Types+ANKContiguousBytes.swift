//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * Types x Contiguous Bytes
//*============================================================================*

final class TypesTestsOnANKContiguousBytes: XCTestCase {
    
    typealias T = any (ANKBinaryInteger & ANKContiguousBytes).Type
    typealias S = any (ANKSignedInteger & ANKContiguousBytes).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types = Trivial.allContiguousBytesTypes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 10)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeBytes() {
        for type: T in types {
            let x0 = type.init(truncatingIfNeeded:  0)
            let x1 = type.init(truncatingIfNeeded: -1)
            
            x0.withUnsafeBytes { BYTES in
                XCTAssert(BYTES.allSatisfy({ $0 == 0x00 }))
                XCTAssertEqual(BYTES.count,  x0.bitWidth/8)
            }
            
            x1.withUnsafeBytes { BYTES in
                XCTAssert(BYTES.allSatisfy({ $0 == 0xFF }))
                XCTAssertEqual(BYTES.count,  x1.bitWidth/8)
            }
        }
    }
}

#endif
