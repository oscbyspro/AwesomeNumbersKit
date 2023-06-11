//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKCoreKit

//*============================================================================*
// MARK: * ANK x Full Width x Multiplication
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by  other: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: other)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func multipliedReportingOverflow(by other:  Self) -> PVO<Self> {
        let lhsIsLessThanZero: Bool = self .isLessThanZero
        let rhsIsLessThanZero: Bool = other.isLessThanZero
        let minus = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var pvo = ANK.bitCast(self.magnitude.multipliedReportingOverflow(by: other.magnitude)) as PVO<Self>
        //=--------------------------------------=
        var suboverflow = (pvo.partialValue.isLessThanZero)
        if  minus {
            suboverflow = !pvo.partialValue.formTwosComplementSubsequence(true) && suboverflow
        }
        
        pvo.overflow = pvo.overflow || suboverflow as Bool
        //=--------------------------------------=
        return pvo as PVO<Self>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by other: Self) -> Self {
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: other)
        self = Self(bitPattern: product.low)
        return product.high as Self
    }
    
    @inlinable public func multipliedFullWidth(by other: Self) -> HL<Self, Magnitude> {
        let lhsIsLessThanZero: Bool = self .isLessThanZero
        let rhsIsLessThanZero: Bool = other.isLessThanZero
        var minus = lhsIsLessThanZero != rhsIsLessThanZero
        //=--------------------------------------=
        var product = self.magnitude.multipliedFullWidth(by: other.magnitude)
        //=--------------------------------------=
        if  minus {
            minus = product.low .formTwosComplementSubsequence(minus)
            minus = product.high.formTwosComplementSubsequence(minus)
        }
        //=--------------------------------------=
        return ANK.bitCast(product) as HL<Self, Magnitude>
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedReportingOverflow(by other: Self) -> PVO<Self> {
        switch High.Magnitude.self == Low.self {
        case  true: return self.multipliedReportingOverflowAsKaratsubaAsDoubleWidthOrCrash(by: other)
        case false: return self.multipliedReportingOverflowAsNormal(by: other) }
    }
    
    @inlinable func multipliedReportingOverflowAsKaratsubaAsDoubleWidthOrCrash(by other: Self) -> PVO<Self> {
        (self as! ANKFullWidth<Low, Low>).multipliedReportingOverflowAsKaratsuba(by:(other as! ANKFullWidth<Low, Low>)) as! PVO<Self>
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedFullWidth(by other: Self) -> HL<Self, Magnitude> {
        switch High.Magnitude.self == Low.self {
        case  true: return self.multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by: other)
        case false: return self.multipliedFullWidthAsNormal(by: other) }
    }
    
    @inlinable func multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by other: Self) -> HL<Self, Magnitude> {
        (self as! ANKFullWidth<Low, Low>).multipliedFullWidthAsKaratsuba(by:(other as! ANKFullWidth<Low, Low>)) as! HL<Self, Magnitude>
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned x Normal
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == High.Magnitude {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedReportingOverflowAsNormal(by other: Self) -> PVO<Self> {
        let product = self.multipliedFullWidthAsNormal(by: other) as HL<Self, Magnitude>
        return PVO(product.low, !product.high.isZero)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    @inlinable func multipliedFullWidthAsNormal(by other: Self) -> HL<Self, Magnitude> {
        var product = DoubleWidth()
        //=--------------------------------------=
        self   .withUnsafeWords { LHS in
        other  .withUnsafeWords { RHS in
        product.withUnsafeMutableWords  { PRO in
            for lhsIndex in LHS.indices {
                var carry = UInt()
                for rhsIndex in RHS.indices {
                    carry = PRO[lhsIndex &+ rhsIndex].addFullWidth(carry, multiplicands:(LHS[lhsIndex], RHS[rhsIndex]))
                }
                
                PRO[RHS.endIndex &+ lhsIndex] = carry
            }
        }}}
        //=--------------------------------------=
        return product.descending
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Unsigned x Karatsuba
//=----------------------------------------------------------------------------=

extension ANKFullWidth where High == Low {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Transformations
    //=------------------------------------------------------------------------=
    
    /// An adaptation of Anatoly Karatsuba's multiplication algorithm.
    @inlinable func multipliedReportingOverflowAsKaratsuba(by other: Self) -> PVO<Self> {
        var ax = self.low .multipliedFullWidth(by: other.low)
        let ay = self.low .multipliedReportingOverflow(by: other.high)
        let bx = self.high.multipliedReportingOverflow(by: other.low )
        let by = !(self.high.isZero || other.high.isZero)
        //=--------------------------------------=
        let o0 = ax.high.addReportingOverflow(ay.partialValue) as Bool
        let o1 = ax.high.addReportingOverflow(bx.partialValue) as Bool
        //=--------------------------------------=
        let overflow = by || ay.overflow || bx.overflow || o0 || o1
        //=--------------------------------------=
        return PVO(Self(descending: ax), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations x Full Width
    //=------------------------------------------------------------------------=
    
    /// An adaptation of Anatoly Karatsuba's multiplication algorithm.
    ///
    /// ### Order of operations
    ///
    /// The order of operations matters a lot, so don't reorder it without a profiler.
    ///
    @inlinable func multipliedFullWidthAsKaratsuba(by other: Self) -> HL<Self, Magnitude> {
        var ax = self.low .multipliedFullWidth(by: other.low ) as HL<Low, Low>
        let bx = self.low .multipliedFullWidth(by: other.high) as HL<Low, Low>
        let ay = self.high.multipliedFullWidth(by: other.low ) as HL<Low, Low>
        var by = self.high.multipliedFullWidth(by: other.high) as HL<Low, Low>
        //=--------------------------------------=
        let a0 = ax.high.addReportingOverflow(bx.low) as Bool
        let a1 = ax.high.addReportingOverflow(ay.low) as Bool
        let a2 = UInt(bit: a0) &+ UInt(bit: a1)
        
        let b0 = by.low.addReportingOverflow(bx.high) as Bool
        let b1 = by.low.addReportingOverflow(ay.high) as Bool
        let b2 = UInt(bit: b0) &+ UInt(bit: b1)
        //=--------------------------------------=
        let lo = Magnitude(descending: ax)
        var hi = Magnitude(descending: by)
        
        let o0 = hi.low .addReportingOverflow(a2) as Bool
        let _  = hi.high.addReportingOverflow(b2  &+ UInt(bit: o0)) as Bool
        //=--------------------------------------=
        return HL(high: hi, low: lo)
    }
}
