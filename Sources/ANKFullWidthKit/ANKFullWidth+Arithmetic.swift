//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Full Width x Arithmetic
//*============================================================================*

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    /// - Returns: `abs(self % Self.bitWidth)`
    @inlinable var absoluteValueModuloBitWidth: Int {
        //=--------------------------------------=
        if  Self.bitWidth.isPowerOf2 {
            return Int(bitPattern: self.first) & (Self.bitWidth &- 1)
        }
        //=--------------------------------------=
        let value = Int(bitPattern: self % Digit(bitPattern: Self.bitWidth))
        return self.isLessThanZero ? -value : value
    }
}
