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
// MARK: * OBE x Full Width x Complements
//*============================================================================*

extension OBEFullWidth {
    
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
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable var magnitude: Magnitude {
        Magnitude(bitPattern: isLessThanZero ? self.twosComplement() : self)
    }
}

//*============================================================================*
// MARK: * OBE x Full Width x Signed x Complements
//*============================================================================*

extension OBEFullWidth where Self: SignedInteger {
    
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
        let wasLessThanZero = isLessThanZero
        self.formTwosComplement() // ~self &+ 1
        return wasLessThanZero && isLessThanZero
    }
    
    @inlinable func negatedReportingOverflow() -> PVO<Self> {
        var pv = self; let o = pv.negateReportingOverflow(); return (pv, o)
    }
}
