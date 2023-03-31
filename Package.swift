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
        // ANK x Foundation
        //=--------------------------------------=
        .library(
        name: "ANKFoundation",
        targets: ["ANKFoundation"]),
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
        dependencies: ["ANKFoundation", "ANKFullWidthKit", "ANKSignedKit"],
        path: "Bundles/AwesomeNumbersKit"),
        //=--------------------------------------=
        // ANK x Foundation
        //=--------------------------------------=
        .target(
        name: "ANKFoundation",
        dependencies: []),
        
        .testTarget(
        name: "ANKFoundationTests",
        dependencies: ["ANKFoundation"]),
        
        .testTarget(
        name: "ANKFoundationBenchmarks",
        dependencies: ["ANKFoundation"]),
        //=--------------------------------------=
        // ANK x Full Width Kit
        //=--------------------------------------=
        .target(
        name: "ANKFullWidthKit",
        dependencies: ["ANKFoundation"]),
        
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
        dependencies: ["ANKFoundation"]),
        
        .testTarget(
        name: "ANKSignedKitTests",
        dependencies: ["ANKFullWidthKit", "ANKSignedKit"]),
        
        .testTarget(
        name: "ANKSignedKitBenchmarks",
        dependencies: ["ANKFullWidthKit", "ANKSignedKit"]),
    ]
)
