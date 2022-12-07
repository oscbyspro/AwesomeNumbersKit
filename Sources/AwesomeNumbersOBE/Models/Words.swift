//=----------------------------------------------------------------------------=
// This source file is part of the ExtraLargeNumbers open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Words
//*============================================================================*

@frozen @usableFromInline struct Words<Integer: OBEFixedWidthInteger>: OBEFixedWidthIntegerBuffer {
    
    //=--------------------------------------------------------------------=
    // MARK: State
    //=--------------------------------------------------------------------=
    
    @usableFromInline let _base: Integer
    
    //=--------------------------------------------------------------------=
    // MARK: Initializers
    //=--------------------------------------------------------------------=
    
    @inlinable init(_ base: Integer) { self._base = base }
    
    //=--------------------------------------------------------------------=
    // MARK: Accessors
    //=--------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read { yield _base.withUnsafeTwosComplementWords({ $0[index] }) }
    }
}
