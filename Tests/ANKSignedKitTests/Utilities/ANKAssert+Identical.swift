//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKSignedKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Identical
//*============================================================================*

func ANKAssertIdentical<T>(_ lhs: ANKSigned<T>, _ rhs: ANKSigned<T>, file: StaticString = #file, line: UInt = #line) {
    let success: Bool = lhs.sign == rhs.sign && lhs.magnitude == rhs.magnitude
    XCTAssert(success, "(\(text(lhs)) is not identical to (\(text(rhs)))", file: file, line: line)
}

func ANKAssertIdentical<T>(_ lhs: ANKSigned<T>?, _ rhs: ANKSigned<T>?, file: StaticString = #file, line: UInt = #line) {
    let success: Bool = lhs?.sign == rhs?.sign && lhs?.magnitude == rhs?.magnitude
    XCTAssert(success, "(\(text(lhs)) is not identical to (\(text(rhs)))", file: file, line: line)
}

//=----------------------------------------------------------------------------=
// MARK: + Utilities
//=----------------------------------------------------------------------------=

private func text<T>(_ x: ANKSigned<T>?) -> String {
    x.map({ "\($0.sign)\($0.magnitude)" }) ?? "nil"
}
