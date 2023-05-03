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
// MARK: * ANK x Assert x Division
//*============================================================================*

func ANKAssertDivision<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T, _ quotient: T, _ remainder: T, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs /= rhs; return lhs }(), quotient,  file: file, line: line)
        XCTAssertEqual({                lhs /  rhs             }(), quotient,  file: file, line: line)
        
        XCTAssertEqual({ var lhs = lhs; lhs %= rhs; return lhs }(), remainder, file: file, line: line)
        XCTAssertEqual({                lhs %  rhs             }(), remainder, file: file, line: line)
        
        XCTAssertEqual({ lhs.quotientAndRemainder(dividingBy: rhs).quotient  }(), quotient,  file: file, line: line)
        XCTAssertEqual({ lhs.quotientAndRemainder(dividingBy: rhs).remainder }(), remainder, file: file, line: line)
    }
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.divideReportingOverflow(by: rhs); return lhs  }(), quotient, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.divideReportingOverflow(by: rhs)              }(), overflow, file: file, line: line)
    XCTAssertEqual({                   lhs.dividedReportingOverflow(by: rhs).partialValue    }(), quotient, file: file, line: line)
    XCTAssertEqual({                   lhs.dividedReportingOverflow(by: rhs).overflow        }(), overflow, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.formRemainderReportingOverflow(dividingBy: rhs); return lhs  }(), remainder, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.formRemainderReportingOverflow(dividingBy: rhs)              }(), overflow,  file: file, line: line)
    XCTAssertEqual({                        lhs.remainderReportingOverflow(dividingBy: rhs).partialValue    }(), remainder, file: file, line: line)
    XCTAssertEqual({                        lhs.remainderReportingOverflow(dividingBy: rhs).overflow        }(), overflow,  file: file, line: line)
    
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.quotient  }(), quotient,  file: file, line: line)
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.remainder }(), remainder, file: file, line: line)
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).overflow               }(), overflow,  file: file, line: line)
}

func ANKAssertDivisionByDigit<T: ANKFixedWidthInteger>(
_ lhs: T, _ rhs: T.Digit, _ quotient: T, _ remainder: T.Digit, _ overflow: Bool = false,
file: StaticString = #file, line: UInt = #line) {
    typealias D = T.Digit
    
    if !overflow {
        XCTAssertEqual({ var lhs = lhs; lhs /= rhs; return lhs }(), quotient,  file: file, line: line)
        XCTAssertEqual({                lhs /  rhs             }(), quotient,  file: file, line: line)
        
        XCTAssertEqual({ var lhs = lhs; lhs %= rhs; return D(lhs) }(), remainder, file: file, line: line)
        XCTAssertEqual({                lhs %  rhs                }(), remainder, file: file, line: line)
        
        XCTAssertEqual({ lhs.quotientAndRemainder(dividingBy: rhs).quotient  }(), quotient,  file: file, line: line)
        XCTAssertEqual({ lhs.quotientAndRemainder(dividingBy: rhs).remainder }(), remainder, file: file, line: line)
    }
        
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.divideReportingOverflow(by: rhs); return lhs  }(), quotient, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.divideReportingOverflow(by: rhs)              }(), overflow, file: file, line: line)
    XCTAssertEqual({                   lhs.dividedReportingOverflow(by: rhs).partialValue    }(), quotient, file: file, line: line)
    XCTAssertEqual({                   lhs.dividedReportingOverflow(by: rhs).overflow        }(), overflow, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; _ =    lhs.formRemainderReportingOverflow(dividingBy: rhs); return D(lhs)  }(), remainder, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; return lhs.formRemainderReportingOverflow(dividingBy: rhs)                 }(), overflow,  file: file, line: line)
    XCTAssertEqual({                        lhs.remainderReportingOverflow(dividingBy: rhs).partialValue       }(), remainder, file: file, line: line)
    XCTAssertEqual({                        lhs.remainderReportingOverflow(dividingBy: rhs).overflow           }(), overflow,  file: file, line: line)
    
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.quotient  }(), quotient,  file: file, line: line)
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).partialValue.remainder }(), remainder, file: file, line: line)
    XCTAssertEqual({ lhs.quotientAndRemainderReportingOverflow(dividingBy: rhs).overflow               }(), overflow,  file: file, line: line)
}
