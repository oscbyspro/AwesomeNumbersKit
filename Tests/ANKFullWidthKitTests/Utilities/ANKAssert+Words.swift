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

//=----------------------------------------------------------------------------=
// MARK: + Indices
//=----------------------------------------------------------------------------=

func ANKAssertIndexOffsetByLimitedBy<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>, _ index: Int, _ distance: Int, _ limit: Int, _ expectation: Int?,
file: StaticString = #file, line: UInt = #line) {
    let wordsIndex = /*-*/(integer).index(index, offsetBy: distance, limitedBy: limit)
    let arrayIndex = Array(integer).index(index, offsetBy: distance, limitedBy: limit)
    
    XCTAssertEqual(wordsIndex, expectation, file: file, line: line)
    XCTAssertEqual(arrayIndex, expectation, file: file, line: line)
    //=------------------------------------------=
    var integer = integer
    
    integer.withUnsafeWords {
        let index = $0.index(index, offsetBy: distance, limitedBy: limit)
        XCTAssertEqual(index, expectation, file: file, line: line)
    }
    
    integer.withUnsafeMutableWords {
        let index = $0.index(index, offsetBy: distance, limitedBy: limit)
        XCTAssertEqual(index, expectation, file: file, line: line)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Elements x First, Last, Tail
//=----------------------------------------------------------------------------=

func ANKAssertFirstLastTail<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>, first: UInt, last: UInt, tail: H.Digit,
file: StaticString = #file, line: UInt = #line) {
    typealias T = ANKFullWidth<H, L>
    //=------------------------------------------=
    XCTAssertEqual(integer.first, first, file: file, line: line)
    XCTAssertEqual(integer.last,  last,  file: file, line: line)
    XCTAssertEqual(integer.tail,  tail,  file: file, line: line)
    //=------------------------------------------=
    XCTAssertEqual({ var x = T.zero; x.first = first; return x.first }(), first, file: file, line: line)
    XCTAssertEqual({ var x = T.zero; x.last  = last;  return x.last  }(), last,  file: file, line: line)
    XCTAssertEqual({ var x = T.zero; x.tail  = tail;  return x.tail  }(), tail,  file: file, line: line)
}
