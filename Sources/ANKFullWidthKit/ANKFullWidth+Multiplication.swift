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
        let product = self._multipliedFullWidth(by: other) as DoubleWidth
        //=--------------------------------------=
        let overflow: Bool
        if !Self.isSigned {
            overflow = !(product.high.isZero)
        }   else if self.isLessThanZero == other.isLessThanZero {
            // overflow = product > Self.max, but more efficient
            overflow = !(product.high.isZero && !product.low.mostSignificantBit)
        }   else {
            // overflow = product < Self.min, but more efficient
            overflow = !(product.high.isFull &&  product.low.mostSignificantBit) && product.high.mostSignificantBit
        }
        //=--------------------------------------=
        return ANK.bitCast(PVO(product.low, overflow)) as PVO<Self>
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
        let product: DoubleWidth = self._multipliedFullWidth(by: other)
        return HL(product.high, product.low)
    }
    
    @inlinable func _multipliedFullWidth(by other: Self) -> DoubleWidth {
        if  High.Magnitude.self == Low.self {
            return self._multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by: other)
        };  return self._multipliedFullWidthAsNormal(by: other)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Normal
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable func _multipliedFullWidthAsNormal(by other: Self) -> DoubleWidth {
        var product = DoubleWidth()
        let lhsIsLessThanZero: Bool = self .isLessThanZero
        let rhsIsLessThanZero: Bool = other.isLessThanZero
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
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsDoubleWidthOrCrash(by other: Self) -> DoubleWidth {
        assert(High.Magnitude.self == Low.self)
        let minus: Bool = self.isLessThanZero != other.isLessThanZero
        let lhs = self .magnitude as! ANKFullWidth<Low, Low>
        let rhs = other.magnitude as! ANKFullWidth<Low, Low>
        let product = lhs._multipliedFullWidthAsKaratsubaAsUnsigned(by: rhs) as! Magnitude.DoubleWidth
        return DoubleWidth(bitPattern: minus ? product.twosComplement() : product)
    }
    
    @inlinable func _multipliedFullWidthAsKaratsubaAsUnsigned(by other: Self) -> DoubleWidth where High == Low {
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
        return DoubleWidth(high: hi, low: lo)
    }
}
