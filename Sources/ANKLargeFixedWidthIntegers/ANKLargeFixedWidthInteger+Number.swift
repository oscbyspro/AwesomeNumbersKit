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
// MARK: * ANK x Fixed Width Integer x Large x Number
//*============================================================================*
//=----------------------------------------------------------------------------=
// most init methods must be overloaded at the un/signed integer protocol level
//=----------------------------------------------------------------------------=

extension ANKLargeFixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(_truncatingBits source: UInt) {
        self.init(bitPattern: Body(_truncatingBits: source))
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Signed x Number
//*============================================================================*

extension ANKSignedLargeFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: Int) {
        self.init(bitPattern: Body(integerLiteral: source))
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(bitPattern: Body(source))
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        guard let body = Body(exactly: source) else { return nil }; self.init(bitPattern: body)
    }

    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(bitPattern: Body(clamping: source))
    }

    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(bitPattern: Body(truncatingIfNeeded: source))
    }
}

//*============================================================================*
// MARK: * ANK x Fixed Width Integer x Large x Unsigned x Number
//*============================================================================*

extension ANKUnsignedLargeFixedWidthInteger {

    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(integerLiteral source: UInt) {
        self.init(bitPattern: Body(small: source))
    }
    
    @inlinable public init(_ source: some BinaryInteger) {
        self.init(bitPattern: Body(source))
    }

    @inlinable public init?(exactly source: some BinaryInteger) {
        guard let body = Body(exactly: source) else { return nil }; self.init(bitPattern: body)
    }

    @inlinable public init(clamping source: some BinaryInteger) {
        self.init(bitPattern: Body(clamping: source))
    }

    @inlinable public init(truncatingIfNeeded source: some BinaryInteger) {
        self.init(bitPattern: Body(truncatingIfNeeded: source))
    }
}
