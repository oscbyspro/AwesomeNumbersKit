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
// MARK: * ANK x Signed x Large x Multiplication
//*============================================================================*

extension ANKSigned where Magnitude: ANKLargeBinaryIntegerWhereDigitIsNotSelf {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @_transparent public static func *=(lhs: inout Self, rhs: Digit) {
        lhs = lhs * rhs
    }
    
    @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        Self(lhs.magnitude * rhs.magnitude, as: lhs.sign ^ rhs.sign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Large x Fixed Width x Multiplication
//*============================================================================*

extension ANKSigned where Magnitude: ANKLargeBinaryIntegerWhereDigitIsNotSelf & ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by  amount: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.multipliedReportingOverflow(by: amount.magnitude)
        return   PVO(Self(pvo.partialValue, as: self.sign ^ amount.sign), pvo.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(hl.low, as: ANKSign.plus); return hl.high
    }
    
    @inlinable public func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        let hl: HL<Magnitude.Digit, Magnitude> = self.magnitude.multipliedFullWidth(by: amount.magnitude)
        return  HL(Digit(hl.high, as: self.sign ^ amount.sign), hl.low)
    }
}
