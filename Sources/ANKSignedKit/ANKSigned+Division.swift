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
// MARK: * ANK x Signed x Division
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static func /=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.divideReportingOverflow(by: rhs)
        precondition(!overflow)
    }
    
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow)
    }
    
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow)
        return pvo.partialValue as Self
    }
    
    @_transparent public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let qro: PVO<QR<Self, Self>> = self.quotientAndRemainderReportingOverflow(dividingBy: divisor)
        precondition(!qro.overflow)
        return qro.partialValue as QR<Self, Self>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.dividedReportingOverflow(by: divisor.magnitude)
        let quotient = Self(pvo.partialValue, as: self.sign ^ divisor.sign)
        return PVO(quotient, pvo.overflow)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(dividingBy divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: divisor)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.remainderReportingOverflow(dividingBy: divisor.magnitude)
        let remainder = Self(pvo.partialValue, as: self.sign)
        return PVO(remainder, pvo.overflow)
    }
    
    @inlinable public func quotientAndRemainderReportingOverflow(dividingBy divisor: Self) -> PVO<QR<Self, Self>> {
        let qro: PVO<QR<Magnitude, Magnitude>> = self.magnitude.quotientAndRemainderReportingOverflow(dividingBy: divisor.magnitude)
        let quotient  = Self(qro.partialValue.quotient,  as: self.sign ^ divisor.sign)
        let remainder = Self(qro.partialValue.remainder, as: self.sign /*----------*/)
        return PVO(QR(quotient, remainder), qro.overflow)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Division
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidth(_ dividend: HL<Self, Magnitude>) -> QR<Self, Self> {
        let qr: QR<Magnitude, Magnitude> = self.magnitude.dividingFullWidth(HL(dividend.high.magnitude, dividend.low))
        let quotient  = Self(qr.quotient,  as: dividend.high.sign ^ self.sign)
        let remainder = Self(qr.remainder, as: dividend.high.sign /*-------*/)
        return  QR(quotient,  remainder)
    }
}
