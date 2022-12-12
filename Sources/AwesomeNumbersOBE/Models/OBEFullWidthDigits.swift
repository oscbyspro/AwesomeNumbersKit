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
// MARK: * OBE x Full Width Digits
//*============================================================================*

/// A fixed-width integer collection interface.
///
/// Little-endianness is assumed only for the sake of consistency with `/words`.
///
/// - It must use contiguously ascending integer indices starting from zero
/// - It must iterate from least significant digit to most signifcant digit (little-endian)
///
@usableFromInline protocol OBEFullWidthDigits<High, Low>: WoRdS where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    associatedtype High
    
    associatedtype Low
    
    typealias Body = OBEFullWidth<High, Low>
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Mutator
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthMutator<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let _base: UnsafeMutablePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ BODY: UnsafeMutablePointer<Body>) {
        self._base = UnsafeMutableRawPointer(BODY).assumingMemoryBound(to: UInt.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition(indices.contains(index))
            yield  _base[Body.littleEndianIndex(index)]
        }
        
        @_transparent nonmutating _modify {
            precondition(indices.contains(index))
            yield &_base[Body.littleEndianIndex(index)]
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Reader
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthReader<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let _base: UnsafePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ BODY: UnsafePointer<Body>) {
        self._base = UnsafeRawPointer(BODY).assumingMemoryBound(to: UInt.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition(indices.contains(index))
            yield  _base[Body.littleEndianIndex(index)]
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Words
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthWords<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=--------------------------------------------------------------------=
    // MARK: State
    //=--------------------------------------------------------------------=
    
    @usableFromInline var _base: Body
    
    //=--------------------------------------------------------------------=
    // MARK: Initializers
    //=--------------------------------------------------------------------=
    
    @inlinable init(_ base: Body) { self._base = base }
    
    //=--------------------------------------------------------------------=
    // MARK: Accessors
    //=--------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent get { _base.withUnsafeTwosComplementWords({/*---*/ $0[index] /*------*/ }) }
        @_transparent set { _base.withUnsafeMutableTwosComplementWords({ $0[index] = newValue }) }
    }
}
