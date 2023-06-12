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

private typealias X = ANK.U192X64
private typealias Y = ANK.U192X32

//*============================================================================*
// MARK: * ANK x Int192 x Words
//*============================================================================*

final class Int192TestsOnWords: XCTestCase {
    
    typealias T = Int192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x64: X(0, 0, 0)), [0, 0, 0])
        ANKAssertWords(T(x64: X(1, 0, 0)), [1, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 0)), [1, 2, 0])
        ANKAssertWords(T(x64: X(1, 2, 3)), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x32: Y(0, 0, 0, 0, 0, 0)), [0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 0, 0, 0, 0, 0)), [1, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 0, 0, 0, 0)), [1, 2, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 0, 0, 0)), [1, 2, 3, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 0, 0)), [1, 2, 3, 4, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 0)), [1, 2, 3, 4, 5, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6)), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(1, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 1, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 1)), 2, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(1, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 1, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 1)), 2, false)
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(1, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 1, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 1, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 1, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 1, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 1)), 5, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(1, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 1, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 1, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 1, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 1, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 1)), 5, false)
    }
}

//*============================================================================*
// MARK: * ANK x UInt192 x Words
//*============================================================================*

final class UInt192TestsOnWords: XCTestCase {
    
    typealias T = UInt192
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testWordsX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x64: X(0, 0, 0)), [0, 0, 0])
        ANKAssertWords(T(x64: X(1, 0, 0)), [1, 0, 0])
        ANKAssertWords(T(x64: X(1, 2, 0)), [1, 2, 0])
        ANKAssertWords(T(x64: X(1, 2, 3)), [1, 2, 3])
    }
    
    func testWordsX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertWords(T(x32: Y(0, 0, 0, 0, 0, 0)), [0, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 0, 0, 0, 0, 0)), [1, 0, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 0, 0, 0, 0)), [1, 2, 0, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 0, 0, 0)), [1, 2, 3, 0, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 0, 0)), [1, 2, 3, 4, 0, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 0)), [1, 2, 3, 4, 5, 0])
        ANKAssertWords(T(x32: Y(1, 2, 3, 4, 5, 6)), [1, 2, 3, 4, 5, 6])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Two's Complement
    //=------------------------------------------------------------------------=
    
    func testMinLastIndexReportingIsZeroOrMinusOneX64() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt64>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(1, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 1, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x64: X(0, 0, 1)), 2, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(1, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 1, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x64: X(0, 0, 1)), 2, false)
    }
    
    func testMinLastIndexReportingIsZeroOrMinusOneX32() throws {
        guard MemoryLayout<UInt>.size == MemoryLayout<UInt32>.size else { throw XCTSkip() }
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 0)), 0, true )
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(1, 0, 0, 0, 0, 0)), 0, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 1, 0, 0, 0, 0)), 1, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 1, 0, 0, 0)), 2, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 1, 0, 0)), 3, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 1, 0)), 4, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne( T(x32: Y(0, 0, 0, 0, 0, 1)), 5, false)
        
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(1, 0, 0, 0, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 1, 0, 0, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 1, 0, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 1, 0, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 1, 0)), 5, false)
        ANKAssertMinLastIndexReportingIsZeroOrMinusOne(~T(x32: Y(0, 0, 0, 0, 0, 1)), 5, false)
    }
}

#endif
