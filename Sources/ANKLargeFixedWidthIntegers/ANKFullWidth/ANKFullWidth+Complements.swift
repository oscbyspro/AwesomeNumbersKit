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
// MARK: * ANK x Full Width x Complements
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func formTwosComplement() {
        var carry =  true
        for index in self.indices {
            var word = ~self[unchecked: index]
            carry = word.addReportingOverflow(UInt(carry))
            self[unchecked: index] = word
        }
    }
    
    @inlinable func twosComplement() -> Self {
        var x = self; x.formTwosComplement(); return x
    }
    
    /// - Returns true when `Self.isSigned == true` and `self == min`.
    @inlinable mutating func formTwosComplementReportingOverflow() -> Bool {
        let wasLessThanZero = self.isLessThanZero
        self.formTwosComplement() // ~self &+ 1
        return wasLessThanZero && self.isLessThanZero
    }
    
    /// - Returns true when `Self.isSigned == true` and `self == min`.
    @inlinable func twosComplementReportingOverflow() -> PVO<Self> {
        var pv = self; let o = pv.formTwosComplementReportingOverflow(); return (pv, o)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable var magnitude: Magnitude {
        Magnitude(bitPattern: isLessThanZero ? self.twosComplement() : self)
    }
}

//*============================================================================*
// MARK: * ANK x Full Width x Signed x Complements
//*============================================================================*

extension ANKFullWidth where Self: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable static prefix func -(x: Self) -> Self {
        let (pv, o) = x.negatedReportingOverflow(); precondition(!o); return pv
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func negateReportingOverflow() -> Bool {
        self.formTwosComplementReportingOverflow()
    }
    
    @inlinable func negatedReportingOverflow() -> PVO<Self> {
        self.twosComplementReportingOverflow()
    }
}
