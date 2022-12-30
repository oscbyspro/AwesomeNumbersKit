//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import ANKFoundation

//*============================================================================*
// MARK: * ANK x Integer x Number
//*============================================================================*
//=----------------------------------------------------------------------------=
// most init methods must be overloaded at the un/signed integer protocol level
//=----------------------------------------------------------------------------=

extension _ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(_truncatingBits source: UInt) {
        self.init(bitPattern: Body(_truncatingBits: source))
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init(_source source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self.init(bitPattern: Body(source.body))
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(bitPattern: Body(source.body))
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(bitPattern: Body(source))
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init?(_exactly source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            guard let body = Body(exactly: source.body) else { return nil }
            self.init(bitPattern: body)
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            guard let body = Body(exactly: source.body) else { return nil }
            self.init(bitPattern: body)
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        guard let body = Body(exactly: source) else { return nil }
        self.init(bitPattern: body)
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init(_clamping source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self.init(bitPattern: Body(clamping: source.body))
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(bitPattern: Body(clamping: source.body))
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(bitPattern: Body(clamping: source))
    }
    
    @_semantics("optimize.sil.specialize.generic.partial.never")
    @_transparent @usableFromInline init(_truncatingIfNeeded source: some BinaryInteger) {
        //=--------------------------------------=
        // Self
        //=--------------------------------------=
        if  let source = source as? Self {
            self.init(bitPattern: Body(truncatingIfNeeded: source.body))
            return
        }
        //=--------------------------------------=
        // Magnitude
        //=--------------------------------------=
        if  let source = source as? Magnitude {
            self.init(bitPattern: Body(truncatingIfNeeded: source.body))
            return
        }
        //=--------------------------------------=
        // some BinaryInteger
        //=--------------------------------------=
        self.init(bitPattern: Body(truncatingIfNeeded: source))
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Signed x Number
//*============================================================================*

extension _ANKSignedLargeFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(integerLiteral source: Int) {
        self.init(bitPattern: Body(integerLiteral: source))
    }
    
    @_transparent public init(_ source: some BinaryInteger) {
        self.init(_source: source)
    }

    @_transparent public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }

    @_transparent public init(clamping source: some BinaryInteger) {
        self.init(_clamping: source)
    }

    @_transparent public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded: source)
    }
}

//*============================================================================*
// MARK: * ANK x Integer x Unsigned x Number
//*============================================================================*

extension _ANKUnsignedLargeFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(integerLiteral source: UInt) {
        self.init(bitPattern: Body(digit: source))
    }
    
    @_transparent public init(_ source: some BinaryInteger) {
        self.init(_source: source)
    }

    @_transparent public init?(exactly source: some BinaryInteger) {
        self.init(_exactly: source)
    }

    @_transparent public init(clamping source: some BinaryInteger) {
        self.init(_clamping: source)
    }

    @_transparent public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(_truncatingIfNeeded: source)
    }
}
