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
// MARK: * ANK x Signed x Multiplication
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        lhs.sign = lhs.sign ^ rhs.sign
        lhs.magnitude *= rhs.magnitude
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        Self(lhs.magnitude * rhs.magnitude, as: lhs.sign ^ rhs.sign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Multiplication
//*============================================================================*

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=

    @_transparent public static func &*=(lhs: inout Self, rhs: Self) {
        _ = lhs.multiplyReportingOverflow(by: rhs)
    }

    @_transparent public static func &*(lhs: Self, rhs: Self) -> Self {
        lhs.multipliedReportingOverflow(by: rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        self.sign = self.sign ^ amount.sign
        return self.magnitude.multiplyReportingOverflow(by: amount.magnitude)
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.multipliedReportingOverflow(by: amount.magnitude)
        return   PVO(Self(pvo.partialValue, as: self.sign ^ amount.sign), pvo.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        self.sign = self.sign ^ amount.sign
        let high: Magnitude = self.magnitude.multiplyFullWidth(by: amount.magnitude)
        return Self(high, as: self.sign)
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let product: HL<Magnitude, Magnitude> = self.magnitude.multipliedFullWidth(by: amount.magnitude)
        return HL(Self(product.high, as: self.sign ^ amount.sign), product.low)
    }
}
