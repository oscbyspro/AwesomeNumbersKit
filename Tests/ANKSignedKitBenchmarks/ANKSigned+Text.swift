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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Text
//*============================================================================*

final class ANKSignedBenchmarksOnText: XCTestCase {
    
    typealias T = ANKSigned<ANKUInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let number = T(decoding:    source, radix: 16)!
    static let source = String(repeating: "1", count: 64)
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix16() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 16)!
        }
    }
    
    func testDecodingRadix10() {
        for _ in 0 ..< 50_000 {
            _ = T(decoding: Self.source, radix: 10)!
        }
    }
    
    func testEncodingRadix16() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 16)
        }
    }
    
    func testEncodingRadix10() {
        for _ in 0 ..< 50_000 {
            _ = String(encoding: Self.number, radix: 10)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _ = T.Magnitude(Self.source, radix: 16)!
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _ = T.Magnitude(Self.source, radix: 10)!
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number.magnitude, radix: 16)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number.magnitude, radix: 10)
        }
    }
}

#endif
