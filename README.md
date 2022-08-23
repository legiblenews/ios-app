# Legible News iOS App

Yup, this is the official iOS App for Legible News. It's a Turbo app, but one that tries to use SwiftUI as much as possible (as opposed to UIKit, which everybody seems to be using).

## Getting Started

To run this application, boot the [server](https://github.com/legiblenews/server), point the URLs to it, and then build the thing.

## Dependencies

This thing relies on a few third-party packages:

### [Turbo iOS](https://github.com/hotwired/turbo-ios)

Manages the interaction between the iOS app and the Rails server. I have an ongoing issue at https://github.com/hotwired/turbo-ios/issues/8 to get Turbo working with SwiftUI.

### [NavigationBackport](https://github.com/johnpatrickmorgan/NavigationBackport)

This makes the NavigationStack SwiftUI component that was introduced in iOS 16 work with older versions of SwiftUI. I was able to use this to get a contributors code snipper working on my older development environemtn, which targets iOS 15.
