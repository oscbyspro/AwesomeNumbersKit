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
        precondition(!overflow, ANK.callsiteOverflowInfo())
    }
    
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.dividedReportingOverflow(by: rhs)
        precondition(!pvo.overflow, ANK.callsiteOverflowInfo())
        return pvo.partialValue as Self
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        let overflow: Bool = lhs.formRemainderReportingOverflow(dividingBy: rhs)
        precondition(!overflow, ANK.callsiteOverflowInfo())
    }
    
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.remainderReportingOverflow(dividingBy: rhs)
        precondition(!pvo.overflow, ANK.callsiteOverflowInfo())
        return pvo.partialValue as Self
    }
    
    @_transparent public func quotientAndRemainder(dividingBy other: Self) -> QR<Self, Self> {
        let qro: PVO<QR<Self, Self>> = self.quotientAndRemainderReportingOverflow(dividingBy: other)
        precondition(!qro.overflow, ANK.callsiteOverflowInfo())
        return qro.partialValue as QR<Self, Self>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by other: Self) -> Bool {
        self.sign = self.sign ^ other.sign
        return self.magnitude.divideReportingOverflow(by: other.magnitude)
    }
    
    @inlinable public func dividedReportingOverflow(by other: Self) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.dividedReportingOverflow(by: other.magnitude)
        return PVO(Self(pvo.partialValue, as: self.sign ^ other.sign), pvo.overflow)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(dividingBy other: Self) -> Bool {
        self.magnitude.formRemainderReportingOverflow(dividingBy: other.magnitude)
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy other: Self) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.remainderReportingOverflow(dividingBy: other.magnitude)
        return PVO(Self(pvo.partialValue, as: self.sign), pvo.overflow)
    }
    
    @inlinable public func quotientAndRemainderReportingOverflow(dividingBy other: Self) -> PVO<QR<Self, Self>> {
        let qro: PVO<QR<Magnitude, Magnitude>> = self.magnitude.quotientAndRemainderReportingOverflow(dividingBy: other.magnitude)
        return PVO(QR(Self(qro.partialValue.quotient, as: self.sign ^ other.sign), Self(qro.partialValue.remainder, as: self.sign)), qro.overflow)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Division
//*============================================================================*

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func dividingFullWidth(_ other: HL<Self, Magnitude>) -> QR<Self, Self> {
        let unsigned  = self.magnitude.dividingFullWidth(HL(other.high.magnitude, other.low))
        let quotient  = Self(unsigned.quotient,  as: other.high.sign ^ self.sign)
        let remainder = Self(unsigned.remainder, as: other.high.sign   /*-----*/)
        return QR(quotient, remainder)
    }
    
    @inlinable public func dividingFullWidthReportingOverflow(_ other: HL<Self, Magnitude>) -> PVO<QR<Self, Self>> {
        let unsigned  = self.magnitude.dividingFullWidthReportingOverflow(HL(other.high.magnitude, other.low))
        let quotient  = Self(unsigned.partialValue.quotient,  as: other.high.sign ^ self.sign)
        let remainder = Self(unsigned.partialValue.remainder, as: other.high.sign   /*-----*/)
        return PVO(QR(quotient, remainder), unsigned.overflow)
    }
}
