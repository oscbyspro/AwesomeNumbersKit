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
import XCTest

//*============================================================================*
// MARK: * ANK x Collection x Tests
//*============================================================================*

final class ANKCollectionTests: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Remove Count
    //=------------------------------------------------------------------------=
    
    func testRemovePrefixCount() {
        ANKAssertRemovePrefixCount(0, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemovePrefixCount(1, [1            ], [   2, 3, 4, 5])
        ANKAssertRemovePrefixCount(2, [1, 2         ], [      3, 4, 5])
        ANKAssertRemovePrefixCount(3, [1, 2, 3      ], [         4, 5])
        ANKAssertRemovePrefixCount(4, [1, 2, 3, 4   ], [            5])
        ANKAssertRemovePrefixCount(5, [1, 2, 3, 4, 5], [             ])
    }
    
    func testRemoveSuffixCount() {
        ANKAssertRemoveSuffixCount(0, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemoveSuffixCount(1, [1, 2, 3, 4   ], [            5])
        ANKAssertRemoveSuffixCount(2, [1, 2, 3      ], [         4, 5])
        ANKAssertRemoveSuffixCount(3, [1, 2         ], [      3, 4, 5])
        ANKAssertRemoveSuffixCount(4, [1            ], [   2, 3, 4, 5])
        ANKAssertRemoveSuffixCount(5, [             ], [1, 2, 3, 4, 5])
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Tests x Remove Max Length
    //=------------------------------------------------------------------------=
    
    func testRemovePrefixMaxLength() {
        ANKAssertRemovePrefixMaxLength(0, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemovePrefixMaxLength(1, [1            ], [   2, 3, 4, 5])
        ANKAssertRemovePrefixMaxLength(2, [1, 2         ], [      3, 4, 5])
        ANKAssertRemovePrefixMaxLength(3, [1, 2, 3      ], [         4, 5])
        ANKAssertRemovePrefixMaxLength(4, [1, 2, 3, 4   ], [            5])
        ANKAssertRemovePrefixMaxLength(5, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemovePrefixMaxLength(6, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemovePrefixMaxLength(7, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemovePrefixMaxLength(8, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemovePrefixMaxLength(9, [1, 2, 3, 4, 5], [             ])
    }
    
    func testRemoveSuffixMaxLength() {
        ANKAssertRemoveSuffixMaxLength(0, [1, 2, 3, 4, 5], [             ])
        ANKAssertRemoveSuffixMaxLength(1, [1, 2, 3, 4   ], [            5])
        ANKAssertRemoveSuffixMaxLength(2, [1, 2, 3      ], [         4, 5])
        ANKAssertRemoveSuffixMaxLength(3, [1, 2         ], [      3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(4, [1            ], [   2, 3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(5, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(6, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(7, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(8, [             ], [1, 2, 3, 4, 5])
        ANKAssertRemoveSuffixMaxLength(9, [             ], [1, 2, 3, 4, 5])
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities x Remove Count
//=----------------------------------------------------------------------------=

private func ANKAssertRemovePrefixCount(
_ count: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = ANK.removePrefix(from: &collection, count: count)
    
    XCTAssertEqual(Array(extraction), prefix, file: file, line: line)
    XCTAssertEqual(Array(collection), suffix, file: file, line: line)
}

private func ANKAssertRemoveSuffixCount(
_ count: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = ANK.removeSuffix(from: &collection, count: count)
    
    XCTAssertEqual(Array(collection), prefix, file: file, line: line)
    XCTAssertEqual(Array(extraction), suffix, file: file, line: line)
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities x Remove Max Length
//=----------------------------------------------------------------------------=

private func ANKAssertRemovePrefixMaxLength(
_ maxLength: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = ANK.removePrefix(from: &collection, maxLength: maxLength)
    
    XCTAssertEqual(Array(extraction), prefix, file: file, line: line)
    XCTAssertEqual(Array(collection), suffix, file: file, line: line)
}

private func ANKAssertRemoveSuffixMaxLength(
_ maxLength: Int, _ prefix: [Int], _ suffix: [Int],
file: StaticString = #file, line: UInt = #line) {
    var collection = (prefix + suffix)[...]
    let extraction = ANK.removeSuffix(from: &collection, maxLength: maxLength)
    
    XCTAssertEqual(Array(collection), prefix, file: file, line: line)
    XCTAssertEqual(Array(extraction), suffix, file: file, line: line)
}

#endif
