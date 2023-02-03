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

private typealias X = ANK192X64
private typealias Y = ANK192X32

//*============================================================================*
// MARK: * Int192 x Text
//*============================================================================*

final class Int192BenchmarksOnText: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let number = T(decoding:    source, radix: 16)!
    static let source = String(repeating: "1", count: 48)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecode() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 10)!
        }
    }
    
    func testDecodePowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 16)!
        }
    }
    
    func testEncode() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 10)
        }
    }
    
    func testEncodePowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 16)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodeUsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = T(Self.source, radix: 10)!
        }
    }
    
    func testDecodePowerOf2UsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = T(Self.source, radix: 16)!
        }
    }
    
    func testEncodeUsingSwiftStdlib() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number, radix: 10)
        }
    }
    
    func testEncodePowerOf2UsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number, radix: 16)
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
    
    static let number = T(decoding:    source, radix: 16)!
    static let source = String(repeating: "1", count: 48)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecode() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 10)!
        }
    }
    
    func testDecodePowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 16)!
        }
    }
    
    func testEncode() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 10)
        }
    }
    
    func testEncodePowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 16)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodeUsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = T(Self.source, radix: 10)!
        }
    }
    
    func testDecodePowerOf2UsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = T(Self.source, radix: 16)!
        }
    }
    
    func testEncodeUsingSwiftStdlib() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number, radix: 10)
        }
    }
    
    func testEncodePowerOf2UsingStdlib() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number, radix: 16)
        }
    }
}

#endif
