# Flutter SDK (Web Development)

This feature installs the Flutter SDK optimized for web development in your dev container.

## Example Usage

```json
"features": {
    "ghcr.io/kuchitake/devcontainer-features/flutter:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select Flutter version or channel. Use 'latest' for the most recent stable, or specify a version like '3.16.0'. | string | stable |
| channel | Flutter release channel to use. | string | stable |
| enableWebSupport | Enable Flutter web support after installation. | boolean | true |

## Supported Versions

- `latest` - Latest stable release
- `stable` - Stable channel
- `beta` - Beta channel  
- `dev` - Dev channel
- Specific versions like `3.16.0`, `3.13.9`, etc.

## Supported Architectures

- `linux/amd64` (x86_64)
- `linux/arm64` (aarch64)

## Usage Examples

### Default Installation (Stable Channel)

```json
"features": {
    "ghcr.io/kuchitake/devcontainer-features/flutter:1": {}
}
```

### Beta Channel

```json
"features": {
    "ghcr.io/kuchitake/devcontainer-features/flutter:1": {
        "version": "beta",
        "channel": "beta"
    }
}
```

### Specific Version

```json
"features": {
    "ghcr.io/kuchitake/devcontainer-features/flutter:1": {
        "version": "3.16.0",
        "channel": "stable"
    }
}
```

### Without Web Support

```json
"features": {
    "ghcr.io/kuchitake/devcontainer-features/flutter:1": {
        "enableWebSupport": false
    }
}
```

## What's Installed

- Flutter SDK
- Dart SDK (included with Flutter)
- Required dependencies (git, curl, unzip, etc.)
- Web support (if enabled)

## Installation Location

Flutter is installed to `/opt/flutter` and added to the system PATH.

## Post-Installation

After installation, you can:

1. Create a new Flutter web project:
   ```bash
   flutter create --platforms web my_web_app
   cd my_web_app
   ```

2. Run the web app:
   ```bash
   flutter run -d web-server --web-port 8080 --web-hostname 0.0.0.0
   ```

3. Build for web:
   ```bash
   flutter build web
   ```

## Verification

The installation can be verified by running:

```bash
flutter doctor
flutter --version
```

## Notes

- This feature is optimized for web development and does not include Android/iOS development tools
- Analytics are disabled by default for privacy
- The installation uses official Flutter releases from Google's storage
- No version managers (like asdf) are used to ensure compatibility across architectures