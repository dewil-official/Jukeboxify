# Jukeboxify 📡
Connecting Spotify to NFC tags for Home Automation! (Flutter App &amp; Dart Server)

## Setup Instructions 🧰

The project will later contain two independant codebases.

The `mobile` folder contains the Flutter App, which is the main part.

### Mobile App

Navigate into the `mobile` folder.

You must first [install Flutter](https://flutter.dev/docs/get-started/install).
Then, you can run `flutter pub get` to install the dependencies.

Finally, just run `flutter run` to start the App!

### Raspberry Pi Server

This part of the project is not yet started.

## The Idea 💡

A friend shared [this youtube video](https://youtu.be/AvCseOQidSw?list=FLJYZ5AE9dBcOqeFTZ4OuHnw) with me.
Inspired by it, I wanted to build an App, that could write something onto NFC tags, so that they would start a Spotify Song / Playlist when being scanned.

Later this could be expanded by a Raspberry Pi server that syncs the phone data and is able to scan the NFC tags by itself. Then, a phoneless variant (like in the video) would be possible.

## Requirements 📱

I'm using this App to assess three modules: Clean Code, Testing and Native Mobile Development. Accordingly, the App needs to:

- Write and read NFC tags
- Handle App Intents (Used for Auth & NFC-Tag reading)
- Store these Tag IDs in a Database
- Access the Spotify API
- Have a lot of tests (I'm doing TDD)
- Be well-refactored (Clean Code)

## Architecture 🏗

I'm following the TDD Clean Architecture for Flutter, as proposed by [Reso Coder](https://resocoder.com/category/tutorials/flutter/tdd-clean-architecture/).

The app is divided into separate 'Features'. Every feature is divided into three 'Layers'. That looks like the following:

- /presentation
  - /bloc (Container for the State)
  - /pages (Widgets that are routed)
  - /widgets (Most UI / All Widgets)
- /domain
  - /usecases (Defines the Actions, that can be taken. Contains the main logic.)
  - /entities (Abstract Data Models)
  - /repositories (Abstract Collection of what Data needs to be accessed)
- /data
  - /models (Implement the Entities, additional Conversion logic)
  - /repositories (Implementation of the Abstract Repositories)
  - /datasources (API Clients, Storage Handlers, Sensors, ...)

Each layer works completely independent and is therefore testable

