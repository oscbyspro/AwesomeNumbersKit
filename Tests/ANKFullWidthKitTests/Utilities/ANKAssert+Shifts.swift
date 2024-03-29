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
// MARK: * ANK x Assert x Shifts
//*============================================================================*

func ANKAssertShiftLeft<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    let (words, bits) = rhs.quotientAndRemainder(dividingBy: UInt.bitWidth)
    //=------------------------------------------=
    XCTAssertEqual(                 lhs <<   rhs,                 result, file: file, line: line)
    XCTAssertEqual(                 lhs >>  -rhs,                 result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs <<=  rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs >>= -rhs; return lhs }(), result, file: file, line: line)
        
    XCTAssertEqual(lhs.bitshiftedLeftSmart(by:   rhs), result, file: file, line: line)
    XCTAssertEqual(lhs.bitshiftedRightSmart(by: -rhs), result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftSmart(by:   rhs); return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightSmart(by: -rhs); return lhs }(), result, file: file, line: line)
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs {
        XCTAssertEqual(                 lhs &<<  rhs,                 result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs &<<= rhs; return lhs }(), result, file: file, line: line)
    }
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs {
        XCTAssertEqual(lhs.bitshiftedLeft(by: rhs), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeft(by: rhs); return lhs }(), result, file: file, line: line)
        
        XCTAssertEqual(lhs.bitshiftedLeft(words: words, bits: bits), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeft(words: words, bits: bits); return lhs }(), result, file: file, line: line)
    }
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs, bits.isZero {
        XCTAssertEqual(lhs.bitshiftedLeft(words: words), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeft(words: words); return lhs }(), result, file: file, line: line)
    }
}

func ANKAssertShiftRight<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>,
file: StaticString = #file, line: UInt = #line) {
    //=------------------------------------------=
    let (words, bits) = rhs.quotientAndRemainder(dividingBy: UInt.bitWidth)
    //=------------------------------------------=
    XCTAssertEqual(                 lhs >>   rhs,                 result, file: file, line: line)
    XCTAssertEqual(                 lhs <<  -rhs,                 result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs >>=  rhs; return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs <<= -rhs; return lhs }(), result, file: file, line: line)
        
    XCTAssertEqual(lhs.bitshiftedRightSmart(by: rhs), result, file: file, line: line)
    XCTAssertEqual(lhs.bitshiftedLeftSmart(by: -rhs), result, file: file, line: line)
    
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRightSmart(by: rhs); return lhs }(), result, file: file, line: line)
    XCTAssertEqual({ var lhs = lhs; lhs.bitshiftLeftSmart(by: -rhs); return lhs }(), result, file: file, line: line)
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs {
        XCTAssertEqual(                 lhs &>>  rhs,                 result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs &>>= rhs; return lhs }(), result, file: file, line: line)
    }
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs {
        XCTAssertEqual(lhs.bitshiftedRight(by: rhs), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRight(by: rhs); return lhs }(), result, file: file, line: line)
        
        XCTAssertEqual(lhs.bitshiftedRight(words: words, bits: bits), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRight(words: words, bits: bits); return lhs }(), result, file: file, line: line)
    }
    //=------------------------------------------=
    if  0 ..< lhs.bitWidth ~= rhs, bits.isZero {
        XCTAssertEqual(lhs.bitshiftedRight(words: words), result, file: file, line: line)
        XCTAssertEqual({ var lhs = lhs; lhs.bitshiftRight(words: words); return lhs }(), result, file: file, line: line)
    }
}

//*============================================================================*
// MARK: * ANK x Assert x Shifts x Masked
//*============================================================================*

func ANKAssertShiftLeftByMasking<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger, S: ANKFixedWidthInteger & ANKSignedInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>, signitude: S.Type,
file: StaticString = #file, line: UInt = #line) where S.Digit: ANKCoreInteger<UInt> {
    //=------------------------------------------=
    typealias T  = ANKFullWidth<H, L>
    typealias M  = ANKFullWidth<H, L>.Magnitude
    typealias S2 = ANKFullWidth<S, S .Magnitude>
    typealias M2 = ANKFullWidth<S, S .Magnitude>.Magnitude
    precondition(S.Magnitude.self == M.self)
    //=------------------------------------------=
    func ANKAssertWith(_ lhs: T, _ rhs: Int, _ result: T) {
        XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  S(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<< S2(rhs), result, file: file, line: line)
        guard !rhs.isLessThanZero else { return }
        XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<< M2(rhs), result, file: file, line: line)
    }
    
    ANKAssertWith(lhs, rhs,                result)
    ANKAssertWith(lhs, rhs + lhs.bitWidth, result)
    ANKAssertWith(lhs, rhs - lhs.bitWidth, result)
    //=------------------------------------------=
    func ANKAssertWithProtocolWitnessesOf<T>(_ lhs: T, _ rhs: Int, _ result: T) where T: ANKFixedWidthInteger {
        XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  S(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<< S2(rhs), result, file: file, line: line)
        guard !rhs.isLessThanZero else { return }
        XCTAssertEqual(lhs &<<   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<<  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &<< M2(rhs), result, file: file, line: line)
    }
    
    ANKAssertWithProtocolWitnessesOf(lhs, rhs,                result)
    ANKAssertWithProtocolWitnessesOf(lhs, rhs + lhs.bitWidth, result)
    ANKAssertWithProtocolWitnessesOf(lhs, rhs - lhs.bitWidth, result)
}

func ANKAssertShiftRightByMasking<H: ANKFixedWidthInteger, L: ANKFixedWidthInteger, S: ANKFixedWidthInteger & ANKSignedInteger>(
_ lhs: ANKFullWidth<H, L>, _ rhs:  Int, _ result: ANKFullWidth<H, L>, signitude: S.Type,
file: StaticString = #file, line: UInt = #line) where S.Digit: ANKCoreInteger<UInt> {
    //=------------------------------------------=
    typealias T  = ANKFullWidth<H, L>
    typealias M  = ANKFullWidth<H, L>.Magnitude
    typealias S2 = ANKFullWidth<S, S .Magnitude>
    typealias M2 = ANKFullWidth<S, S .Magnitude>.Magnitude
    precondition(S.Magnitude.self == M.self)
    //=------------------------------------------=
    func ANKAssertWith(_ lhs: ANKFullWidth<H, L>, _ rhs: Int, _ result: ANKFullWidth<H, L>) {
        XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  S(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>> S2(rhs), result, file: file, line: line)
        guard !rhs.isLessThanZero else { return }
        XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>> M2(rhs), result, file: file, line: line)
    }
    
    ANKAssertWith(lhs, rhs,                result)
    ANKAssertWith(lhs, rhs + lhs.bitWidth, result)
    ANKAssertWith(lhs, rhs - lhs.bitWidth, result)
    //=------------------------------------------=
    func ANKAssertWithProtocolWitnessesOf<T>(_ lhs: T, _ rhs: Int, _ result: T) where T: ANKFixedWidthInteger {
        XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  S(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>> S2(rhs), result, file: file, line: line)
        guard !rhs.isLessThanZero else { return }
        XCTAssertEqual(lhs &>>   (rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>>  M(rhs), result, file: file, line: line)
        XCTAssertEqual(lhs &>> M2(rhs), result, file: file, line: line)
    }
    
    ANKAssertWithProtocolWitnessesOf(lhs, rhs,                result)
    ANKAssertWithProtocolWitnessesOf(lhs, rhs + lhs.bitWidth, result)
    ANKAssertWithProtocolWitnessesOf(lhs, rhs - lhs.bitWidth, result)
}
