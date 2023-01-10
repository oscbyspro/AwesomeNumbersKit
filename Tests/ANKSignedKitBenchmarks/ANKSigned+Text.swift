//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if !DEBUG

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Text
//*============================================================================*

final class ANKSignedBenchmarksOnText: XCTestCase {
    
    typealias T = ANKSigned<UInt64>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static let number = T(decoding: source, radix: 16)!
    static let source = String(repeating: "f", count: 14)

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
