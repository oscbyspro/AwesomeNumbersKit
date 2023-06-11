//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Text
//*============================================================================*

func ANKAssertDecodeText<M: ANKFixedWidthInteger>(
_ integer: ANKSigned<M>?, _ radix: Int, _ text: String,
file: StaticString = #file, line: UInt = #line) {
    typealias T = ANKSigned<M>
    //=------------------------------------------=
    if  radix == 10 {
        ANKAssertIdentical(T(text), integer, file: file, line: line)
    }
    //=------------------------------------------=
    ANKAssertIdentical(T(text, radix: radix), integer, file: file, line: line)
}

func ANKAssertEncodeText<M: ANKFixedWidthInteger>(
_ integer: ANKSigned<M>, _ radix: Int, _ uppercase: Bool, _ text: String,
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
