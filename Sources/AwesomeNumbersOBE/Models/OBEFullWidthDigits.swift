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

@usableFromInline protocol OBEFullWidthDigits<High, Low>: WoRdS where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    associatedtype High
    
    associatedtype Low
    
    typealias Layout = OBEFullWidth<High, Low>
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Little Endian x Mutator
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthLittleEndianMutator<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let _base: UnsafeMutablePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ INTEGER: UnsafeMutablePointer<Layout>) {
        self._base = UnsafeMutableRawPointer(INTEGER).assumingMemoryBound(to: UInt.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition(indices.contains (index))
            yield  _base[littleEndianIndex(index)]
        }
        
        @_transparent nonmutating _modify {
            precondition(indices.contains (index))
            yield &_base[littleEndianIndex(index)]
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Little Endian x Reader
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthLittleEndianReader<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: State
    //=------------------------------------------------------------------------=
    
    @usableFromInline let _base: UnsafePointer<UInt>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(_ INTEGER: UnsafePointer<Layout>) {
        self._base = UnsafeRawPointer(INTEGER).assumingMemoryBound(to: UInt.self)
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent _read {
            precondition(indices.contains(index))
            yield _base[littleEndianIndex(index)]
        }
    }
}

//*============================================================================*
// MARK: * OBE x Full Width Digits x Little Endian x Words
//*============================================================================*

@frozen @usableFromInline struct OBEFullWidthLittleEndianWords<High, Low>: OBEFullWidthDigits where
High: AwesomeFixedWidthInteger, Low: AwesomeUnsignedFixedWidthInteger {
    
    //=--------------------------------------------------------------------=
    // MARK: State
    //=--------------------------------------------------------------------=
    
    @usableFromInline var _base: Layout
    
    //=--------------------------------------------------------------------=
    // MARK: Initializers
    //=--------------------------------------------------------------------=
    
    @inlinable init(_ base: Layout) { self._base = base }
    
    //=--------------------------------------------------------------------=
    // MARK: Accessors
    //=--------------------------------------------------------------------=
    
    @usableFromInline subscript(index: Int) -> UInt {
        @_transparent get { _base.withUnsafeTwosComplementWords({/*---*/ $0[index] /*------*/ }) }
        @_transparent set { _base.withUnsafeMutableTwosComplementWords({ $0[index] = newValue }) }
    }
}
