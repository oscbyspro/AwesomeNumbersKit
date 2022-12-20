//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Endianness
//*============================================================================*

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(bigEndian value: Self) {
        self.init(bitPattern: Body(bigEndian: value.body))
    }
    
    @inlinable public init(littleEndian value: Self) {
        self.init(bitPattern: Body(littleEndian: value.body))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var bigEndian: Self {
        Self(bitPattern: body.bigEndian)
    }
    
    @inlinable public var littleEndian: Self {
        Self(bitPattern: body.littleEndian)
    }
}
