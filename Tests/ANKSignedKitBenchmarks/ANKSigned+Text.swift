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
    
    static var number = ANK.blackHoleIdentity(T(source, radix: 16)!)
    static var source = ANK.blackHoleIdentity(String(repeating: "1", count: 64) )
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testDecodingRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testDecodingRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(T(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testEncodingRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(String(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
    
    func testEncodingRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 250_000 {
            ANK.blackHole(String(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Swift Standard Library Methods
    //=------------------------------------------------------------------------=
    
    func testDecodingUsingSwiftStdlibRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.Magnitude.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.Magnitude.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var number = ANK.blackHoleIdentity(Self.number.magnitude)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var number = ANK.blackHoleIdentity(Self.number.magnitude)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
}

#endif
