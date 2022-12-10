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
// MARK: * OBE x Fixed Width Integer x Complements
//*============================================================================*

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @inlinable public mutating func formTwosComplement() {
        self._storage.formTwosComplement()
    }
    
    @inlinable public func twosComplement() -> Self {
        Self(bitPattern: _storage.twosComplement())
    }
}

//*============================================================================*
// MARK: * OBE x Fixed Width Integer x Complements x Signed
//*============================================================================*

extension OBESignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var magnitude: Magnitude {
        Magnitude(bitPattern: _storage.magnitude)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    #warning("OBEFullWidth")
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        let wasLessThanZero = isLessThanZero
        self.formTwosComplement()
        return wasLessThanZero && isLessThanZero
    }
    
    #warning("OBEFullWidth")
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        var pv = self; let o = pv.negateReportingOverflow(); return (pv, o)
    }
}
