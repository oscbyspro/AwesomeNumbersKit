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
// MARK: * ANK x Integer x Complements
//*============================================================================*

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Transformations
    //=------------------------------------------------------------------------=
    
    @_transparent public mutating func formTwosComplement() {
        self.body.formTwosComplement()
    }
    
    @_transparent public func twosComplement() -> Self {
        Self(bitPattern: self.body.twosComplement())
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Signed x Complements
//*============================================================================*

extension _ANKSignedLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var magnitude: Magnitude {
        Magnitude(bitPattern: self.body.magnitude)
    }
}
