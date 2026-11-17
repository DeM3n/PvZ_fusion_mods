# Technical Documentation: Ultimate Plant Series & Modifier System

This document provides a technical reference for the **Ultimate Plant Series** in Plants vs. Zombies Fusion, mapping internal assembly types and enumerations to in-game representations, and detailing the associated **Travel Mode Modifiers / Buffs**.

---

## 1. Architectural Representation in Code

Inside `Assembly-CSharp.dll`:
1. **Type Definition:** Each Ultimate plant has a discrete enumeration constant in `PlantType` (typically prefixed with `Ultimate` or `Ulti_`).
2. **Entity Class:** Most Ultimate plants inherit directly from `Plant` or `Shooter` (e.g., `UltimateHypno`, `UltimateGatling`, `UltimateChomper`).
3. **Evolution Configuration (`BaseConfig`):** Evolution lines inherit from `BaseConfig`, exposing `Role`, `Buffs`, and `ReinforcePlant()` methods.

### Inspecting an Ultimate Plant Instance:
```csharp
if (plant.thePlantType == PlantType.UltimateHypno)
{
    var hypno = plant.TryCast<UltimateHypno>();
    if (hypno != null)
    {
        // Execute plant-specific operations
    }
}
```

---

## 2. Comprehensive Ultimate Plant Reference Catalog

> [!NOTE]
> Fields marked with **`[TBD]`** represent entries pending verification of their localized in-game names or specific travel mode modifier mappings.

### 2.1. Hypno & Scaredy Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateHypno` | Hypno-shroom / Scaredy | Charmatron | **Dual Modifiers:**<br>• **Modifier 18 (`UltiBuff.18` - Weak Modifier):** Base potency upgrade enhancing hypno bullet effectiveness and charming mechanics.<br>• **Modifier 19 (`UltiBuff.19` - Strong Modifier):** Unlocks the **Level 3** charge tier (`mag3`). Without Modifier 19, charge capacity is restricted to **Level 2** (`mag2`). Consumes metallic buckets via `UseItem()`. |
| `UltimateHypnoDoom` | Hypno + Doom-shroom | [TBD] | [TBD] |
| `UltimateDoomScared` | Scaredy + Doom-shroom | [TBD] | [TBD] |
| `UltimateHypnoPumpkin` | `UltimateHypno` + Pumpkin | Charmatron Pumpkin | **Inherited Modifiers:** Sub-species of `UltimateHypno`. Directly inherits both **Modifier 18** and **Modifier 19** from the base Charmatron archetype. |

---

### 2.2. Peashooter & Sniper Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateGatling` | Gatling Pea | Ultimate Gatling | [TBD] |
| `UltimateHelmetGatling` | Gatling + Helmet | [TBD] | [TBD] |
| `UltimateBigGatling` | Large-frame Gatling | [TBD] | [TBD] |
| `UltimateSniperGatling` | Gatling + Sniper | [TBD] | [TBD] |
| `UltimateMinigun` | Rotary Cannon | [TBD] | [TBD] |
| `UltimateBigSniper` | Heavy Sniper Pea | [TBD] | [TBD] |
| `UltimateDoomGatling` | Gatling + Doom-shroom | [TBD] | [TBD] |

---

### 2.3. Chomper Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateChomper` | Chomper | Ultimate Chomper | [TBD] |
| `UltimateBigChomper` | Super Chomper | [TBD] | [TBD] |
| `GarlicUltimateChomper` | Garlic + Chomper | [TBD] | [TBD] |

---

### 2.4. Nut & Defense Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateTallNut` | Tall-Nut | Ultimate Tall-Nut | [TBD] |
| `UltimateHugeNut` | Giant Wall-Nut | [TBD] | [TBD] |
| `UltimatePotatoNut` | Potato Mine + Nut | [TBD] | [TBD] |
| `UltimatePortalNut` | Portal Nut | [TBD] | [TBD] |
| `UltimateMachineNut` | Mechanized Nut | [TBD] | [TBD] |
| `UltimateSunNut` | Sunflower + Wall-Nut | [TBD] | [TBD] |

---

### 2.5. Melon & Cabbage Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateMelon` | Melon-pult | Ultimate Melon-pult | [TBD] |
| `UltimateWinterMelon` | Winter Melon | Ultimate Winter Melon | [TBD] |
| `UltimateMelonCannon` | Melon + Cannon | [TBD] | [TBD] |
| `UltimateCabbage` | Cabbage-pult | Ultimate Cabbage-pult | [TBD] |
| `UltimateCabbageCannon` | Cabbage Cannon | [TBD] | [TBD] |
| `UltimateLunarCabbage` | Lunar Cabbage | [TBD] | [TBD] |

---

### 2.6. Fume & Gloom Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateFume` | Fume-shroom | Ultimate Fume-shroom | [TBD] |
| `UltimatePoisonFume` | Toxic Fume-shroom | [TBD] | [TBD] |
| `UltimateGloom` | Gloom-shroom | Ultimate Gloom-shroom | [TBD] |

---

### 2.7. Elemental & Specialized Series

| Code Identifier (Class / Enum) | Evolution Line Base | In-Game Identifier | Associated Modifier / Buff Effect |
| :--- | :--- | :--- | :--- |
| `UltimateTorch` | Torchwood | Ultimate Torchwood | [TBD] |
| `UltimateStar` | Starfruit | Ultimate Starfruit | [TBD] |
| `UltimateStarTorch` | Starfruit + Torchwood | [TBD] | [TBD] |
| `UltimateHolyStar` | Celestial Star | [TBD] | [TBD] |
| `UltimateCactus` | Cactus | Ultimate Cactus | [TBD] |
| `UltimateBamboo` | Fusion Bamboo | Ultimate Bamboo | [TBD] |
| `UltimateSpruce` | Spruce Shooter | Ultimate Spruce | [TBD] |
| `UltimateBlover` | Blover | Ultimate Blover | [TBD] |
| `UltimateGatlingBlover` | Blover + Gatling | [TBD] | [TBD] |
| `UltimateMagnet` | Magnet-shroom | Ultimate Magnet-shroom | [TBD] |
| `UltimateSunMagnet` | Solar Magnet | [TBD] | [TBD] |
| `UltimateJalapeno` | Jalapeno | Ultimate Jalapeno | [TBD] |
| `UltimateIceShroom` / `IceShroom2` | Ice-shroom | Ultimate Ice-shroom | [TBD] |
| `UltimateIceDoom` | Ice-shroom + Doom | [TBD] | [TBD] |
| `UltimateCannon` | Cob Cannon | Ultimate Cob Cannon | [TBD] |
| `UltimateSunflower` | Sunflower | Ultimate Sunflower | [TBD] |

---

## 3. Travel Mode Modifiers & Dual Modifier Architecture

In the Travel/Adventure game mode, gameplay modifications are enumerated under `UltiBuff` and evaluated through static helper routines:

```csharp
bool isBuffActive = Lawnf.TravelUltimate((UltiBuff)buffIndex);
```

### 3.1. Mathematical Architecture: Weak vs. Strong Modifiers

The internal game engine pairs exactly **two modifiers** to each of the 28 registered Ultimate plants in `TravelUnlocks` (indices 0 to 27):
* **Weak Modifier (Tier 1):** Unlocks base utility, attack enhancement, or preliminary passive effects.
* **Strong Modifier (Tier 2):** Unlocks advanced combat mechanics, secondary forms, or extra level caps.

Because there are 28 Ultimate plants and 56 total `UltiBuff` constants (indices 0 to 55), the engine maps them via direct index parity:

$$\text{Weak Modifier ID} = \text{PlantIndex} \times 2$$
$$\text{Strong Modifier ID} = \text{PlantIndex} \times 2 + 1$$

### 3.2. Index Mapping Table for All 28 Ultimate Plants

| Plant Index (`TravelUnlocks`) | Plant Name | Weak Modifier (`UltiBuff`) | Strong Modifier (`UltiBuff`) |
| :---: | :--- | :---: | :---: |
| 0 | `UltimateChomper` | 0 | 1 |
| 1 | `UltimateGatling` | 2 | 3 |
| 2 | `UltimateFume` | 4 | 5 |
| 3 | `UltimateTorch` | 6 | 7 |
| 4 | `UltimateStar` | 8 | 9 |
| 5 | `UltimateGloom` | 10 | 11 |
| 6 | `UltimateMelon` | 12 | 13 |
| 7 | `UltimateCannon` | 14 | 15 |
| 8 | `UltimateTallNut` | 16 | 17 |
| **9** | **`UltimateHypno`** | **18** | **19** |
| 10 | `UltimateBigGatling` | 20 | 21 |
| 11 | `UltimateCabbage` | 22 | 23 |
| 12 | `UltimatePumpkin` | 24 | 25 |
| 13 | `UltimateSpring` | 26 | 27 |
| 14 | `UltimateKelp` | 28 | 29 |
| 15 | `UltimateCorn` | 30 | 31 |
| 16 | `UltimateSpruce` | 32 | 33 |
| 17 | `UltimateBigChomper` | 34 | 35 |
| 18 | `UltimateExplodeCannon` | 36 | 37 |
| 19 | `UltimateSunflower` | 38 | 39 |
| 20 | `UltimateWinterMelon` | 40 | 41 |
| 21 | `UltimateCattail` | 42 | 43 |
| 22 | `UltimateSeaShroom` | 44 | 45 |
| 23 | `UltimateJalapeno` | 46 | 47 |
| 24 | `UltimateLanternSplit` | 48 | 49 |
| 25 | `UltimateHelmetGatling` | 50 | 51 |
| 26 | `UltimateHugeNut` | 52 | 53 |
| 27 | `UltimateFurnace` | 54 | 55 |

### 3.3. Case Study: Charmatron (`UltimateHypno`) Modifiers
* **Plant Index:** 9 (`TravelUnlocks.UltimateHypno`).
* **Modifier 18 (`(UltiBuff)18` - Weak):** Evaluated by the engine via `Lawnf.TravelUltimate((UltiBuff)18)` or `TravelMgr.Instance.WeakUltiPlantBuffUnlock(PlantType.UltimateHypno)`. Enhances base charm attack mechanics.
* **Modifier 19 (`(UltiBuff)19` - Strong):** Evaluated via `Lawnf.TravelUltimate((UltiBuff)19)` or `TravelMgr.Instance.StrongUltiPlantBuffUnlock(PlantType.UltimateHypno)`. Enables the third charge level (`mag3`), permitting Level 3 saturation. Default saturation limit is Level 2 (`mag2`).

### 3.4. Sub-Species Variants & Modifier Inheritance

In PvZ Fusion, core Ultimate plants frequently have **Sub-Species (Sub-Ultimate variants)** resulting from secondary plant fusions (e.g., combining an Ultimate plant with Pumpkin, Garlic, or Cherry):

* **Archetype Linking (`MixData.BaseOfUltimatePlants`):**
  The engine maintains an internal association table (`BaseOfUltimatePlants`) in `MixData` that maps secondary sub-species back to their primary Ultimate root:
  $$\text{Sub-Species (e.g., UltimateHypnoPumpkin)} \xrightarrow{\text{BaseOfUltimatePlants}} \text{Primary Archetype (UltimateHypno)}$$

* **Shared Modifier Application:**
  Any Weak or Strong modifier unlocked for the primary Ultimate archetype (e.g., Modifier 18 and Modifier 19 for `UltimateHypno`) **automatically applies to all corresponding sub-species variants** (such as `UltimateHypnoPumpkin`).

* **Implementation Guidelines for Mod Developers:**
  When implementing automation, scanning routines, or stat modifiers, targeting only the primary `PlantType` enumeration will inadvertently ignore sub-species variants active on the board:


---

## 4. Entity Anatomy: `UltimateHypno` Case Study

Below is the decompiled signature of the core members of `UltimateHypno`:

```csharp
namespace Il2Cpp
{
    public class UltimateHypno : Shooter
    {
        // Child game objects representing physical magnet attachments
        public GameObject mag1; // Level 1 magnet/bucket attachment
        public GameObject mag2; // Level 2 magnet/bucket attachment
        public GameObject mag3; // Level 3 magnet/bucket attachment (Modifier 19 exclusive)

        // Item consumption entry point
        public virtual bool UseItem(BucketType bucketType, Bucket bucket);

        // Core execution routines
        protected virtual Bullet Shoot1();
        protected virtual void PlantShootUpdate();
        protected virtual void AttributeEvent();
    }
}
```

### Full Charge Determination Logic:
```csharp
// Evaluate saturation state considering active modifiers
bool isFull = cachedHasMod19
    ? (hypno.mag3 != null && hypno.mag3.activeInHierarchy)
    : ((hypno.mag2 != null && hypno.mag2.activeInHierarchy) ||
       (hypno.mag3 != null && hypno.mag3.activeInHierarchy));

if (!isFull)
{
    // Plant requires additional charging resources
}
```

Next: [Technical Documentation: Auxiliary Systems: Zombies, Buckets & Lawnf Utilities](04-other-entities.md)
