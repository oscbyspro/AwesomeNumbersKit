//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Words
//*============================================================================*

func ANKAssertWords<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>, _ words: [UInt],
file: StaticString = #file, line: UInt = #line) {
    var integer: ANKFullWidth<H, L> = integer
    var generic: some RandomAccessCollection<UInt> & MutableCollection = integer
    
    XCTAssertEqual(Array(integer),       words, file: file, line: line)
    XCTAssertEqual(Array(integer.words), words, file: file, line: line)
    
    XCTAssertEqual(integer.withContiguousStorage({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(integer.withContiguousMutableStorage({ Array($0) }), words, file: file, line: line)
    
    XCTAssertEqual(integer.withContiguousStorageIfAvailable({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(integer.withContiguousMutableStorageIfAvailable({ Array($0) }), words, file: file, line: line)
    
    XCTAssertEqual(generic.withContiguousStorageIfAvailable({        Array($0) }), words, file: file, line: line)
    XCTAssertEqual(generic.withContiguousMutableStorageIfAvailable({ Array($0) }), words, file: file, line: line)
}

func ANKAssertMinLastIndexReportingIsZeroOrMinusOne<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>, _ minLastIndex: Int, _ isZeroOrMinusOne: Bool,
file: StaticString = #file, line: UInt = #line) {
    let aboutIndex = integer.minLastIndexReportingIsZeroOrMinusOne()
    
    XCTAssertEqual(aboutIndex.minLastIndex,     minLastIndex,     file: file, line: line)
    XCTAssertEqual(aboutIndex.isZeroOrMinusOne, isZeroOrMinusOne, file: file, line: line)
    
    let aboutCount = integer.minWordCountReportingIsZeroOrMinusOne()
    
    XCTAssertEqual(aboutCount.minWordCount,     minLastIndex + 1, file: file, line: line)
    XCTAssertEqual(aboutCount.isZeroOrMinusOne, isZeroOrMinusOne, file: file, line: line)
}
