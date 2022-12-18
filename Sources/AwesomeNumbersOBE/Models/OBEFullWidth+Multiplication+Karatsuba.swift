//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Double Width x Multiplication x Karatsuba
//*============================================================================*

extension OBEFullWidth where High.Magnitude == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidthAsKaratsuba(by amount: Self) -> Self {
        let product = multipliedFullWidthAsKaratsuba(by: amount)
        self = Self(bitPattern: product.low);
        return Self(bitPattern: product.high)
    }
    
    @inlinable func multipliedFullWidthAsKaratsuba(by amount: Self) -> DoubleWidth {
        let negate  = self.isLessThanZero != amount.isLessThanZero
        var product = self.magnitude.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.magnitude)
        if  negate  { product.formTwosComplement() }
        return DoubleWidth(descending:(Self(bitPattern: product.high), product.low))
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Double Width x Unsigned x Multiplication x Karatsuba
//*============================================================================*

extension OBEFullWidth where High == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedFullWidthAsKaratsubaAsUnsigned(by amount: Self) -> DoubleWidth {
        let m0 = self.low .multipliedFullWidth(by: amount.low )
        let m1 = self.low .multipliedFullWidth(by: amount.high)
        let m2 = self.high.multipliedFullWidth(by: amount.low )
        let m3 = self.high.multipliedFullWidth(by: amount.high)

        let s0 = OBEFullWidthKaratsubaMultiplication.sum(m0.high, m1.low,  m2.low)
        let s1 = OBEFullWidthKaratsubaMultiplication.sum(m1.high, m2.high, m3.low)

        let r0 = Magnitude(descending:(s0.low,  m0.low ))
        let r1 = Magnitude(descending:(m3.high, s0.high)) &+ s1
        return DoubleWidth(descending:(r1, r0))
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Multiplication x Karatsuba
//*============================================================================*

@usableFromInline enum OBEFullWidthKaratsubaMultiplication {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func sum<T>(_ x0: T, _ x1: T, _ x2: T) -> OBEFullWidth<T, T> {
        let (x3, o3) = x0.addingReportingOverflow(x1)
        let (x4, o4) = x3.addingReportingOverflow(x2)
        let (x5) = o3 && o4 ? 2 : o3 || o4 ? 1 : 0 as T
        return OBEFullWidth(descending:(x5, x4))
    }
}
