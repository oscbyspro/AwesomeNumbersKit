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
// MARK: * ANK x Integer x Division
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func /=(lhs: inout Self, rhs: Self) {
        lhs.body /= rhs.body
    }
    
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body / rhs.body)
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        lhs.body %= rhs.body
    }
    
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        Self(bitPattern: lhs.body % rhs.body)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        self.body.divideReportingOverflow(by: divisor.body)
    }
    
    @_transparent public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        let pvo: PVO<Body> = self.body.dividedReportingOverflow(by: divisor.body)
        return   PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        self.body.formRemainderReportingOverflow(by: divisor.body)
    }
    
    @_transparent public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        let pvo: PVO<Body> = self.body.remainderReportingOverflow(dividingBy: divisor.body)
        return   PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let qr: QR<Body, Body> = self.body.quotientAndRemainder(dividingBy: divisor.body)
        return  QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
    
    @_transparent public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let qr: QR<Body, Body> = self.body.dividingFullWidth((dividend.high.body, dividend.low.body))
        return  QR(Self(bitPattern: qr.quotient), Self(bitPattern: qr.remainder))
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Division x Digit
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
        let pvo: PVO<Body> = self.body.dividedReportingOverflow(by: divisor)
        return   PVO(Self(bitPattern: pvo.partialValue), pvo.overflow)
    }
    
    @_transparent public mutating func formRemainderReportingOverflow(by divisor: Digit) -> Bool {
        self.body.formRemainderReportingOverflow(by: divisor)
    }
    
    @_transparent public func remainderReportingOverflow(dividingBy divisor: Digit) -> PVO<Digit> {
        self.body.remainderReportingOverflow(dividingBy: divisor)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public func quotientAndRemainder(dividingBy divisor: Digit) -> QR<Self, Digit> {
        let qr: QR<Body, Digit> = self.body.quotientAndRemainder(dividingBy: divisor)
        return  QR(Self(bitPattern: qr.quotient), qr.remainder)
    }
}
