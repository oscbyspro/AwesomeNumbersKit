//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit
@testable import ANKFullWidthKit
import XCTest

//*============================================================================*
// MARK: * ANK x Assert x Shifts
//*============================================================================*

func ANKAssertShiftLeft<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    //=--------------------------------------=
    let (words, bits) = rhs.quotientAndRemainder(dividingBy: UInt.bitWidth)
    //=--------------------------------------=
    XCTAssertEqual(                 lhs <<   rhs,                 result, file: file, line: line)
    XCTAssertEqual(                 lhs >>  -rhs,                 result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs <<=  rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs >>= -rhs; return lhs }(), result, file: file, line: line)
        
    XCTAssertEqual(lhs.bitshiftedLeftSmart(by:   rhs), result, file: file, line: line)
    XCTAssertEqual(lhs.bitshiftedRightSmart(by: -rhs), result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftSmart(by:   rhs); return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightSmart(by: -rhs); return lhs }(), result, file: file, line: line)
    //=--------------------------------------=
    if (0 ..< lhs.bitWidth) ~= rhs {
        XCTAssertEqual(                 lhs &<<  rhs,                 result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs &<<= rhs; return lhs }(), result, file: file, line: line)
    }
    //=--------------------------------------=
    if (0 ..< lhs.bitWidth) ~= rhs {
        XCTAssertEqual(lhs.bitshiftedLeftUnchecked(by: rhs), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftUnchecked(by: rhs); return lhs }(), result, file: file, line: line)
        
        XCTAssertEqual(lhs.bitshiftedLeftUnchecked(words: words, bits: bits), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftUnchecked(words: words, bits: bits); return lhs }(), result, file: file, line: line)
    }
}

func ANKAssertShiftRight<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    //=--------------------------------------=
    let (words, bits) = rhs.quotientAndRemainder(dividingBy: UInt.bitWidth)
    //=--------------------------------------=
    XCTAssertEqual(                 lhs >>   rhs,                 result, file: file, line: line)
    XCTAssertEqual(                 lhs <<  -rhs,                 result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs >>=  rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs <<= -rhs; return lhs }(), result, file: file, line: line)
        
    XCTAssertEqual(lhs.bitshiftedRightSmart(by: rhs), result, file: file, line: line)
    XCTAssertEqual(lhs.bitshiftedLeftSmart(by: -rhs), result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightSmart(by: rhs); return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftSmart(by: -rhs); return lhs }(), result, file: file, line: line)
    //=--------------------------------------=
    if (0 ..< lhs.bitWidth) ~= rhs {
        XCTAssertEqual(                 lhs &>>  rhs,                 result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs &>>= rhs; return lhs }(), result, file: file, line: line)
    }
    //=--------------------------------------=
    if (0 ..< lhs.bitWidth) ~= rhs {
        XCTAssertEqual(lhs.bitshiftedRightUnchecked(by: rhs), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightUnchecked(by: rhs); return lhs }(), result, file: file, line: line)
        
        XCTAssertEqual(lhs.bitshiftedRightUnchecked(words: words, bits: bits), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightUnchecked(words: words, bits: bits); return lhs }(), result, file: file, line: line)
    }
}

//*============================================================================*
// MARK: * ANK x Assert x Shifts x Masked
//*============================================================================*

func ANKAssertShiftLeftByMasking<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger, S: ANKFixedWidthInteger & ANKSignedInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>, signitude: S.Type,
file: StaticString = #file, line: UInt = #line) where S.Digit: ANKCoreInteger<UInt> {
    //=--------------------------------------=
    typealias T  = ANKFullWidth<H, L>
    typealias M  = ANKFullWidth<H, L>.Magnitude
    typealias S2 = ANKFullWidth<S, S .Magnitude>
    typealias M2 = ANKFullWidth<S, S .Magnitude>.Magnitude
    XCTAssert(S.Magnitude.self == M.self, file: file, line: line)
    //=--------------------------------------=
    let moduloBitWidth = (rhs % lhs.bitWidth) + (rhs.isLessThanZero ? lhs.bitWidth : 0)
    //=--------------------------------------=
    XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(rhs), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(rhs), result, file: file, line: line)
    
    XCTAssertEqual(lhs &<<   (rhs + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(rhs + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(rhs + lhs.bitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &<<   (rhs - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(rhs - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(rhs - lhs.bitWidth), result, file: file, line: line)
    //=--------------------------------------=
    if !rhs.isLessThanZero {
        XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<< M2(rhs), result, file: file, line: line)
    }
    
    if  rhs > lhs.bitWidth.negated() {
        XCTAssertEqual(lhs &<<   (rhs + lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  M(rhs + lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &<< M2(rhs + lhs.bitWidth), result, file: file, line: line)
    }
    
    if  rhs > lhs.bitWidth {
        XCTAssertEqual(lhs &<<   (rhs - lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  M(rhs - lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &<< M2(rhs - lhs.bitWidth), result, file: file, line: line)
    }
    //=--------------------------------------=
    XCTAssertEqual(lhs &<<   (moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(moduloBitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &<<   (moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &<<   (moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  S(moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< S2(moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    //=--------------------------------------=
    XCTAssertEqual(lhs &<<   (moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  M(moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< M2(moduloBitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &<<   (moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<<  M(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &<< M2(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
}

func ANKAssertShiftRightByMasking<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger, S: ANKFixedWidthInteger & ANKSignedInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>, signitude: S.Type,
file: StaticString = #file, line: UInt = #line) where S.Digit: ANKCoreInteger<UInt> {
    //=--------------------------------------=
    typealias T  = ANKFullWidth<H, L>
    typealias M  = ANKFullWidth<H, L>.Magnitude
    typealias S2 = ANKFullWidth<S, S .Magnitude>
    typealias M2 = ANKFullWidth<S, S .Magnitude>.Magnitude
    XCTAssert(S.Magnitude.self == M.self, file: file, line: line)
    //=--------------------------------------=
    let moduloBitWidth = (rhs % lhs.bitWidth) + (rhs.isLessThanZero ? lhs.bitWidth : 0)
    //=--------------------------------------=
    XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(rhs), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(rhs), result, file: file, line: line)
    
    XCTAssertEqual(lhs &>>   (rhs + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(rhs + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(rhs + lhs.bitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &>>   (rhs - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(rhs - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(rhs - lhs.bitWidth), result, file: file, line: line)
    //=--------------------------------------=
    if !rhs.isLessThanZero {
        XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>> M2(rhs), result, file: file, line: line)
    }
    
    if  rhs > lhs.bitWidth.negated() {
        XCTAssertEqual(lhs &>>   (rhs + lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  M(rhs + lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &>> M2(rhs + lhs.bitWidth), result, file: file, line: line)
    }
    
    if  rhs > lhs.bitWidth {
        XCTAssertEqual(lhs &>>   (rhs - lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  M(rhs - lhs.bitWidth), result, file: file, line: line)
        XCTAssertEqual(lhs &>> M2(rhs - lhs.bitWidth), result, file: file, line: line)
    }
    //=--------------------------------------=
    XCTAssertEqual(lhs &>>   (moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(moduloBitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &>>   (moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &>>   (moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  S(moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> S2(moduloBitWidth - lhs.bitWidth), result, file: file, line: line)
    //=--------------------------------------=
    XCTAssertEqual(lhs &>>   (moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  M(moduloBitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> M2(moduloBitWidth), result, file: file, line: line)
    
    XCTAssertEqual(lhs &>>   (moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>>  M(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
    XCTAssertEqual(lhs &>> M2(moduloBitWidth + lhs.bitWidth), result, file: file, line: line)
}
