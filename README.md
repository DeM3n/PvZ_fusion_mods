# Plants vs. Zombies Fusion - Modding Documentation & Repository

This repository provides technical reverse-engineering documentation, API references, and open-source mod implementations for **Plants vs. Zombies Fusion** built on **Unity Il2Cpp**.

---

## Technical Documentation Suite

The documentation suite provides technical references for reverse engineering and developing mods targeting the game using **MelonLoader** (.NET 6.0):

1. **[01. Environment Setup & Reverse Engineering](docs/01-getting-started.md)**
   * Architectural analysis of the Unity Il2Cpp runtime.
   * Restoring interop assemblies from `MelonLoader/Il2CppAssemblies/`.
   * Inspecting internal classes and methods with DnSpy / ILSpy.
   * Project configuration for .NET 6.0 Class Libraries.

2. **[02. Game Architecture & Il2Cpp Interop](docs/02-game-architecture.md)**
   * Native C++ memory representation and managed proxy objects.
   * Strict type casting conventions: `TryCast<T>()` versus managed `as`.
   * Accessing match state via the `Board.Instance` singleton.
   * Entity lifecycle validation (`dying`, `waitingDestory`).
   * Framerate preservation via tick rate throttling (4 Hz) and attribute caching.

3. **[03. Ultimate Plant Series & Modifier System](docs/03-ultimate-plants-and-modifiers.md)**
   * Complete reference catalog of the Ultimate plant series across all evolution trees.
   * Assembly code names mapped to in-game plant identities.
   * Travel Mode modifier query system: `Lawnf.TravelUltimate((UltiBuff)id)`.
   * Code anatomy of **Charmatron (`UltimateHypno`)**: charge states (`mag1`, `mag2`, `mag3`), item consumption (`UseItem`), and Modifier 19 handling.

4. **[04. Auxiliary Systems: Zombies, Buckets & Lawnf Utilities](docs/04-other-entities.md)**
   * Zombie hierarchy: `Zombie` class, `ZombieType` enumeration, health, and status effects.
   * Dropped metallic items: `Bucket` class, `BucketType`, `UseItem()`, and `AutoStorage()`.
   * Central static utility functions in `Lawnf`.

---

## Mod Catalog

This repository is structured as a multi-project solution (`PvZ_fusion_mods.sln`) to maintain independent mod modules:

* **[Charmatron Auto Feed (`src/CharmatronAutoFeed`)](src/CharmatronAutoFeed/CharmatronAutoFeed.cs):**
  * *Version:* 1.0.6 (Author: DeM3n).
  * *Description:* Automatically locates and feeds metallic items (e.g., buckets) to Charmatron (`UltimateHypno`) instances requiring charge.
  * *Implementation:* Implements 4 Hz tick throttling, lifecycle null-checking, and Modifier 19 detection to dynamically enforce Level 2 versus Level 3 saturation limits.

---

## Build Instructions

### Method 1: Local Batch Script
Run the automated build script:
```cmd
build.bat
```

### Method 2: .NET CLI
Compile the entire solution in Release configuration:
```bash
dotnet build PvZ_fusion_mods.sln -c Release
```
Compiled output assemblies are placed in `src/<ModName>/bin/Release/<ModName>.dll`.

---

## Contributing

The catalog in [docs/03-ultimate-plants-and-modifiers.md](docs/03-ultimate-plants-and-modifiers.md) maintains `[TBD]` markers for unverified localized in-game names and travel mode modifier mappings. Contributions refining these entries or adding new mod modules are welcome via pull requests.
