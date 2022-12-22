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
// MARK: * ANK x Fixed Width Integer x Large x Division
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func /=(lhs: inout Self, rhs: Self) {
        lhs.body.divideAsKnuth(by: rhs.body)
    }
    
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body.dividedAsKnuth(by: rhs.body))
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        lhs.body.formRemainderAsKnuth(dividingBy: rhs.body)
    }
    
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body.remainderAsKnuth(dividingBy: rhs.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        self.body.divideReportingOverflowAsKnuth(by: divisor.body)
    }
    
    @_transparent public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        let pvo = self.body.dividedReportingOverflowAsKnuth(by: divisor.body)
        return PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        self.body.formRemainderReportingOverflowAsKnuth(by: divisor.body)
    }
    
    @_transparent public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        let pvo = self.body.remainderReportingOverflowAsKnuth(dividingBy: divisor.body)
        return PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func divideReportingRemainder(dividingBy divisor: Self) -> Self {
        Self(bitPattern: self.body.divideReportingRemainderAsKnuth(dividingBy: divisor.body))
    }
    
    @_transparent public mutating func formRemainderReportingQuotient(dividingBy divisor: Self) -> Self {
        Self(bitPattern: self.body.formRemainderReportingQuotientAsKnuth(dividingBy: divisor.body))
    }    
    
    @_transparent public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let qr = self.body.quotientAndRemainderAsKnuth(dividingBy: divisor.body)
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
    
    @_transparent public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let qr = self.body.dividingFullWidthAsKnuth((dividend.high.body, dividend.low.body))
        return QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Division x Digit
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func /=(lhs: inout Self, rhs: Digit) {
        lhs.body /= rhs
    }
    
    @_transparent public static func /(lhs: Self, rhs: Digit) -> Self {
        Self(bitPattern: lhs.body / rhs)
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Digit) {
        lhs.body %= rhs
    }
    
    @_transparent public static func %(lhs: Self, rhs: Digit) -> Digit {
        lhs.body % rhs
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func divideReportingOverflow(by divisor: Digit) -> Bool {
        self.body.divideReportingOverflow(by: divisor)
    }
    
    @_transparent public func dividedReportingOverflow(by divisor: Digit) -> PVO<Self> {
        let pvo = self.body.dividedReportingOverflow(by: divisor)
        return PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool {
        self.body.formRemainderReportingOverflow(by: divisor)
    }
    
    @_transparent public func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        self.body.remainderReportingOverflow(dividingBy: divisor)
    }
    
    @_transparent public mutating func divideReportingRemainder(dividingBy divisor: Digit) -> Digit {
        self.body.divideReportingRemainder(dividingBy: divisor)
    }
    
    @_transparent public mutating func formRemainderReportingQuotient(dividingBy divisor: Digit) -> Self {
        Self(bitPattern: self.body.formRemainderReportingQuotient(dividingBy: divisor))
    }
    
    @_transparent public func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let qr = body.quotientAndRemainder(dividingBy: divisor)
        return QR(Self(bitPattern: qr.quotient),  qr.remainder)
    }
}
