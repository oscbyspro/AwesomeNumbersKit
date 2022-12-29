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

extension _ANKFullWidth {
    
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

//*============================================================================*
// MARK: * ANK x Full Width x Multiplication x Digit
//*============================================================================*

extension _ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Digit) {
        precondition(!lhs.multiplyReportingOverflow(by: rhs))
    }
    
    @inlinable public static func *(lhs: Self, rhs: Digit) -> Self {
        let pvo: PVO<Self> = lhs.multipliedReportingOverflow(by: rhs)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflow(by amount: Digit) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func multipliedReportingOverflow(by amount: Digit) -> PVO<Self> {
        let isLessThanOrEqualToZero: Bool = self.isLessThanZero != amount.isLessThanZero
        let product: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        let overflow: Bool = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidth(by amount: Digit) -> Digit {
        let hl: HL<Digit, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: hl.low); return hl.high
    }
    
    @inlinable func multipliedFullWidth(by amount: Digit) -> HL<Digit, Magnitude> {
        //=--------------------------------------=
        if amount.isZero { return HL(Digit(), Magnitude()) }
        //=--------------------------------------=
        var high = UInt()
        let low: Magnitude = self.withUnsafeWords { LHS in
        Magnitude.fromUnsafeTemporaryWords { LOW in
            var x = amount.isLessThanZero as Bool
            let rhsWord = UInt(bitPattern: amount)
            //=----------------------------------=
            for index in LHS.indices {
                let lhsWord = LHS[unchecked:  index]
                (high, LOW[unchecked: index]) = high.addingFullWidth(multiplicands:(lhsWord, rhsWord))
                if  amount.isLessThanZero { x = high.addReportingOverflow(~lhsWord, x) }
            }
            //=----------------------------------=
            high = self.isLessThanZero ? high &+ ~rhsWord &+ 1 : high
        }}
        //=--------------------------------------=
        return HL(Digit(bitPattern: high), low)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Double Width x Multiplication x Karatsuba
//*============================================================================*

extension _ANKFullWidth where High.Magnitude == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyAsKaratsuba(by amount: Self) {
        precondition(!self.multiplyReportingOverflowAsKaratsuba(by: amount))
    }
    
    @inlinable func multipliedAsKaratsuba(by amount: Self) -> Self {
        let pvo: PVO<Self> = self.multipliedReportingOverflowAsKaratsuba(by: amount)
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyReportingOverflowAsKaratsuba(by amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflowAsKaratsuba(by: amount)
        self = pvo.partialValue; return pvo.overflow
    }
    
    @inlinable func multipliedReportingOverflowAsKaratsuba(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero: Bool = self.isLessThanZero != amount.isLessThanZero
        let product: DoubleWidth = self.multipliedFullWidthAsKaratsuba(by: amount)
        let overflow: Bool = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func multiplyFullWidthAsKaratsuba(by amount: Self) -> Self {
        let hl: DoubleWidth = self.multipliedFullWidthAsKaratsuba(by: amount)
        self = Self(bitPattern: hl.low); return Self(bitPattern: hl.high)
    }
    
    @inlinable func multipliedFullWidthAsKaratsuba(by amount: Self) -> DoubleWidth {
        let negate:  Bool = self.isLessThanZero != amount.isLessThanZero
        let product: DoubleWidth.Magnitude = self.magnitude.multipliedFullWidthAsKaratsubaAsUnsigned(by: amount.magnitude)
        return DoubleWidth(bitPattern: negate ? product.twosComplement() : product)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension _ANKFullWidth where High == Low {
    
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
        let o0 = r1.low .addReportingOverflow(s1.low) as Bool
        let o1 = r1.high.addReportingOverflow(s1.high &+ Digit(bit: o0)) as Bool
        //=--------------------------------------=
        assert(!o1); return DoubleWidth(descending:(r1, r0))
    }
}
