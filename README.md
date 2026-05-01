# WeatherNotes

Simple SwiftUI app for notes with weather snapshots from OpenWeather.

## What you need before launch

- Xcode 16+
- iOS Simulator (or real iPhone)
- OpenWeather API key

## Setup API key

1. Open file: `WeatherNotes/Secrets.example.plist`
2. Find this block:

```xml
<key>OPENWEATHER_API_KEY</key>
<string>YOUR_OPENWEATHER_API_KEY</string>
```

3. Replace `YOUR_OPENWEATHER_API_KEY` with your real key.

## Run project

1. Open `WeatherNotes.xcodeproj` in Xcode.
2. Select `WeatherNotes` scheme.
3. Run on simulator/device.

## How to test quickly

1. Tap `+` on the notes list screen.
2. Enter note text.
3. Tap `Save`.
4. Check that note appears with temperature + weather icon.
5. Open note details to see full weather snapshot.

## Notes

- App tries to read key from:
  1. environment variable `OPENWEATHER_API_KEY`
  2. `Secrets.plist`
  3. `Secrets.example.plist`
- If weather loading fails, verify your key is active on OpenWeather.
