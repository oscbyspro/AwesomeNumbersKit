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

func ANKAssertIdentical<M>(_ lhs: ANKSigned<M>?, _ rhs: ANKSigned<M>?, file: StaticString = #file, line: UInt = #line) {
    func text<T>(_ x: ANKSigned<T>?) -> String {
        x.map(String.init) ?? "nil"
    }
    
    let success: Bool = lhs?.sign == rhs?.sign && lhs?.magnitude == rhs?.magnitude
    XCTAssert(success, "(\(String(describing: lhs)) is not identical to (\(String(describing: rhs))", file: file, line: line)
}
