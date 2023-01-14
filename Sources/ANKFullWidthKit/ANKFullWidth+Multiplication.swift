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
    
    @inlinable public mutating func multiplyReportingOverflow(by  amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero as Bool
        let product = self.multipliedFullWidth(by: amount) as HL<Self, Magnitude>
        let overflow: Bool = isLessThanOrEqualToZero ? product.high < (-1 as Self) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let hl: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @_transparent public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let hl: DoubleWidth = self._multipliedFullWidth(by: amount)
        return HL(hl.high, hl.low)
    }
    
    @_transparent @usableFromInline func _multipliedFullWidth(by amount: Self) -> DoubleWidth {
        //=--------------------------------------=
        if  High.Magnitude.self == Low.self {
            return self._multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by: amount)
        }
        //=--------------------------------------=
        return self._multipliedFullWidthAsNormal(by: amount)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Normal
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func _multipliedFullWidthAsNormal(by amount: Self) -> DoubleWidth {
        let lhsIsLessThanZero: Bool =   self.isLessThanZero
        let rhsIsLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        var product = DoubleWidth()
        //=--------------------------------------=
        self   .withUnsafeWordsPointer { LHS in
        amount .withUnsafeWordsPointer { RHS in
        product.withUnsafeMutableWordsPointer { PRODUCT in
            //=----------------------------------=
            var carry: UInt = UInt()
            for lhsIndex: Int in LHS.indices {
            for rhsIndex: Int in RHS.indices {
                let lhsWord: UInt = LHS[lhsIndex]
                let rhsWord: UInt = RHS[rhsIndex]
                let productIndex: Int = lhsIndex &+ rhsIndex
                carry = PRODUCT[productIndex].addFullWidth(carry, multiplicands:(lhsWord, rhsWord))
            }}
            //=----------------------------------=
            if  lhsIsLessThanZero {
                var carry: Bool = true
                for rhsIndex: Int in  RHS.indices {
                    let word: UInt = ~RHS[rhsIndex]
                    let productIndex: Int = rhsIndex &+ LHS.count
                    carry = PRODUCT[productIndex].addReportingOverflow(word, carry)
                }
            }
            //=----------------------------------=
            if  rhsIsLessThanZero {
                var carry: Bool = true
                for lhsIndex: Int in  LHS.indices {
                    let word: UInt = ~LHS[lhsIndex]
                    let productIndex: Int = lhsIndex &+ RHS.count
                    carry = PRODUCT[productIndex].addReportingOverflow(word, carry)
                }
            }
        }}}
        //=--------------------------------------=
        return product
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Karatsuba
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent @usableFromInline func multipliedFullWidthAsKaratsuba(by amount: Self) -> DoubleWidth where High.Magnitude == Low {
        self._multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by: amount)
    }
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by amount: Self) -> DoubleWidth {
        /// type casting equates to `where High.Magnitude == Low { ... }`
        let negate = self.isLessThanZero != amount.isLessThanZero as Bool
        guard let lhs =   self.magnitude as? ANKFullWidth<Low, Low> else { preconditionFailure() }
        guard let rhs = amount.magnitude as? ANKFullWidth<Low, Low> else { preconditionFailure() }
        guard let product = lhs._multipliedFullWidthAsKaratsubaAsUnsigned(by:  rhs) as? Magnitude.DoubleWidth else { preconditionFailure() }
        return DoubleWidth(bitPattern: negate ? product.twosComplement() : product)
    }
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsUnsigned(by amount: Self) -> DoubleWidth where High == Low {
        //=--------------------------------------=
        func sum(_ x0: Low, _ x1: Low, _ x2: Low) -> HL<UInt, Low> {
            let x3 = x0.addingReportingOverflow(x1) as PVO<Low>
            let x4 = x3.partialValue.addingReportingOverflow(x2) as PVO<Low>
            return HL(UInt(bit: x3.overflow) &+ UInt(bit: x4.overflow), x4.partialValue)
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
        let r0 = Magnitude(descending: HL(s0.low,  m0.low))
        var r1 = Magnitude(descending: HL(m3.high, Low(digit: s0.high)))
        let o0 = r1.low .addReportingOverflow(s1.low) as Bool
        let o1 = r1.high.addReportingOverflow(s1.high &+ UInt(bit:  o0)) as Bool
        //=--------------------------------------=
        assert(!o1); return DoubleWidth(descending: HL(r1, r0))
    }
}
