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
// MARK: * ANK x Core Integer
//*============================================================================*

final class ANKCoreIntegerTests: XCTestCase {
    
    typealias T = any ANKCoreInteger.Type
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    static let types: [T] =
    [Int.self,  Int8.self,  Int16.self,  Int32.self,  Int64.self,
    UInt.self, UInt8.self, UInt16.self, UInt32.self, UInt64.self]
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKCoreIntegerTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testANKBigEndianTextCodable() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKBigEndianTextCodable.Type }).count)
    }
    
    func testANKBinaryInteger() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKBinaryInteger.Type }).count)
    }
    
    func testANKBitPatternConvertible() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKBitPatternConvertible.Type }).count)
    }
    
    func testANKContiguousBytes() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKContiguousBytes.Type }).count)
    }
    
    func testANKCoreInteger() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKCoreInteger.Type }).count)
    }
    
    func testANKFixedWidthInteger() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKFixedWidthInteger.Type }).count)
    }
    
    func testANKIntOrUInt() {
        XCTAssertEqual(02, types.compactMap({ $0 as? any ANKIntOrUInt.Type }).count)
    }
    
    func testANKMutableContiguousBytes() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKMutableContiguousBytes.Type }).count)
    }
    
    func testANKSignedFixedWidthInteger() {
        XCTAssertEqual(05, types.compactMap({ $0 as? any ANKSignedFixedWidthInteger.Type }).count)
    }
    
    func testANKSignedInteger() {
        XCTAssertEqual(05, types.compactMap({ $0 as? any ANKSignedInteger.Type }).count)
    }
    
    func testANKTrivialContiguousBytes() {
        XCTAssertEqual(10, types.compactMap({ $0 as  any ANKTrivialContiguousBytes.Type }).count)
    }
    
    func testANKUnsignedFixedWidthInteger() {
        XCTAssertEqual(05, types.compactMap({ $0 as? any ANKUnsignedFixedWidthInteger.Type }).count)
    }
    
    func testANKUnsignedInteger() {
        XCTAssertEqual(05, types.compactMap({ $0 as? any ANKUnsignedInteger.Type }).count)
    }
    
    func testANKWords() {
        XCTAssertEqual(00, types.compactMap({ $0 as? any ANKWords.Type }).count)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Bit
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
}

#endif
