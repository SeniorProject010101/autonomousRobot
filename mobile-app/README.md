# Hello World — React Native (TypeScript)

A minimal React Native app, built with [Expo](https://expo.dev) and TypeScript, that shows **"Hello, world"** on the screen.

## Prerequisites

- **Python 3.8+** (used only to create the virtual environment)
- Optional, for running on a phone: the **Expo Go** app ([iOS](https://apps.apple.com/app/expo-go/id982107779) / [Android](https://play.google.com/store/apps/details?id=host.exp.exponent))

You do **not** need Node.js installed globally. `requirements.txt` installs
[`nodeenv`](https://pypi.org/project/nodeenv/), which puts Node.js and npm inside the virtual environment.

## Setup (one time)

macOS / Linux:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
nodeenv -p --node=lts        # installs Node.js + npm into .venv
deactivate && source .venv/bin/activate   # reload so `node`/`npm` are on PATH
npm install                  # installs React Native, Expo, TypeScript (from package.json)
```

Windows (PowerShell):

```powershell
py -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
nodeenv -p --node=lts
deactivate; .venv\Scripts\Activate.ps1
npm install
```

## Run

With the virtual environment activated:

```bash
npm run web        # opens the app in a browser window
npm start          # shows a QR code: scan it with Expo Go on your phone
npm run ios        # iOS Simulator (macOS + Xcode required)
npm run android    # Android emulator (Android Studio required)
```

You should see **Hello, world** centered on the screen.

## Why both `requirements.txt` and `package.json`?

React Native is a JavaScript framework, so its libraries (`react`, `react-native`, `expo`,
`typescript`, …) are listed in `package.json` and installed by npm. pip cannot install them.
`requirements.txt` holds the Python tooling (`nodeenv`) that provides Node.js/npm inside the
virtual environment, so the whole toolchain stays contained in `.venv/`.

## Project layout

| File | Purpose |
| --- | --- |
| `App.tsx` | The screen that renders "Hello, world" |
| `index.ts` | Registers `App` as the root component |
| `app.json` | Expo app config (name, icons, etc.) |
| `package.json` | JavaScript dependencies and run scripts |
| `requirements.txt` | Python dependencies (`nodeenv`) |
| `tsconfig.json` | TypeScript config |
