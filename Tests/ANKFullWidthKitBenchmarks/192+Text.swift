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
            ANK.blackHole(T.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
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
            ANK.blackHole(T.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testDecodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var source = ANK.blackHoleIdentity(Self.source)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(T.stdlib(source, radix: radix)!)
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&source)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix10() {
        var radix  = ANK.blackHoleIdentity(10)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
    
    func testEncodingUsingSwiftStdlibRadix16() {
        var radix  = ANK.blackHoleIdentity(16)
        var number = ANK.blackHoleIdentity(Self.number)
        
        for _ in 0 ..< 50_000 {
            ANK.blackHole(String.stdlib(number, radix: radix))
            ANK.blackHoleInoutIdentity( &radix)
            ANK.blackHoleInoutIdentity(&number)
        }
    }
}

#endif
