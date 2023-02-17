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
// MARK: * Types
//*============================================================================*

enum Types {
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    static let ANKBinaryInteger: [any ANKBinaryInteger.Type] =
    [Int.self,  Int8.self,  Int16.self,  Int32.self,  Int64.self,
    UInt.self, UInt8.self, UInt16.self, UInt32.self, UInt64.self]
    
    static let ANKSignedInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKSignedInteger.Type })
    
    static let ANKUnsignedInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKUnsignedInteger.Type })
    
    static let ANKLargeBinaryInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKLargeBinaryInteger.Type })
    
    static let ANKSignedLargeBinaryInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKSignedLargeBinaryInteger.Type })
    
    static let ANKUnsignedLargeBinaryInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKUnsignedLargeBinaryInteger.Type })
    
    static let ANKFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKFixedWidthInteger.Type })
    
    static let ANKSignedFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKSignedFixedWidthInteger.Type })
    
    static let ANKUnsignedFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKUnsignedFixedWidthInteger.Type })
    
    static let ANKLargeFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKLargeFixedWidthInteger.Type })
    
    static let ANKSignedLargeFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKSignedLargeFixedWidthInteger.Type })
    
    static let ANKUnsignedLargeFixedWidthInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKUnsignedLargeFixedWidthInteger.Type })
    
    static let ANKUnsafeRawInteger =
    ANKBinaryInteger.compactMap({ $0 as? any ANKUnsafeRawInteger.Type })
    
    //=------------------------------------------------------------------------=
    // MARK: Accessors
    //=------------------------------------------------------------------------=
    
    static let ANKBigEndianTextCodable =
    ANKBinaryInteger.compactMap({ $0 as? any (ANKBigEndianTextCodable & ANKBinaryInteger).Type })
    
    static let ANKIntOrUInt =
    ANKBinaryInteger.compactMap({ $0 as? any ANKIntOrUInt.Type })
}
