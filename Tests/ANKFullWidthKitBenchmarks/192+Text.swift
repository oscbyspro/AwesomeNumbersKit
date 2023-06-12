//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Text
//*============================================================================*

final class Int192BenchmarksOnText: XCTestCase {

    typealias T = Int192

    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=

    static var number = ANK.blackHoleIdentity(T(source, radix: 16)!)
    static var source = ANK.blackHoleIdentity(String(repeating: "1", count: 48) )

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T(Self.source, radix: 10)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T(Self.source, radix: 16)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String(Self.number, radix: 10))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String(Self.number, radix: 16))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(Self.source, radix: 10)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(Self.source, radix: 16)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(Self.number, radix: 10))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(Self.number, radix: 16))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Text
//*============================================================================*

final class UInt192BenchmarksOnText: XCTestCase {

    typealias T = UInt192

    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=

    static var number = ANK.blackHoleIdentity(T(source, radix: 16)!)
    static var source = ANK.blackHoleIdentity(String(repeating: "1", count: 48) )

    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T(Self.source, radix: 10)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T(Self.source, radix: 16)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String(Self.number, radix: 10))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String(Self.number, radix: 16))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(Self.source, radix: 10)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(Self.source, radix: 16)!)
            ANK.blackHoleInoutIdentity(&Self.source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(Self.number, radix: 10))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(Self.number, radix: 16))
            ANK.blackHoleInoutIdentity(&Self.number)
        }
    }
}

#endif
