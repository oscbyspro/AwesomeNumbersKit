// swift-tools-version: 5.8
//=----------------------------------------------------------------------------=
// This source file is part of the AwesomeNumbersKit open source project.
//
// Copyright (c) 2022 Oscar Byström Ericsson
// Licensed under Apache License, Version 2.0
//
// See http://www.apache.org/licenses/LICENSE-2.0 for license information.
//=----------------------------------------------------------------------------=

import PackageDescription

//*============================================================================*
// MARK: * Awesome Numbers Kit
//*============================================================================*

let package = Package(
    name: "AwesomeNumbersKit",
    platforms: [
        .iOS("16.4"),
        .macCatalyst("16.4"),
        .macOS("13.3"),
        .tvOS("16.4"),
        .watchOS("9.4"),
    ],
    products: [
        //=--------------------------------------=
        // ANK
        //=--------------------------------------=
        .library(
        name: "AwesomeNumbersKit",
        targets: ["AwesomeNumbersKit"]),
        //=--------------------------------------=
        // ANK x Core Kit
        //=--------------------------------------=
        .library(
        name: "ANKCoreKit",
        targets: ["ANKCoreKit"]),
        //=--------------------------------------=
        // ANK x Full Width Kit
        //=--------------------------------------=
        .library(
        name: "ANKFullWidthKit",
        targets: ["ANKFullWidthKit"]),
        //=--------------------------------------=
        // ANK x Signed Kit
        //=--------------------------------------=
        .library(
        name: "ANKSignedKit",
        targets: ["ANKSignedKit"]),
    ],
    targets: [
        //=--------------------------------------=
        // ANK
        //=--------------------------------------=
        .target(
        name: "AwesomeNumbersKit",
        dependencies: ["ANKCoreKit", "ANKFullWidthKit", "ANKSignedKit"]),
        //=--------------------------------------=
        // ANK x Core Kit
        //=--------------------------------------=
        .target(
        name: "ANKCoreKit",
        dependencies: []),
        
        .testTarget(
        name: "ANKCoreKitTests",
        dependencies: ["ANKCoreKit"]),
        
        .testTarget(
        name: "ANKCoreKitBenchmarks",
        dependencies: ["ANKCoreKit"]),
        //=--------------------------------------=
        // ANK x Full Width Kit
        //=--------------------------------------=
        .target(
        name: "ANKFullWidthKit",
        dependencies: ["ANKCoreKit"]),
        
        .testTarget(
        name: "ANKFullWidthKitTests",
        dependencies: ["ANKFullWidthKit"]),
        
        .testTarget(
        name: "ANKFullWidthKitBenchmarks",
        dependencies: ["ANKFullWidthKit"]),
        //=--------------------------------------=
        // ANK x Signed Kit
        //=--------------------------------------=
        .target(
        name: "ANKSignedKit",
        dependencies: ["ANKCoreKit"]),
        
        .testTarget(
        name: "ANKSignedKitTests",
        dependencies: ["ANKFullWidthKit", "ANKSignedKit"]),
        
        .testTarget(
        name: "ANKSignedKitBenchmarks",
        dependencies: ["ANKFullWidthKit", "ANKSignedKit"]),
    ]
)
