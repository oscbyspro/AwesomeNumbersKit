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
// MARK: * ANK x Signed x Multiplication x Digit
//*============================================================================*

extension ANKSigned {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @_disfavoredOverload @inlinable public static func *=(lhs: inout Self, rhs: Digit) {
        lhs.sign = lhs.sign ^ rhs.sign
        lhs.magnitude *= rhs.magnitude
    }
    
    @_disfavoredOverload @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        Self(lhs.magnitude * rhs.magnitude, as: lhs.sign ^ rhs.sign)
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Multiplication x Digit
//*============================================================================*

extension ANKSigned where Magnitude: ANKFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @_transparent public static func &*=(lhs: inout Self, rhs: Digit) {
        _ = lhs.multiplyReportingOverflow(by: rhs)
    }

    @_disfavoredOverload @_transparent public static func &*(lhs: Self, rhs: Digit) -> Self {
        lhs.multipliedReportingOverflow(by: rhs).partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        self.sign = self.sign ^ amount.sign
        return self.magnitude.multiplyReportingOverflow(by: amount.magnitude)
    }
    
    @_disfavoredOverload @inlinable public func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let pvo: PVO<Magnitude> = self.magnitude.multipliedReportingOverflow(by: amount.magnitude)
        return   PVO(Self(pvo.partialValue, as: self.sign ^ amount.sign), pvo.overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_disfavoredOverload @inlinable public mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        self.sign = self.sign ^ amount.sign
        let high: Magnitude.Digit = self.magnitude.multiplyFullWidth(by: amount.magnitude)
        return Digit(high, as: self.sign)
    }
    
    @_disfavoredOverload @inlinable public func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        let product: HL<Magnitude.Digit, Magnitude> = self.magnitude.multipliedFullWidth(by: amount.magnitude)
        return HL(Digit(product.high, as: self.sign ^ amount.sign), product.low)
    }
}
