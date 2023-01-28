//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * Int192 x Text
//*============================================================================*

final class Int192BenchmarksOnText: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let number = T(decoding: source,    radix: 16)!
    static let source = String(repeating: "f", count: 44)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecode() {
        for _ in 0 ..< 1_000 {
            _ = T(decoding: Self.source, radix: 20)!
        }
    }
    
    func testDecodePowerOf2() {
        for _ in 0 ..< 1_000 {
            _ = T(decoding: Self.source, radix: 16)!
        }
    }
    
    func testEncode() {
        for _ in 0 ..< 1_000 {
            _ = String(encoding: Self.number, radix: 20)
        }
    }
    
    func testEncodePowerOf2() {
        for _ in 0 ..< 1_000 {
            _ = String(encoding: Self.number, radix: 16)
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Text
//*============================================================================*

final class UInt192BenchmarksOnText: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let number = T(decoding: source,    radix: 16)!
    static let source = String(repeating: "f", count: 44)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecode() {
        for _ in 0 ..< 1_000 {
            _ = T(decoding: Self.source, radix: 20)!
        }
    }
    
    func testDecodePowerOf2() {
        for _ in 0 ..< 1_000 {
            _ = T(decoding: Self.source, radix: 16)!
        }
    }
    
    func testEncode() {
        for _ in 0 ..< 1_000 {
            _ = String(encoding: Self.number, radix: 20)
        }
    }
    
    func testEncodePowerOf2() {
        for _ in 0 ..< 1_000 {
            _ = String(encoding: Self.number, radix: 16)
        }
    }
}

#endif
