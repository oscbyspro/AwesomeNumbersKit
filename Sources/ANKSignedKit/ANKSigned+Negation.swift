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
// MARK: * ANK x Signed x Negation
//*============================================================================*

extension ANKSigned {
        
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public static prefix func -(x: Self) -> Self {
        x.negated()
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negate() {
        self.sign.toggle()
    }
    
    @_transparent public func negated() -> Self {
        Self(self.magnitude, as: self.sign.toggled())
    }
}

//*============================================================================*
// MARK: * ANK x Signed x Fixed Width x Negation
//*============================================================================*

extension ANKSigned where Magnitude: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negateReportingOverflow() -> Bool {
        self.negate()
        return false
    }
    
    @_transparent public func negatedReportingOverflow() -> PVO<Self> {
        PVO(partialValue: -self, overflow: false)
    }
}
