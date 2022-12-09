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
// MARK: * OBE x Arithmetic
//*============================================================================*

extension UInt {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func addReportingOverflow(_ amount: Self, _ carry: Bool) -> Bool {
        let a = self.addReportingOverflow(amount)
        let b = self.addReportingOverflow(carry ? 1 : 0)
        return  a || b
    }
    
    @inlinable func addingReportingOverflow(_ amount: Self, _ carry: Bool) -> PVO<Self> {
        var S0 = self; let S1 = S0.addReportingOverflow(amount, carry); return (S0, S1)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
        
    @inlinable mutating func subtractReportingOverflow(_ amount: Self, _ borrow: Bool) -> Bool {
        let a = self.subtractReportingOverflow(amount)
        let b = self.subtractReportingOverflow(borrow ? 1 : 0)
        return  a || b
    }
    
    @inlinable func subtractingReportingOverflow(_ amount: Self, _ borrow: Bool) -> PVO<Self> {
        var S0 = self; let S1 = S0.subtractReportingOverflow(amount, borrow); return (S0, S1)
    }
}
