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
    
    @inlinable public mutating func multiplyReportingOverflow(by  amount: Self) -> Bool {
        let pvo: PVO<Self> = self.multipliedReportingOverflow(by: amount)
        self = pvo.partialValue
        return pvo.overflow as Bool
    }
    
    @inlinable public func multipliedReportingOverflow(by amount:  Self) -> PVO<Self> {
        let product: DoubleWidth = self._multipliedFullWidth(by: amount)
        //=--------------------------------------=
        let overflow: Bool
        if !Self.isSigned {
            overflow = !product.high.isZero
        }   else if self.isLessThanZero == amount.isLessThanZero {
            overflow = !product.high.isZero || product.low.mostSignificantBit
        }   else {
            overflow = product.high.isLessThanZero && (!product.low.mostSignificantBit || product.high.nonzeroBitCount != product.high.bitWidth)
        }
        //=--------------------------------------=
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyFullWidth(by amount: Self) -> Self {
        let product: HL<Self, Magnitude> = self.multipliedFullWidth(by: amount)
        self = Self(bitPattern: product.low)
        return product.high as Self
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        let product: DoubleWidth = self._multipliedFullWidth(by: amount)
        return HL(product.high, product.low)
    }
    
    @inlinable func _multipliedFullWidth(by amount: Self) -> DoubleWidth {
        if  High.Magnitude.self == Low.self {
            return self._multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by: amount)
        };  return self._multipliedFullWidthAsNormal(by: amount)
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
        var product = DoubleWidth()
        let lhsIsLessThanZero: Bool =   self.isLessThanZero
        let rhsIsLessThanZero: Bool = amount.isLessThanZero
        //=--------------------------------------=
        self   .withUnsafeWords { LHS in
        amount .withUnsafeWords { RHS in
        product.withUnsafeMutableWords  { PRO in
            for lhsIndex in LHS.indices {
                var carry = UInt()
                for rhsIndex in RHS.indices {
                    carry = PRO[lhsIndex &+ rhsIndex].addFullWidth(carry, multiplicands:(LHS[lhsIndex], RHS[rhsIndex]))
                }
                
                PRO[RHS.endIndex &+ lhsIndex] = carry
            }
            
            if  lhsIsLessThanZero {
                var carry = true
                for rhsIndex in RHS.indices {
                    carry = PRO[LHS.endIndex &+ rhsIndex].addReportingOverflow(~RHS[rhsIndex], carry)
                }
            }
            
            if  rhsIsLessThanZero {
                var carry = true
                for lhsIndex in LHS.indices {
                    carry = PRO[RHS.endIndex &+ lhsIndex].addReportingOverflow(~LHS[lhsIndex], carry)
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
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by amount: Self) -> DoubleWidth {
        assert(High.Magnitude.self == Low.self)
        let negate: Bool = self.isLessThanZero != amount.isLessThanZero
        let lhs =   self.magnitude as! ANKFullWidth<Low, Low>
        let rhs = amount.magnitude as! ANKFullWidth<Low, Low>
        let product = lhs._multipliedFullWidthAsKaratsubaAsUnsigned(by: rhs) as! Magnitude.DoubleWidth
        return DoubleWidth(bitPattern: negate ? product.twosComplement() : product)
    }
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsUnsigned(by amount: Self) -> DoubleWidth where High == Low {
        //=--------------------------------------=
        let m0 = self.low .multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m1 = self.low .multipliedFullWidth(by: amount.high) as HL<Low, Low>
        let m2 = self.high.multipliedFullWidth(by: amount.low ) as HL<Low, Low>
        let m3 = self.high.multipliedFullWidth(by: amount.high) as HL<Low, Low>
        //=--------------------------------------=
        let s0 = Low.sum(m0.high, m1.low,  m2.low) as HL<UInt, Low>
        let s1 = Low.sum(m1.high, m2.high, m3.low) as HL<UInt, Low>
        //=--------------------------------------=
        let r0 = Magnitude(descending: HL(s0.low,  m0.low))
        var r1 = Magnitude(descending: HL(m3.high, Low(digit: s0.high)))
        let o0 = r1.low .addReportingOverflow(s1.low) as Bool
        let o1 = r1.high.addReportingOverflow(s1.high &+ UInt(bit:  o0)) as Bool
        //=--------------------------------------=
        assert(!o1); return DoubleWidth(descending: HL(r1, r0))
    }
}
