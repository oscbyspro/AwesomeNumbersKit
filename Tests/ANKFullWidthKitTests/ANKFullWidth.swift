//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * ANK x Full Width
//*============================================================================*

final class ANKFullWidthTests: XCTestCase {
    
    typealias T = any ANKFixedWidthInteger.Type

    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let signed:   [T] = [ Int192.self,  Int256.self,  Int384.self,  Int512.self,  Int1024.self,  Int2048.self,  Int4096.self]
    static let unsigned: [T] = [UInt192.self, UInt256.self, UInt384.self, UInt512.self, UInt1024.self, UInt2048.self, UInt4096.self]
    static let types:    [T] = signed + unsigned
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    let types: [T] = ANKFullWidthTests.types
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testMemoryLayout() {
        func whereIs<T>(_ type: T.Type) where T: ANKFixedWidthInteger {
            XCTAssert(MemoryLayout<T>.size *  8 == T.bitWidth)
            XCTAssert(MemoryLayout<T>.size == MemoryLayout<T>.stride)
            XCTAssert(MemoryLayout<T>.size /  MemoryLayout<UInt>.stride >= 2)
            XCTAssert(MemoryLayout<T>.size %  MemoryLayout<UInt>.stride == 0)
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
}
