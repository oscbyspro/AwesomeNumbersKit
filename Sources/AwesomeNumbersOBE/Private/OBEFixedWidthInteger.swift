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
// MARK: * OBE x Fixed Width Integer
//*============================================================================*

@usableFromInline protocol OBEFixedWidthInteger: AwesomeFixedWidthInteger where
Magnitude: OBEFixedWidthInteger, Magnitude.High == High.Magnitude, Magnitude.Low == Low {
        
    associatedtype High: AwesomeFixedWidthInteger
    
    associatedtype Low:  AwesomeFixedWidthInteger where Low == High.Magnitude
    
    associatedtype Pointer: OBEFixedWidthIntegerPointer<Self>
    
    associatedtype Mutator: OBEFixedWidthIntegerMutator<Self>
        
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @_hasStorage var _storage: FullWidth<High, Low>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(ascending:(low: Low, high: High))
    
    @inlinable init(descending:(high: High, low: Low))
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension OBEFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: Magnitude) {
        self = unsafeBitCast(bitPattern, to: Self.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var high: High {
        _read   { yield  self._storage.high }
        _modify { yield &self._storage.high }
    }
    
    @inlinable var low:  Low  {
        _read   { yield  self._storage.low  }
        _modify { yield &self._storage.low  }
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable public var words: some WoRdS {
        AwesomeNumbersOBE.Words(self)
    }
    
    @inlinable func withUnsafeTwosComplementWords<T>(_ body: (Pointer) throws -> T) rethrows -> T {
        try withUnsafePointer(to: self) { INTEGER in try body(Pointer(INTEGER)) }
    }
    
    @inlinable mutating func withUnsafeMutableTwosComplementWords<T>(_ body: (Mutator) throws -> T) rethrows -> T {
        try withUnsafeMutablePointer(to: &self) { INTEGER in try body(Mutator(INTEGER)) }
    }
}
