# homebrew-tap

Homebrew tap for personal tools.

## Usage

```bash
brew tap mhjiang97/tap
```

## Available Casks

| Cask            | Description                                                                       |
| --------------- | --------------------------------------------------------------------------------- |
| `mount-manager` | macOS menu bar app for managing [oxfs](https://github.com/oxfs/oxfs) SSHFS mounts |
| `caffeinate`    | macOS menu bar wrapper for `/usr/bin/caffeinate`                                  |

### Install MountManager

```bash
brew install --cask mount-manager
```

This will automatically install [macFUSE](https://macfuse.github.io/) if not already present.

### Install Caffeinate

```bash
brew install --cask caffeinate
```
