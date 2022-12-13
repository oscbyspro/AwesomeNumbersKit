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
// MARK: * OBE x Full Width x Integer x Multiplication
//*============================================================================*

extension OBEFullWidthInteger where High.Magnitude == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidthAsKaratsuba(by amount: Self) -> Self {
        let product = multipliedFullWidthAsKaratsuba(by: amount)
        self = Self(bitPattern: product.low);
        return Self(bitPattern: product.high)
    }
    
    @inlinable func multipliedFullWidthAsKaratsuba(by amount: Self) -> OBEFullWidth<Self, Magnitude> {
        let negate  = self.isLessThanZero != amount.isLessThanZero
        var product = self.magnitude.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.magnitude)
        if  negate  { product.formTwosComplement() }
        return unsafeBitCast(product, to: OBEFullWidth<Self, Magnitude>.self) // TODO: without unsafeBitCast
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Integer x Unsigned x Multiplication
//*============================================================================*

extension OBEFullWidthInteger where High == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedFullWidthAsKaratsubaAsUnsigned(by amount: Self) -> OBEFullWidth<Self, Magnitude> {
        let m0 = self.low .multipliedFullWidth(by: amount.low )
        let m1 = self.low .multipliedFullWidth(by: amount.high)
        let m2 = self.high.multipliedFullWidth(by: amount.low )
        let m3 = self.high.multipliedFullWidth(by: amount.high)

        let s0 = Magnitude(descending:Low.sum(m0.high, m1.low,  m2.low))
        let s1 = Magnitude(descending:Low.sum(m1.high, m2.high, m3.low))

        let r0 = Magnitude(descending:(s0.low,  m0.low ))
        let r1 = Magnitude(descending:(m3.high, s0.high)) &+ s1
        return OBEFullWidth<Self, Magnitude>(descending:(r1, r0))
    }
}
