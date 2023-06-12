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
// MARK: * ANK x Text
//*============================================================================*

final class ANKTextTests: XCTestCase {
    
    //=------------------------------------------------------------------------=
    // MARK: Tests
    //=------------------------------------------------------------------------=
    
    func testIntegerComponents() {
        ANKAssertIntegerComponents(    "", .plus,      "")
        ANKAssertIntegerComponents(   "+", .plus,      "")
        ANKAssertIntegerComponents(   "-", .minus,     "")
        ANKAssertIntegerComponents(   "~", .plus,     "~")
        ANKAssertIntegerComponents("+123", .plus,   "123")
        ANKAssertIntegerComponents("-123", .minus,  "123")
        ANKAssertIntegerComponents("~123", .plus,  "~123")
    }
    
    func testRemoveSignPrefix() {
        ANKAssertRemoveSignPrefix(    "",  nil,       "")
        ANKAssertRemoveSignPrefix(   "+", .plus,      "")
        ANKAssertRemoveSignPrefix(   "-", .minus,     "")
        ANKAssertRemoveSignPrefix(   "~",  nil,      "~")
        ANKAssertRemoveSignPrefix("+123", .plus,   "123")
        ANKAssertRemoveSignPrefix("-123", .minus,  "123")
        ANKAssertRemoveSignPrefix("~123",  nil,   "~123")
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities
//=----------------------------------------------------------------------------=

private func ANKAssertIntegerComponents(
_ text: String, _ sign: FloatingPointSign?, _ body: String,
file: StaticString = #file, line: UInt = #line) {
    let components = ANK.integerComponents(utf8: text.utf8)
    XCTAssertEqual(components.sign, sign)
    XCTAssertEqual(Array(components.body), Array(body.utf8))
}

private func ANKAssertRemoveSignPrefix(
_ text: String, _ sign: FloatingPointSign?, _ body: String,
file: StaticString = #file, line: UInt = #line) {
    var componentsBody = text.utf8[...]
    let componentsSign = ANK.removeSignPrefix(utf8: &componentsBody)
    XCTAssertEqual(componentsSign, sign)
    XCTAssertEqual(Array(componentsBody), Array(body.utf8))
}

#endif
