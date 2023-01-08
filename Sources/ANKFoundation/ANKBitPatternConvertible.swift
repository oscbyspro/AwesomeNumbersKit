//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Bit Pattern Convertible
//*============================================================================*

public protocol ANKBitPatternConvertible<BitPattern> {
        
    associatedtype BitPattern: ANKBitPatternConvertible<BitPattern>
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable init(bitPattern: BitPattern)
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    @inlinable var bitPattern: BitPattern { get }
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKBitPatternConvertible {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(bitPattern source: some ANKBitPatternConvertible<BitPattern>) {
        self.init(bitPattern: source.bitPattern)
    }
}
