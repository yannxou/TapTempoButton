# TapTempoButton

A SwiftUI View that easily brings tap tempo functionality to music apps.

## How it works

The `TapTempoButton` takes a content closure so it can be customized. The whole view will handle the tap events automatically and calculate the tempo average (in BPM) which is sent in the `onTempoChange` closure on each change.

Rather than processing the touch events like a standard Button (on touch up) the view handles them on touch down so the button behaviour is more natural in a musical context. 

## Usage

Add the `TapTempoButton` to your View and customize it with the content closure.

```swift
TapTempoButton(onTempoChange: {
    self.tempo = $0
}) {
    Text("Tap")
}
```

### Configuration

The following properties can be configured on initialization:

* `tempoRange`: Defines the minimum and maximum tempo that can be detected.
* `timeout`: Seconds of inactivity after which the ongoing detection will be restarted.
* `minTaps`: Minimum number of taps required before sending values to the `onTempoChange` closure.
* `roundDecimals`: Number of decimals to round the BPM to. Set to `0` for integer-only BPM (no decimals). Set to `nil` to disable rounding.

## Installation

1. From the File menu, select Add Packages...
2. Enter package repository URL: https://github.com/yannxou/TapTempoButton
3. Confirm the version and let Xcode resolve the package

## Support

The idea for this library appeared while working on the app [Vetro: Visual Metronome](https://apps.apple.com/app/vetro-visual-metronome/id1637121079) for iOS/macOS. If you like it you can support by buying any of [our apps](https://apps.apple.com/es/developer/natalia-artigas/id957299596).

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
