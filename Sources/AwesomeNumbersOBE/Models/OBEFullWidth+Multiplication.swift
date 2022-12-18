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
// MARK: * OBE x Full Width x Multiplication
//*============================================================================*

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        let o = lhs.multiplyReportingOverflow(by: rhs); precondition(!o)
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable mutating func multiplyFullWidth(by amount: Self) -> Self {
        let (high, low) = self.multipliedFullWidth(by: amount); self = Self(bitPattern: low); return high
    }
    
    @inlinable func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let lhs = self, rhs = amount; var product = DoubleWidth()
        //=--------------------------------------=
        //
        //=--------------------------------------=
        lhs.withUnsafeWords { LHS in
        rhs.withUnsafeWords { RHS in
        product.withUnsafeMutableWords { PRODUCT in
            //=----------------------------------=
            // LHS x RHS
            //=----------------------------------=
            for lhsIndex in LHS.indices {
                var carry = UInt()
                var productIndex = lhsIndex
                //=------------------------------=
                //
                //=------------------------------=
                for rhsIndex in RHS.indices {
                    let lhsWord = LHS[lhsIndex]
                    let rhsWord = RHS[rhsIndex]
                    carry = PRODUCT[productIndex].addFullWidth(carry, multiplicands:(lhsWord, rhsWord))
                    PRODUCT.formIndex(after: &productIndex)
                }
                //=------------------------------=
                //
                //=------------------------------=
                var overflow = PRODUCT[productIndex].addReportingOverflow(carry)
                while overflow {
                    PRODUCT.formIndex(after: &productIndex)
                    overflow = PRODUCT[productIndex].addReportingOverflow(1 as UInt)
                }
            }
            //=----------------------------------=
            // RHS x LHS Sign
            //=----------------------------------=
            if  lhs.isLessThanZero {
                var carry = true
                var productIndex = LHS.count
                for rhsIndex  in RHS.indices {
                    carry = PRODUCT[productIndex].addReportingOverflow(UInt(carry ? 1 : 0))
                    carry = PRODUCT[productIndex].addReportingOverflow(~RHS[rhsIndex]) || carry
                    PRODUCT.formIndex(after: &productIndex)
                }
            }
            //=----------------------------------=
            // LHS x RHS Sign
            //=----------------------------------=
            if  rhs.isLessThanZero {
                var carry = true
                var productIndex = RHS.count
                for lhsIndex  in LHS.indices {
                    carry = PRODUCT[productIndex].addReportingOverflow(UInt(carry ? 1 : 0))
                    carry = PRODUCT[productIndex].addReportingOverflow(~LHS[lhsIndex]) || carry
                    PRODUCT.formIndex(after: &productIndex)
                }
            }
        }}}
        //=--------------------------------------=
        //
        //=--------------------------------------=
        return HL(product.high, product.low)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Double Width x Multiplication
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
// MARK: * OBE x Full Width x Double Width x Unsigned x Multiplication
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

        let s0 = Magnitude(descending:Low.sum(m0.high, m1.low,  m2.low))
        let s1 = Magnitude(descending:Low.sum(m1.high, m2.high, m3.low))

        let r0 = Magnitude(descending:(s0.low,  m0.low ))
        let r1 = Magnitude(descending:(m3.high, s0.high)) &+ s1
        return DoubleWidth(descending:(r1, r0))
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Unsigned x Multiplication x Small
//*============================================================================*

extension OBEFullWidth where High: UnsignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidth(by rhs: UInt) -> UInt {
        var last = UInt(repeating: self.isLessThanZero)
        return self.withUnsafeMutableWords { LHS in
            var carry  = UInt()
            for lhsIndex in LHS.indices {
                let upper = LHS[lhsIndex].multiplyFullWidth(by:  rhs)
                let extra = LHS[lhsIndex].addReportingOverflow(carry)
                carry = extra ? (upper + 1) : upper
            }
            
            let _ = last.multiplyFullWidth(by:  rhs)
            let _ = last.addReportingOverflow(carry)
            return  last
        }
    }
    
    @inlinable func multipliedFullWidth(by rhs: UInt) -> HL<UInt, Magnitude> {
        var lhs = self; let rhs = lhs.multiplyFullWidth(by: rhs); return (rhs, Magnitude(bitPattern: lhs))
    }
}
