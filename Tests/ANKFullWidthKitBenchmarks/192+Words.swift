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
// MARK: * Int192 x Words
//*============================================================================*

final class Int192BenchmarksOnWords: XCTestCase {
    
    typealias T = ANKInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        let abc = _blackHoleIdentity( T(x64: X(0, 0, 0)))
        let xyz = _blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            _blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        let abc = _blackHoleIdentity( T(x64: X(0, 0, 0)))
        let xyz = _blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            _blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
        }
    }
}

//*============================================================================*
// MARK: * UInt192 x Words
//*============================================================================*

final class UInt192BenchmarksOnWords: XCTestCase {
    
    typealias T = ANKUInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        let abc = _blackHoleIdentity( T(x64: X(0, 0, 0)))
        let xyz = _blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.minLastIndexReportingIsZeroOrMinusOne())
            _blackHole(xyz.minLastIndexReportingIsZeroOrMinusOne())
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        let abc = _blackHoleIdentity( T(x64: X(0, 0, 0)))
        let xyz = _blackHoleIdentity(~T(x64: X(0, 0, 0)))
        
        for _ in 0 ..< 1_000_000 {
            _blackHole(abc.minWordCountReportingIsZeroOrMinusOne())
            _blackHole(xyz.minWordCountReportingIsZeroOrMinusOne())
        }
    }
}

#endif
