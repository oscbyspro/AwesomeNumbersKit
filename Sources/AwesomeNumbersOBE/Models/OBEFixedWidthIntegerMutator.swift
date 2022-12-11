//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * OBE x Fixed Width Integer Pointer x Mutator
//*============================================================================*

@frozen @usableFromInline struct OBEFixedWidthIntegerMutator<Integer>:
OBEFixedWidthIntegerPointer where Integer: OBEFixedWidthIntegerLayout {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let _base: UnsafeMutablePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ INTEGER: UnsafeMutablePointer<Integer>) {
        self._base = UnsafeMutableRawPointer(INTEGER).assumingMemoryBound(to: UInt.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition( indices.contains(index))
            yield  _base[littleEndianIndex(index)]
        }
        
        @_transparent nonmutating _modify {
            precondition( indices.contains(index))
            yield &_base[littleEndianIndex(index)]
        }
    }
}
