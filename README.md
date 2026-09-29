# Autonomous Robot

This is our senior project: an autonomous robot built to take over the repetitive jobs in a warehouse, like finding items, running the same routes over and over, and doing the boring stuff so people don't have to.

We're team **010101010101** which stands for 'Hello World', and this repo is where the whole project comes together in one place.

> **Heads up:** we're still early. Plenty here is scaffolding and "hello world" for now, and it'll fill in as we build. Got questions? So do we.

## What's in here

The project is split into a few parts. Each one has its own repo where we do the actual day-to-day work, and they all get copied into this monorepo so you can see everything at once.

| Folder | What it is | Language |
| --- | --- | --- |
| [`robot/`](robot/) | The robot's brain. Core system, hardware control, and the connection layer that lets it talk to the outside world. | C++ |
| [`mobile-app/`](mobile-app/) | The app we use to monitor the robot and tell it what to do. | TypeScript |
| [`computer-vision/`](computer-vision/) | How the robot sees: detecting objects, recognizing where it is, and the models behind it. | Python |

We also use Python for scripting and tooling, basically anything that isn't the robot's core or the app.

## How the pieces fit

The rough idea:

1. **The robot** (C++) runs on the hardware. It drives the motors, reads the sensors, and makes decisions.
2. **Computer vision** (Python) helps it understand what's around it, so it can find things and avoid bumping into them.
3. **The mobile app** (TypeScript) is how a person checks in on the robot, sees what it's doing, and gives it tasks.

## Getting started

### Robot

You'll need CMake (3.16+) and a C++17 compiler.

```bash
cd robot
./build.sh
```

That configures, builds, and runs `coreSystem`. If you'd rather do it by hand:

```bash
cmake -S . -B build
cmake --build build
./build/coreSystem
```

### Mobile app and computer vision

Setup instructions are coming once there's more to set up. Check each folder's README for updates.

## How this repo works (please read before editing!)

**Don't edit code directly in this repo.** It's generated from our component repos:

- [SeniorProject010101/robot](https://github.com/SeniorProject010101/robot)
- [SeniorProject010101/mobile-app](https://github.com/SeniorProject010101/mobile-app)
- [SeniorProject010101/computer-vision](https://github.com/SeniorProject010101/computer-vision)

Make your changes in the right component repo. Then someone runs `putAllInOne.sh`, which:

1. pulls the latest from every repo,
2. copies each component in here (skipping `.git` and anything in its `.gitignore`),
3. commits whatever changed and pushes it.

Anything you change directly in a component folder here gets overwritten on the next sync. The one exception is this README, since it lives only in this repo.
