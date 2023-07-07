# Legible News iOS App

Yup, this is the official [iOS App for Legible News](https://apps.apple.com/us/app/legible-news/id1643266439). It's a Turbo app, but one that uses SwiftUI as much as possible (as opposed to UIKit, which everybody seems to be using).

## Getting Started

To run this application, boot the [server](https://github.com/legiblenews/server), change the `ROOT_URL` in "Build Settings" to point to your local development server.

## Why not use UIKit?

The short answer; I like the conciseness of SwiftUI and want to use it to build Hybrid web applications. I've published the source code of the project so others can critique my approach and hopefully offer input how how to improve it.

The ultimate goal is SwiftTurbo library that hopefully makes its way into the official repo, giving myself and others in the Rails community more choices on how to build iOS apps that work with Turbo.

## Dependencies

This thing relies on a few third-party packages:

### [Turbo iOS](https://github.com/hotwired/turbo-ios)

Manages the interaction between the iOS app and the Rails server. I have an ongoing issue at https://github.com/hotwired/turbo-ios/issues/8 to get Turbo working with SwiftUI.

### [NavigationBackport](https://github.com/johnpatrickmorgan/NavigationBackport)

This makes the NavigationStack SwiftUI component that was introduced in iOS 16 work with older versions of SwiftUI. I was able to use this to get a contributors code snipper working on my older development environemtn, which targets iOS 15.