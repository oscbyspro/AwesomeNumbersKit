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
// MARK: * ANK x Full Width x Negation
//*============================================================================*

extension ANKFullWidth where High: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        let msb0: Bool = self.isLessThanZero
        self.formTwosComplement()
        let msb1: Bool = self.isLessThanZero
        return msb0 && msb1
    }
    
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue.negateReportingOverflow()
        return PVO(partialValue, overflow)
    }
}
