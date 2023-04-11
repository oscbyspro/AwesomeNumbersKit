//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKFoundation
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

    static var number = _blackHoleIdentity(T(decoding:    source, radix: 16)!)
    static var source = _blackHoleIdentity(String(repeating: "1", count: 48) )

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(decoding: Self.source, radix: 10)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(decoding: Self.source, radix: 16)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(encoding: Self.number, radix: 10))
            _blackHoleInoutIdentity(&Self.number)

        }
    }
    
    func testEncodingRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(encoding: Self.number, radix: 16))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(Self.source, radix: 10)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(Self.source, radix: 16)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(Self.number, radix: 10))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(Self.number, radix: 16))
            _blackHoleInoutIdentity(&Self.number)
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

    static var number = _blackHoleIdentity(T(decoding:    source, radix: 16)!)
    static var source = _blackHoleIdentity(String(repeating: "1", count: 48) )

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(decoding: Self.source, radix: 10)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(decoding: Self.source, radix: 16)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(encoding: Self.number, radix: 10))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(encoding: Self.number, radix: 16))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(Self.source, radix: 10)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(T(Self.source, radix: 16)!)
            _blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(Self.number, radix: 10))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _blackHole(String(Self.number, radix: 16))
            _blackHoleInoutIdentity(&Self.number)
        }
    }
}

#endif
