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
// MARK: * ANK x Full Width x Negation
//*============================================================================*

extension ANKFullWidth where High: SignedInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public static prefix func -(x: Self) -> Self {
        let pvo: PVO<Self> = x.negatedReportingOverflow()
        precondition(!pvo.overflow); return pvo.partialValue
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func negateReportingOverflow() -> Bool {
        self._negateReportingOverflowAsSigned()
    }
    
    @_transparent public func negatedReportingOverflow() -> PVO<Self> {
        self._negatedReportingOverflowAsSigned()
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Agnostic
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable mutating func _negateReportingOverflowAsSigned() -> Bool {
        let msb0: Bool = self.mostSignificantBit
        self.formTwosComplement()
        let msb1: Bool = self.mostSignificantBit
        return msb0 && msb1
    }
    
    @inlinable func _negatedReportingOverflowAsSigned() -> PVO<Self> {
        var partialValue = self
        let overflow: Bool = partialValue._negateReportingOverflowAsSigned()
        return PVO(partialValue, overflow)
    }
}
