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
// MARK: * Types x Contiguous Bytes x Mutable
//*============================================================================*

final class TypesTestsOnANKMutableContiguousBytes: XCTestCase {
    
    typealias T = any (ANKBinaryInteger & ANKMutableContiguousBytes).Type
    typealias S = any (ANKSignedInteger & ANKMutableContiguousBytes).Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = Types.ANKMutableContiguousBytes
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testTypesCount() {
        XCTAssertEqual(types.count, 10)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWithUnsafeMutableBytes() {
        for type: T in types {
            var x0 = type.init(truncatingIfNeeded:  0)
            let x1 = type.init(truncatingIfNeeded: -1)
            //=----------------------------------=
            x0.withUnsafeMutableBytes { BYTES in
                XCTAssertEqual(BYTES.count,  x1.bitWidth/8)
                XCTAssert(BYTES.allSatisfy({ $0  == 0x00 }))
                BYTES.indices.forEach({ BYTES[$0] = 0xff })
                XCTAssert(BYTES.allSatisfy({ $0  == 0xff }))
            }
            //=----------------------------------=
            let lhs = x0.words.map({ $0 as! UInt })
            let rhs = x1.words.map({ $0 as! UInt })
            XCTAssertEqual(lhs, rhs)
        }
    }
}

#endif
