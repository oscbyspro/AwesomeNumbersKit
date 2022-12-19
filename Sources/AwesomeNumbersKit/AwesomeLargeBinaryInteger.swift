//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * Awesome x Binary Integer x Large
//*============================================================================*

/// A large binary integer with additional requirements and capabilities.
///
/// ```
/// self.bitWidth / UInt.bitWidth >= 1
/// self.bitWidth % UInt.bitWidth == 0
/// ```
public protocol AwesomeLargeBinaryInteger: AwesomeBinaryInteger where Magnitude: AwesomeUnsignedLargeBinaryInteger { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Signed
//*============================================================================*

public protocol AwesomeSignedLargeBinaryInteger: AwesomeLargeBinaryInteger, AwesomeSignedInteger { }

//*============================================================================*
// MARK: * Awesome x Fixed Width Integer x Large x Unsigned
//*============================================================================*

public protocol AwesomeUnsignedLargeBinaryInteger: AwesomeLargeBinaryInteger, AwesomeUnsignedInteger { }
