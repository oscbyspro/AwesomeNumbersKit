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
// MARK: * ANK x (U)Int64
//*============================================================================*
//=----------------------------------------------------------------------------=
// await build condition akin to #if MemoryLayout<UInt>.size == 8
//=----------------------------------------------------------------------------=

#if arch(i386) || arch(arm) || arch(arm64_32) || arch(wasm32) || arch(powerpc)

public typealias  ANKInt64 = ANKFullWidth< Int, UInt>
public typealias ANKUInt64 = ANKFullWidth<UInt, UInt>

#elseif arch(x86_64) || arch(arm64) || arch(powerpc64) || arch(powerpc64le) || arch(s390x)

public typealias  ANKInt64 =  Int
public typealias ANKUInt64 = UInt

#else

public typealias  ANKInt64 = Never
public typealias ANKUInt64 = Never

#error("ANKFullWidth can only be used on a 32-bit or 64-bit platform.")
#endif
