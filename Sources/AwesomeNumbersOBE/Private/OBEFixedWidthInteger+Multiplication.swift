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
// MARK: * OBE x Fixed Width Integer x Multiplication
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static func *=(lhs: inout Self, rhs: Self) {
        lhs = lhs * rhs
    }
    
    @inlinable public static func *(lhs: Self, rhs: Self) -> Self {
        let (pv, o) = lhs.multipliedReportingOverflow(by: rhs); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func multiplyReportingOverflow(by amount: Self) -> Bool {
        let o: Bool; (self, o) = self.multipliedReportingOverflow(by: amount); return o
    }
    
    @inlinable public func multipliedReportingOverflow(by amount: Self) -> PVO<Self> {
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        let product  = self.multipliedFullWidth(by: amount)
        let overflow = isLessThanOrEqualToZero ? (product.high < -1) : !product.high.isZero
        return PVO(Self(bitPattern: product.low), overflow)
    }
    
    @inlinable public func multipliedFullWidth(by amount: Self) -> HL<Self, Magnitude> {
        //=--------------------------------------=
        //
        //=--------------------------------------=
        func sum(_ x0: Low, _ x1: Low, _ x2: Low) -> Magnitude {
            let (x3, o3) = x0.addingReportingOverflow(x1)
            let (x4, o4) = x3.addingReportingOverflow(x2)
            let (x5) = o3 && o4 ? 2 : o3 || o4 ? 1 : 0 as Low // TODO: as UInt
            return Magnitude(descending:(x5, x4))
        }
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let isLessThanOrEqualToZero = self.isLessThanZero != amount.isLessThanZero
        
        let lhs =   self.magnitude
        let rhs = amount.magnitude
        //=--------------------------------------=
        //
        //=--------------------------------------=
        let m0 = lhs.low .multipliedFullWidth(by: rhs.low )
        let m1 = lhs.low .multipliedFullWidth(by: rhs.high)
        let m2 = lhs.high.multipliedFullWidth(by: rhs.low )
        let m3 = lhs.high.multipliedFullWidth(by: rhs.high)
        
        let s0 = sum(m0.high, m1.low,  m2.low)
        let s1 = sum(m1.high, m2.high, m3.low)
        
        var low  = Magnitude(descending:(s0.low,  m0.low ))
        var high = Magnitude(descending:(m3.high, s0.high)) &+ s1
        //=--------------------------------------=
        //
        //=--------------------------------------=
        if  isLessThanOrEqualToZero {
            var carry: Bool // TODO: formTwosComplement()
            (low,  carry) = (~low ).addingReportingOverflow(1 as Magnitude)
            (high, carry) = (~high).addingReportingOverflow(carry ? 1 : 0 as Magnitude)
        }
        
        return HL(Self(bitPattern: high), low)
    }
}
