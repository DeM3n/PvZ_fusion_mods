# Technical Documentation: Game Architecture & Il2Cpp Interop

This document covers memory representation, entity lifecycles, safe casting practices, and performance optimization when interacting with the **Unity Il2Cpp** runtime in Plants vs. Zombies Fusion.

---

## 1. Il2Cpp Memory Model & Proxy Objects

When executing in an Il2Cpp environment:
* Game objects (Plants, Zombies, Board state) reside in **native unmanaged C++ memory**.
* C# types exposed in `Assembly-CSharp.dll` are **managed proxy wrappers** derived from `Il2CppObjectBase`.
* Reading a field or invoking a method dispatches through internal runtime pointers to native memory.

> [!CAUTION]
> ### Type Casting Constraints in Il2Cpp
> Standard C# cast operators such as `(UltimateHypno)plant` or `plant as UltimateHypno` evaluate against the C# managed type system. These operators will either throw an `InvalidCastException` or evaluate to `null` on valid native instances.
> 
> Always use `Il2CppInterop` cast extensions:
> ```csharp
> // Safe cast (returns null if type mismatch, analogous to 'as'):
> var hypno = plant.TryCast<UltimateHypno>();
> if (hypno != null)
> {
>     // Instance is valid and conforms to UltimateHypno
> }
> 
> // Strict cast (throws if type mismatch):
> var hypno = plant.Cast<UltimateHypno>();
> ```

---

## 2. Board Management: `Board.Instance`

The central game state is controlled by the `Board` singleton.

### Null Verification Pattern:
```csharp
var board = Board.Instance;
if (board == null || board.boardEntity == null)
{
    // Execution is outside an active match (e.g., Main Menu, Seed Selection, or Loading)
    return;
}
```

### Key Members in `board.boardEntity`:
* `plantArray`: Collection containing all active plant entities currently present on the lawn.
* `zombieArray` / zombie collections: Active zombie instances.
* Grid system: Mapping between Unity World coordinates and discrete board rows/columns.

---

## 3. Entity Lifecycle & Safe State Verification

In Unity Il2Cpp, when an entity is scheduled for deletion, the underlying native C++ instance may transition to a dying or destroyed state before its managed proxy is removed from active collections. Accessing an unverified instance can lead to memory access violations or unstable logic.

### Safe Entity Validation:
```csharp
var plantList = board.boardEntity.plantArray;
if (plantList == null || plantList.Count == 0)
    return;

for (int i = 0; i < plantList.Count; i++)
{
    var plant = plantList[i];

    // 1. Check managed wrapper nullability
    if (plant == null)
        continue;

    // 2. Validate internal destruction flags
    if (plant.dying || plant.waitingDestory)
        continue;

    // The plant instance is confirmed valid for processing
}
```

---

## 4. Loop Throttling & Performance Optimization

The `OnUpdate()` lifecycle hook in `MelonMod` executes once per rendering frame (60 to 144+ Hz). Performing entity scans or searching the scene hierarchy on every frame induces CPU cache thrashing and framerate degradation.

### Tick Rate Throttling:
Restricting full scan logic to a discrete frequency (e.g., 4 Hz / every 0.25 seconds) preserves frame pacing:

```csharp
private float scanTimer = 0f;

public override void OnUpdate()
{
    float dt = Time.deltaTime;
    scanTimer += dt;

    if (scanTimer < 0.25f)
        return;

    scanTimer = 0f;

    // Execute scan routine
}
```

### State Caching for Low-Frequency Queries:
Game mode attributes such as active modifiers or travel buffs rarely alter mid-round. These queries should be cached at longer intervals (e.g., 2.5 seconds):

```csharp
private float modifierTimer = 0f;
private bool cachedModifier19 = false;

// Within OnUpdate:
modifierTimer += Time.deltaTime;
if (modifierTimer >= 2.5f)
{
    modifierTimer = 0f;
    cachedModifier19 = Lawnf.TravelUltimate((UltiBuff)19);
}
```

---

## 5. Exception Isolation

All external interop calls should be isolated using defensive exception blocks. This prevents localized invalid pointer operations from breaking the host engine's main loop:

```csharp
try
{
    targetHypno.UseItem(bucket.theBucketType, bucket);
}
catch (System.Exception ex)
{
    LoggerInstance.Error($"Failed to process item consumption: {ex.Message}");
}
```

Next: [Technical Documentation: Ultimate Plant Series & Modifier System](03-ultimate-plants-and-modifiers.md)
