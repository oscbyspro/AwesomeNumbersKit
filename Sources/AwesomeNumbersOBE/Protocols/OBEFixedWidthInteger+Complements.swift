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
    
    @inlinable public mutating func negateReportingOverflow() -> Bool {
        self._storage.negateReportingOverflow()
    }
    
    @inlinable public func negatedReportingOverflow() -> PVO<Self> {
        let (pv, o) = self._storage.negatedReportingOverflow(); return PVO(Self(bitPattern: pv), o)
    }
}
