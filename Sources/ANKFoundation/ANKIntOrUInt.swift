//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

//*============================================================================*
// MARK: * ANK x Int Or UInt
//*============================================================================*

/// A type that is either `Int` or `UInt`.
///
///  Only `Int` and `UInt` in the standard library may conform to this protocol.
///
public protocol ANKIntOrUInt: ANKCoreInteger where Magnitude == UInt { }

//*============================================================================*
// MARK: * ANK x Int Or UInt x Swift
//*============================================================================*

extension  Int: ANKIntOrUInt { }
extension UInt: ANKIntOrUInt { }
