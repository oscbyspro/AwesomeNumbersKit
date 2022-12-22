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
// MARK: * ANK x Full Width x Double Width x Multiplication x Karatsuba
//*============================================================================*

extension ANKFullWidth where High.Magnitude == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyAsKaratsuba(by amount: Self) {
        let o = self.multiplyReportingOverflowAsKaratsuba(by: amount); precondition(!o)
    }
    
    @inlinable func multipliedAsKaratsuba(by amount: Self) -> Self {
        let (pv, o) = self.multipliedReportingOverflowAsKaratsuba(by: amount); precondition(!o); return pv
    }
    
    @inlinable mutating func multiplyReportingOverflowAsKaratsuba(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflowAsKaratsuba(by: amount); return o
    }
    
    @inlinable func multipliedReportingOverflowAsKaratsuba(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidthAsKaratsuba(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable mutating func multiplyFullWidthAsKaratsuba(by amount: Self) -> Self {
        let product = self.multipliedFullWidthAsKaratsuba(by: amount)
        self = Self(bitPattern: product.low )
        return Self(bitPattern: product.high)
    }
    
    @inlinable func multipliedFullWidthAsKaratsuba(by amount: Self) -> DoubleWidth {
        let negate  = self.isLessThanZero != amount.isLessThanZero
        var product = self.magnitude.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.magnitude)
        if  negate  { product.formTwosComplement() } // cannot overflow: abs < max
        return DoubleWidth(descending:(Self(bitPattern: product.high), product.low))
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Double Width x Unsigned x Multiplication x Karatsuba
//*============================================================================*

extension ANKFullWidth where High == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedFullWidthAsKaratsubaAsUnsigned(by amount: Self) -> DoubleWidth {
        //=--------------------------------------=
        func sum(_ x0: Low, _ x1: Low, _ x2: Low) -> HL<UInt, Low> {
            let (x3, o3) = x0.addingReportingOverflow(x1) as (Low, Bool)
            let (x4, o4) = x3.addingReportingOverflow(x2) as (Low, Bool)
            return HL(UInt(bit: o3) &+ UInt(bit: o4), x4)
        }
        //=--------------------------------------=
        let m0 = self.low .multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m1 = self.low .multipliedFullWidth(by: amount.high) as HL<Low, Low>
        let m2 = self.high.multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m3 = self.high.multipliedFullWidth(by: amount.high) as HL<Low, Low>
        //=--------------------------------------=
        let s0 = sum(m0.high, m1.low,  m2.low) as HL<UInt, Low>
        let s1 = sum(m1.high, m2.high, m3.low) as HL<UInt, Low>
        //=--------------------------------------=
        let r0 = Magnitude(descending:(s0.low,  m0.low))
        var r1 = Magnitude(descending:(m3.high, Low(_truncatingBits: s0.high)))
        let o0 = r1.low .addReportingOverflow(s1.low)
        let o1 = r1.high.addReportingOverflow(s1.high &+ Digit(bit: o0))
        //=--------------------------------------=
        assert(!o1); return DoubleWidth(descending:(r1, r0))
    }
}
