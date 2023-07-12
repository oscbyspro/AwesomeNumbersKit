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
// MARK: * ANK x Assert x Logic
//*============================================================================*

func ANKAssertNot<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ operand: ANKFullWidth<H, L>, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(~operand, result, file: file, line: line)
    XCTAssertEqual(~result, operand, file: file, line: line)
}

func ANKAssertAnd<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs: ANKFullWidth<H, L>, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(                 lhs &  rhs,                 result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs &= rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual(                 rhs &  lhs,                 result, file: file, line: line)
    XCTAssertEqual({ var rhs = rhs; rhs &= lhs; return rhs }(), result, file: file, line: line)
}

func ANKAssertOr<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs: ANKFullWidth<H, L>, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(                 lhs |  rhs,                 result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs |= rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual(                 rhs |  lhs,                 result, file: file, line: line)
    XCTAssertEqual({ var rhs = rhs; rhs |= lhs; return rhs }(), result, file: file, line: line)
}

func ANKAssertXor<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs: ANKFullWidth<H, L>, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(                 lhs ^  rhs,                 result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs ^= rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual(                 rhs ^  lhs,                 result, file: file, line: line)
    XCTAssertEqual({ var rhs = rhs; rhs ^= lhs; return rhs }(), result, file: file, line: line)
}
