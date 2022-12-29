//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Binary Integer x Textualizable
//*============================================================================*

public protocol ANKTextualizableInteger: BinaryInteger, ExpressibleByStringLiteral {

    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self?
    
    @inlinable static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension ANKTextualizableInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
        
    @_transparent public init(stringLiteral source: String) {
        self.init(decoding: source, radix: nil)!
    }
    
    @_transparent public init?(decoding source: some StringProtocol, radix: Int? = nil) {
        guard let value = Self.decodeBigEndianText(source, radix: radix) else { return nil }; self = value
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @_transparent public var description: String {
        Self.encodeBigEndianText(self, radix: 10, uppercase: false)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x String
//=----------------------------------------------------------------------------=

extension String {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @_transparent public init(encoding source: some ANKTextualizableInteger, radix: Int = 10, uppercase: Bool = false) {
        self = type(of: source).encodeBigEndianText(source, radix: radix, uppercase: uppercase)
    }
}
