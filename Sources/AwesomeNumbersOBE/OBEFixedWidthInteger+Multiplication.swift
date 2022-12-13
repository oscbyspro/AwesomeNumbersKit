//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import AwesomeNumbersKit

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Multiplication
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let product = multipliedFullWidth(by: amount)
        self = Self(bitPattern: product.low); return product.high
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Multiplication x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let negate  = self.isLessThanZero != amount.isLessThanZero
        var product = OBEDoubleWidthInteger(descending: self.magnitude.multipliedFullWidth(by: amount.magnitude))
        if  negate  { product.formTwosComplement() }; return (Self(bitPattern: product.high), product.low)
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Multiplication x Unsigned
//*============================================================================*

extension OBEUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public func multipliedFullWidth(by  amount:Self) -> HL<Self, Magnitude> {
        let m0 = self.low .multipliedFullWidth(by: amount.low )
        let m1 = self.low .multipliedFullWidth(by: amount.high)
        let m2 = self.high.multipliedFullWidth(by: amount.low )
        let m3 = self.high.multipliedFullWidth(by: amount.high)
        
        let s0 = Magnitude(descending:Low.sum(m0.high, m1.low,  m2.low))
        let s1 = Magnitude(descending:Low.sum(m1.high, m2.high, m3.low))
        
        let r0 = Magnitude(descending:(s0.low,  m0.low ))
        let r1 = Magnitude(descending:(m3.high, s0.high)) &+ s1
        return HL(r1, r0)
    }
}
