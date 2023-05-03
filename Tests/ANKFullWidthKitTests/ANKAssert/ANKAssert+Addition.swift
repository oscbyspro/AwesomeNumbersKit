//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Addition
//*============================================================================*

public func ANKAssertAddition<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T, _ partialValue: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs += rhs; return lhs }(), partialValue, file: file, line: line)
        XCTAssertEqual({                lhs +  rhs             }(), partialValue, file: file, line: line)
    }
    
    XCTAssertEqual({ var lhs = lhs; lhs &+= rhs; return lhs }(), partialValue, file: file, line: line)
    XCTAssertEqual({                lhs &+  rhs             }(), partialValue, file: file, line: line)
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.addReportingOverflow(rhs); return lhs  }(), partialValue, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.addReportingOverflow(rhs)              }(), overflow,     file: file, line: line)
    XCTAssertEqual({                    lhs.addingReportingOverflow(rhs).partialValue }(), partialValue, file: file, line: line)
    XCTAssertEqual({                    lhs.addingReportingOverflow(rhs).overflow     }(), overflow,     file: file, line: line)
}

public func ANKAssertAddition<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T.Digit, _ partialValue: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs += rhs; return lhs }(), partialValue, file: file, line: line)
        XCTAssertEqual({                lhs +  rhs             }(), partialValue, file: file, line: line)
    }
    
    XCTAssertEqual({ var lhs = lhs; lhs &+= rhs; return lhs }(), partialValue, file: file, line: line)
    XCTAssertEqual({                lhs &+  rhs             }(), partialValue, file: file, line: line)
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.addReportingOverflow(rhs); return lhs  }(), partialValue, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.addReportingOverflow(rhs)              }(), overflow,     file: file, line: line)
    XCTAssertEqual({                    lhs.addingReportingOverflow(rhs).partialValue }(), partialValue, file: file, line: line)
    XCTAssertEqual({                    lhs.addingReportingOverflow(rhs).overflow     }(), overflow,     file: file, line: line)
}
