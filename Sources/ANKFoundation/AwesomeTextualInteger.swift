//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Binary Integer x Textual
//*============================================================================*

public protocol AwesomeTextualInteger: BinaryInteger, ExpressibleByStringLiteral {

    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self?
    
    @inlinable static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String
}

//=----------------------------------------------------------------------------=
// MARK: + Details
//=----------------------------------------------------------------------------=

extension AwesomeTextualInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
        
    @_transparent public init(stringLiteral source: String) {
        self.init(decode: source, radix: nil)!
    }
    
    @_transparent public init?(decode source: some StringProtocol, radix: Int? = nil) {
        guard let value = Self.decodeBigEndianText(source, radix: radix) else { return nil }; self = value
    }
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
    
    @inlinable public var description: String {
        Self.encodeBigEndianText(self, radix: 10, uppercase: false)
    }
    
    @inlinable public static func encodeBigEndianText(_ source: Self, radix: Int, uppercase: Bool) -> String {
        String(source, radix: radix, uppercase: uppercase)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x Fixed Width
//=----------------------------------------------------------------------------=

extension AwesomeTextualInteger where Self: FixedWidthInteger {
    
    //=------------------------------------------------------------------------=
    // MARK: Utilities
    //=------------------------------------------------------------------------=
        
    @inlinable public static func decodeBigEndianText(_ source: some StringProtocol, radix: Int?) -> Self? {
        Self(source, radix: radix ?? 10)
    }
}

//=----------------------------------------------------------------------------=
// MARK: + Details x String
//=----------------------------------------------------------------------------=

extension String {
    
    //=------------------------------------------------------------------------=
    // MARK: Initializers
    //=------------------------------------------------------------------------=
    
    @inlinable public init(encode source: some AwesomeTextualInteger, radix: Int = 10, uppercase: Bool = false) {
        self = type(of: source).encodeBigEndianText(source, radix: radix, uppercase: uppercase)
    }
}
