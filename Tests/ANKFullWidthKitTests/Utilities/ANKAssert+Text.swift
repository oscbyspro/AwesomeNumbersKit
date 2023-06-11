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
// MARK: * ANK x Assert x Text
//*============================================================================*

func ANKAssertDecodeText<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>?, _ radix: Int, _ text: String,
file: StaticString = #file, line: UInt = #line) {
    typealias T = ANKFullWidth<H, L>
    //=------------------------------------------=
    if  radix == 10 {
        XCTAssertEqual(T(text), integer, file: file, line: line)
    }
    //=------------------------------------------=
    XCTAssertEqual(T(text, radix: radix), integer, file: file, line: line)
}

func ANKAssertEncodeText<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ integer: ANKFullWidth<H, L>, _ radix: Int, _ uppercase: Bool, _ text: String,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    if  radix == 10, uppercase == false {
        XCTAssertEqual(String(integer),       text, file: file, line: line)
        XCTAssertEqual(integer.description,   text, file: file, line: line)
        XCTAssertEqual(integer.description(), text, file: file, line: line)
    }
    //=------------------------------------------=
    XCTAssertEqual(String(integer,     radix: radix, uppercase: uppercase), text, file: file, line: line)
    XCTAssertEqual(integer.description(radix: radix, uppercase: uppercase), text, file: file, line: line)
}
