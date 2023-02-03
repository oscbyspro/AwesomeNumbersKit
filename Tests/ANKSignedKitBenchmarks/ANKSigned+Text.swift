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
    
    func testDecodeUsingSwiftStdlib() {
        for _ in 0 ..< 50_000 {
            _ = T.Magnitude(Self.source, radix: 10)!
        }
    }
    
    func testDecodeUsingSwiftStdlibWhereRadixIsPowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = T.Magnitude(Self.source, radix: 16)!
        }
    }
    
    func testEncodeUsingSwiftStdlib() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number.magnitude, radix: 10)
        }
    }
    
    func testEncodeUsingSwiftStdlibWhereRadixIsPowerOf2() {
        for _ in 0 ..< 50_000 {
            _ = String(Self.number.magnitude, radix: 16)
        }
    }
}

#endif
