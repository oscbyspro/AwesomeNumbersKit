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

private typealias X = ANK256X64
private typealias Y = ANK256X32

//*============================================================================*
// MARK: * Int256 x Words
//*============================================================================*

final class Int256BenchmarksOnWords: XCTestCase {
    
    typealias T = ANKInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNonzeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.nonzeroBitCount
            _ = xyz.nonzeroBitCount
        }
    }
    
    func testLeadingZeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.leadingZeroBitCount
            _ = xyz.leadingZeroBitCount
        }
    }
    
    func testTrailingZeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.trailingZeroBitCount
            _ = xyz.trailingZeroBitCount
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.minLastIndexReportingIsZeroOrMinusOne()
            _ = xyz.minLastIndexReportingIsZeroOrMinusOne()
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.minWordCountReportingIsZeroOrMinusOne()
            _ = xyz.minWordCountReportingIsZeroOrMinusOne()
        }
    }
}

//*============================================================================*
// MARK: * UInt256 x Words
//*============================================================================*

final class UInt256BenchmarksOnWords: XCTestCase {
    
    typealias T = ANKUInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testNonzeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.nonzeroBitCount
            _ = xyz.nonzeroBitCount
        }
    }
    
    func testLeadingZeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.leadingZeroBitCount
            _ = xyz.leadingZeroBitCount
        }
    }
    
    func testTrailingZeroBitCount() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.trailingZeroBitCount
            _ = xyz.trailingZeroBitCount
        }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Min Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOne() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.minLastIndexReportingIsZeroOrMinusOne()
            _ = xyz.minLastIndexReportingIsZeroOrMinusOne()
        }
    }
    
    func testMinWordCountReportingIsZeroOrMinusOne() {
        let abc =  T(x64: X(0, 0, 0, 0))
        let xyz = ~T(x64: X(0, 0, 0, 0))
        
        for _ in 0 ..< 1_000_000 {
            _ = abc.minWordCountReportingIsZeroOrMinusOne()
            _ = xyz.minWordCountReportingIsZeroOrMinusOne()
        }
    }
}

#endif
