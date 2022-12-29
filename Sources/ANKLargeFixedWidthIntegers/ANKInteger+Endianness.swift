//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Integer x Endianness
//*============================================================================*

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bigEndian value: Self) {
        self.init(bitPattern: Body(bigEndian: value.body))
    }
    
    @_transparent public init(littleEndian value: Self) {
        self.init(bitPattern: Body(littleEndian: value.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var bigEndian: Self {
        Self(bitPattern: self.body.bigEndian)
    }
    
    @_transparent public var littleEndian: Self {
        Self(bitPattern: self.body.littleEndian)
    }
}
