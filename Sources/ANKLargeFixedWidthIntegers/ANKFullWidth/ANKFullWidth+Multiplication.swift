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
// MARK: * ANK x Full Width x Multiplication
//*============================================================================*

extension ANKFullWidth {
    
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
        let lhsIsLessThanZero =   self.isLessThanZero
        let rhsIsLessThanZero = amount.isLessThanZero
        //=--------------------------------------=
        var product = DoubleWidth()
        //=--------------------------------------=
        self  .withUnsafeWords { LHS in
        amount.withUnsafeWords { RHS in
        product.withUnsafeMutableWords { PRODUCT in
            //=----------------------------------=
            var carry =  UInt()
            for lhsIndex in LHS.indices {
            for rhsIndex in RHS.indices {
                let lhsWord = LHS[unchecked: lhsIndex]
                let rhsWord = RHS[unchecked: rhsIndex]
                carry = PRODUCT[unchecked: lhsIndex &+ rhsIndex].addFullWidth(carry, multiplicands:(lhsWord, rhsWord))
            }}
            //=----------------------------------=
            if  lhsIsLessThanZero {
                var carry = true; for rhsIndex in RHS.indices {
                    let word = ~RHS[unchecked: rhsIndex]
                    carry = PRODUCT[unchecked: LHS.count &+ rhsIndex].addReportingOverflow(word, carry)
                }
            }
            //=----------------------------------=
            if  rhsIsLessThanZero {
                var carry = true; for lhsIndex in LHS.indices {
                    let word = ~LHS[unchecked: lhsIndex]
                    carry = PRODUCT[unchecked: lhsIndex &+ RHS.count].addReportingOverflow(word, carry)
                }
            }
        }}}
        //=--------------------------------------=
        return HL(product.high, product.low)
    }
}
