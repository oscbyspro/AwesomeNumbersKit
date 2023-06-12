//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

#if DEBUG

import ANKCoreKit
import ANKFullWidthKit
import XCTest

private typealias X = ANK.U256X64
private typealias Y = ANK.U256X32

//*============================================================================*
// MARK: * ANK x Int256 x Words
//*============================================================================*

final class Int256TestsOnWords: XCTestCase {
    
    typealias T = Int256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x64: X(0, 0, 0, 0)), [0, 0, 0, 0])
        ANKAssertWords(T(x64: X(1, 0, 0, 0)), [1, 0, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 0, 0)), [1, 2, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 3, 0)), [1, 2, 3, 0])
        ANKAssertWords(T(x64: X(1, 2, 3, 4)), [1, 2, 3, 4])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), [0, 0, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), [1, 0, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 0, 0, 0, 0, 0, 0)), [1, 2, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 0, 0, 0, 0, 0)), [1, 2, 3, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 0, 0, 0, 0)), [1, 2, 3, 4, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 0, 0, 0)), [1, 2, 3, 4, 5, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 0, 0)), [1, 2, 3, 4, 5, 6, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 7, 0)), [1, 2, 3, 4, 5, 6, 7, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 7, 8)), [1, 2, 3, 4, 5, 6, 7, 8])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(1, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 1, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 1, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0, 1)), 3, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(1, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 1, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 1, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0, 1)), 3, false)
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), 6, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), 7, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), 6, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), 7, false)
    }
}

//*============================================================================*
// MARK: * ANK x UInt256 x Words
//*============================================================================*

final class UInt256TestsOnWords: XCTestCase {
    
    typealias T = UInt256
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x64: X(0, 0, 0, 0)), [0, 0, 0, 0])
        ANKAssertWords(T(x64: X(1, 0, 0, 0)), [1, 0, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 0, 0)), [1, 2, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 3, 0)), [1, 2, 3, 0])
        ANKAssertWords(T(x64: X(1, 2, 3, 4)), [1, 2, 3, 4])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), [0, 0, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), [1, 0, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 0, 0, 0, 0, 0, 0)), [1, 2, 0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 0, 0, 0, 0, 0)), [1, 2, 3, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 0, 0, 0, 0)), [1, 2, 3, 4, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 0, 0, 0)), [1, 2, 3, 4, 5, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 0, 0)), [1, 2, 3, 4, 5, 6, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 7, 0)), [1, 2, 3, 4, 5, 6, 7, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6, 7, 8)), [1, 2, 3, 4, 5, 6, 7, 8])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(1, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 1, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 1, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0, 1)), 3, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(1, 0, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 1, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 1, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0, 1)), 3, false)
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), 6, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), 7, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(1, 0, 0, 0, 0, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 1, 0, 0, 0, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 1, 0, 0, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 1, 0, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 1, 0, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 1, 0, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 1, 0)), 7, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0, 0, 1)), 7, false)
    }
}

#endif
