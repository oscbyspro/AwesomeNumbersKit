//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Full Width x Endianness
//*============================================================================*
//=----------------------------------------------------------------------------=
// the implementation is platform dependent and identical to /Integers.swift
//=----------------------------------------------------------------------------=

extension ANKFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bigEndian value: Self) {
        #if _endian(big)
        self = value
        #else
        self = value.byteSwapped
        #endif
    }
    
    @_transparent public init(littleEndian value: Self) {
        #if _endian(little)
        self = value
        #else
        self = value.byteSwapped
        #endif
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var bigEndian: Self {
        #if _endian(big)
        return self
        #else
        return self.byteSwapped
        #endif
    }
    
    @_transparent public var littleEndian: Self {
        #if _endian(little)
        return self
        #else
        return self.byteSwapped
        #endif
    }
}
