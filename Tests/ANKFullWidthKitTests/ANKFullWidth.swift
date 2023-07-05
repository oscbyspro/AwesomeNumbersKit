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
            XCTAssert(MemoryLayout<T>.alignment == MemoryLayout<UInt>.alignment)
        }
        
        for type: T in types {
            whereIs(type)
        }
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Initializers
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    init(x64: ANK.U128X64) where BitPattern == UInt128 {
        #if _endian(big)
        self = Swift.unsafeBitCast((x64.1, x64.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast((x64), to: Self.self)
        #endif
    }
    
    init(x32: ANK.U128X32) where BitPattern == UInt128 {
        #if _endian(big)
        self = Swift.unsafeBitCast((x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast((x32), to: Self.self)
        #endif
    }
    
    init(x64: ANK.U192X64) where Magnitude == UInt192 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U192X64(x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    init(x32: ANK.U192X32) where Magnitude == UInt192 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U192X32(x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x32, to: Self.self)
        #endif
    }
    
    init(x64: ANK.U256X64) where Magnitude == UInt256 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U256X64(x64.3, x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    init(x32: ANK.U256X32) where Magnitude == UInt256 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U256X32(x32.7, x32.6, x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x32, to: Self.self)
        #endif
    }
    
    init(x64: ANK.U384X64) where Magnitude == UInt384 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U256X64(x64.5, x64.4, x64.3, x64.2, x64.1, x64.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x64, to: Self.self)
        #endif
    }
    
    init(x32: ANK.U384X32) where Magnitude == UInt384 {
        #if _endian(big)
        self = Swift.unsafeBitCast(ANK.U256X32(x32.11, x32.10, x32.9, x32.8, x32.7, x32.6, x32.5, x32.4, x32.3, x32.2, x32.1, x32.0), to: Self.self)
        #else
        self = Swift.unsafeBitCast(x32, to: Self.self)
        #endif
    }
}
