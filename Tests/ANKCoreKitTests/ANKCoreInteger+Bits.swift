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
import XCTest

//*============================================================================*
// MARK: * ANK x Core Integer x Bits
//*============================================================================*

final class ANKCoreIntegerTestsOnBits: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testInitBit() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(bit: false), T( ))
            XCTAssertEqual(T(bit: true ), T(1))
        }
        
        for type in types {
            whereIs(type)
        }
    }
    
    func testInitRepeatingBit() {
        func whereIs<T>(_ type: T.Type) where T: ANKCoreInteger {
            XCTAssertEqual(T(repeating: false),  T( ))
            XCTAssertEqual(T(repeating: true ), ~T( ))
        }
        
        for type in types {
            whereIs(type)
        }
    }
    
    func testMostSignificantBit() {
        for type: T in types {
            XCTAssertEqual(type.min .mostSignificantBit,  type.isSigned)
            XCTAssertEqual(type.zero.mostSignificantBit,  false)
            XCTAssertEqual(type.max .mostSignificantBit, !type.isSigned)
        }
    }
    
    func testLeastSignificantBit() {
        for type: T in types {
            XCTAssertEqual(type.min .leastSignificantBit, false)
            XCTAssertEqual(type.zero.leastSignificantBit, false)
            XCTAssertEqual(type.max .leastSignificantBit, true )
        }
    }
}

#endif
