//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Full Width x Endianness
//*============================================================================*
//=----------------------------------------------------------------------------=
// the implementation is platform dependent and identical to /Integers.swift
//=----------------------------------------------------------------------------=

extension OBEFullWidth {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bigEndian value: Self) {
        #if _endian(big)
        self = value
        #else
        self = value.byteSwapped
        #endif
    }
    
    @inlinable init(littleEndian value: Self) {
        #if _endian(little)
        self = value
        #else
        self = value.byteSwapped
        #endif
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable var bigEndian: Self {
        #if _endian(big)
        return self
        #else
        return self.byteSwapped
        #endif
    }
    
    @inlinable var littleEndian: Self {
        #if _endian(little)
        return self
        #else
        return self.byteSwapped
        #endif
    }
}
