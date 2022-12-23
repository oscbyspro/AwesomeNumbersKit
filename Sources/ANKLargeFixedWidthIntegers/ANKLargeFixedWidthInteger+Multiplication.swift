//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Multiplication
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func *=(lhs: inout Self, rhs: Self) {
        lhs.body.multiplyAsKaratsuba(by: rhs.body)
    }
    
    @_transparent public static func *(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body.multipliedAsKaratsuba(by: rhs.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        self.body.multiplyReportingOverflowAsKaratsuba(by: amount.body)
    }
    
    @_transparent public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let pvo = self.body.multipliedReportingOverflowAsKaratsuba(by: amount.body)
        return PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl = self.body.multipliedFullWidthAsKaratsuba(by: amount.body)
        self.body = Body(bitPattern: hl.low); return Self(bitPattern:  hl.high)
    }
    
    @_transparent public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let hl = self.body.multipliedFullWidthAsKaratsuba(by:  amount.body)
        return HL(Self(bitPattern: hl.high), Magnitude(bitPattern: hl.low))
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Multiplication x Digit
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func *=(lhs: inout Self, rhs: Digit) {
        lhs.body *= rhs
    }
    
    @_transparent public static func *(lhs: Self, rhs: Digit) -> Self {
        Self(bitPattern: lhs.body * rhs)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        self.body.multiplyReportingOverflow(by: amount)
    }
    
    @_transparent public func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let pvo = self.body.multipliedReportingOverflow(by: amount)
        return PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        self.body.multiplyFullWidth(by: amount)
    }
    
    @_transparent public func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        let hl = self.body.multipliedFullWidth(by: amount)
        return HL(hl.high, Magnitude(bitPattern:  hl.low))
    }
}
