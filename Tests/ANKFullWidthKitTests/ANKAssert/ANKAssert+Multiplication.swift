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
// MARK: * ANK x Assert x Multiplication
//*============================================================================*

func ANKAssertMultiplication<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T, _ low: T, _ high: T? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? T(repeating: low.isLessThanZero)
    
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
        XCTAssertEqual({                lhs *  rhs             }(), low, file: file, line: line)
    }
    
    XCTAssertEqual({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
    XCTAssertEqual({                lhs &*  rhs             }(), low, file: file, line: line)
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.multiplyReportingOverflow(by: rhs); return lhs  }(), low,      file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.multiplyReportingOverflow(by: rhs)              }(), overflow, file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedReportingOverflow(by: rhs).partialValue }(), low,      file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedReportingOverflow(by: rhs).overflow     }(), overflow, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.multiplyFullWidth(by: rhs); return lhs  }(), low,  file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.multiplyFullWidth(by: rhs)              }(), high, file: file, line: line)
    XCTAssertEqual({       T(bitPattern: lhs.multipliedFullWidth(by: rhs).low)         }(), low,  file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedFullWidth(by: rhs).high         }(), high, file: file, line: line)
}

func ANKAssertMultiplicationByDigit<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T.Digit, _ low: T, _ high: T.Digit? = nil, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    let high = high ?? T.Digit(repeating: low.isLessThanZero)
    
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs *= rhs; return lhs }(), low, file: file, line: line)
        XCTAssertEqual({                lhs *  rhs             }(), low, file: file, line: line)
    }
    
    XCTAssertEqual({ var lhs = lhs; lhs &*= rhs; return lhs }(), low, file: file, line: line)
    XCTAssertEqual({                lhs &*  rhs             }(), low, file: file, line: line)
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.multiplyReportingOverflow(by: rhs); return lhs  }(), low,      file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.multiplyReportingOverflow(by: rhs)              }(), overflow, file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedReportingOverflow(by: rhs).partialValue }(), low,      file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedReportingOverflow(by: rhs).overflow     }(), overflow, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.multiplyFullWidth(by: rhs); return lhs  }(), low,  file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.multiplyFullWidth(by: rhs)              }(), high, file: file, line: line)
    XCTAssertEqual({       T(bitPattern: lhs.multipliedFullWidth(by: rhs).low)         }(), low,  file: file, line: line)
    XCTAssertEqual({                     lhs.multipliedFullWidth(by: rhs).high         }(), high, file: file, line: line)
}
