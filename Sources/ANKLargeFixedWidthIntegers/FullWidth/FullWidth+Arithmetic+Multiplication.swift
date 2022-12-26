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
        precondition(!lhs.multiplyReportingOverflow(by: rhs))
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero: Bool = self.isLessThanZero != amount.isLessThanZero
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        let overflow: Bool = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @inlinable func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let lhsIsLessThanZero: Bool =   self.isLessThanZero
        let rhsIsLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        var product = DoubleWidth()
        //=--------------------------------------=
        self   .withUnsafeWords { LHS in
        amount .withUnsafeWords { RHS in
        product.withUnsafeMutableWords { PRODUCT in
            //=----------------------------------=
            var carry: UInt = UInt()
            for lhsIndex: Int in LHS.indices {
            for rhsIndex: Int in RHS.indices {
                let lhsWord: UInt = LHS[unchecked: lhsIndex]
                let rhsWord: UInt = RHS[unchecked: rhsIndex]
                let productIndex: Int = lhsIndex &+ rhsIndex
                carry = PRODUCT[unchecked: productIndex].addFullWidth(carry, multiplicands:(lhsWord, rhsWord))
            }}
            //=----------------------------------=
            if  lhsIsLessThanZero {
                var carry: Bool = true
                for rhsIndex: Int in  RHS.indices {
                    let word: UInt = ~RHS[unchecked: rhsIndex]
                    let productIndex: Int = rhsIndex &+ LHS.count
                    carry = PRODUCT[unchecked: productIndex].addReportingOverflow(word, carry)
                }
            }
            //=----------------------------------=
            if  rhsIsLessThanZero {
                var carry: Bool = true
                for lhsIndex: Int in  LHS.indices {
                    let word: UInt = ~LHS[unchecked: lhsIndex]
                    let productIndex: Int = lhsIndex &+ RHS.count
                    carry = PRODUCT[unchecked: productIndex].addReportingOverflow(word, carry)
                }
            }
        }}}
        //=--------------------------------------=
        return HL(product.high, product.low)
    }
}
