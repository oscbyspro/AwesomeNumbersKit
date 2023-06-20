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
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Signed x Text
//*============================================================================*

final class ANKSignedBenchmarksOnText: XCTestCase {
    
    typealias T = ANKSigned<UInt256>
    typealias D = ANKSigned<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    static var decoded = ANK.blackHoleIdentity(T(encoded, radix: 16)!)
    static var encoded = ANK.blackHoleIdentity(String(repeating: "1", count: 64) )
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        var radix   = ANK.blackHoleIdentity(10)
        var encoded = ANK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(encoded, radix: radix)!)
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingRadix16() {
        var radix   = ANK.blackHoleIdentity(16)
        var encoded = ANK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(encoded, radix: radix)!)
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingRadix10() {
        var radix   = ANK.blackHoleIdentity(10)
        var decoded = ANK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(String(decoded, radix: radix))
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingRadix16() {
        var radix   = ANK.blackHoleIdentity(16)
        var decoded = ANK.blackHoleIdentity(Self.decoded)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(String(decoded, radix: radix))
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        var radix   = ANK.blackHoleIdentity(10)
        var encoded = ANK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.Magnitude.stdlib(encoded, radix: radix)!)
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix   = ANK.blackHoleIdentity(16)
        var encoded = ANK.blackHoleIdentity(Self.encoded)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.Magnitude.stdlib(encoded, radix: radix)!)
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&encoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix   = ANK.blackHoleIdentity(10)
        var decoded = ANK.blackHoleIdentity(Self.decoded.magnitude)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(String.stdlib(decoded, radix: radix))
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&decoded)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix   = ANK.blackHoleIdentity(16)
        var decoded = ANK.blackHoleIdentity(Self.decoded.magnitude)
        
        for _ in 0 ..< 1_000 {
            ANK.blackHole(String.stdlib(decoded, radix: radix))
            ANK.blackHoleInoutIdentity(&radix)
            ANK.blackHoleInoutIdentity(&decoded)
        }
    }
}

#endif
