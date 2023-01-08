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
        lhs = lhs / rhs
    }
    
    @_transparent public static func /(lhs: Self, rhs: Self) -> Self {
        lhs.quotientAndRemainder(dividingBy: rhs).quotient
    }
    
    @_transparent public static func %=(lhs: inout Self, rhs: Self) {
        lhs = lhs % rhs
    }
    
    @_transparent public static func %(lhs: Self, rhs: Self) -> Self {
        lhs.quotientAndRemainder(dividingBy: rhs).remainder
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func divideReportingOverflow(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.dividedReportingOverflow(by: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func dividedReportingOverflow(by divisor: Self) -> PVO<Self> {
        divisor.isZero ? PVO(self, true) : PVO(self / divisor, false)
    }
    
    @inlinable public mutating func formRemainderReportingOverflow(by divisor: Self) -> Bool {
        let pvo: PVO<Self> = self.remainderReportingOverflow(dividingBy: divisor)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func remainderReportingOverflow(dividingBy divisor: Self) -> PVO<Self> {
        divisor.isZero ? PVO(self, true) : PVO(self % divisor, false)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func quotientAndRemainder(dividingBy divisor: Self) -> QR<Self, Self> {
        let qr: QR<Magnitude, Magnitude> = self.magnitude.quotientAndRemainder(dividingBy: divisor.magnitude)
        return  QR(Self(qr.quotient, as: self.sign ^ divisor.sign), Self(qr.remainder, as: self.sign))
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
        let qr: QR<Magnitude, Magnitude> = self.magnitude.dividingFullWidth((dividend.high.magnitude,  dividend.low))
        return  QR(Self(qr.quotient, as: dividend.high.sign ^ self.sign), Self(qr.remainder, as: dividend.high.sign))
    }
}
