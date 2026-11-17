# Technical Documentation: Auxiliary Systems: Zombies, Buckets & Lawnf Utilities

In addition to plant systems, complete automation and gameplay modification require interaction with **Zombies**, **Dropped Items / Buckets**, and global utility facilities exposed by **`Lawnf`**.

---

## 1. Zombie Management (`Zombie` & `ZombieType`)

### 1.1. Core Structure
* **Class Identifier:** `Zombie` (inherits from `MonoBehaviour`).
* **Type Enumeration:** `ZombieType`.
* Essential fields and properties:
  * `theZombieType`: Discrete type identifier.
  * `theZombieRow`: Current lane/row index (typically 0 to 4/5).
  * `theHealth`: Current hit points.
  * `theMaxHealth`: Maximum hit points.
  * `theStatus`: Active debuff states (frozen, slowed, charmed, burned).
  * `isMindControlled`: Denotes friendly allegiance and reversed movement direction.

### 1.2. Enumerating Active Zombie Instances:
```csharp
var board = Board.Instance;
if (board == null || board.boardEntity == null)
    return;

var zombieList = board.boardEntity.zombieArray;
if (zombieList != null)
{
    for (int i = 0; i < zombieList.Count; i++)
    {
        var zombie = zombieList[i];
        if (zombie == null || zombie.isDead)
            continue;

        // Execute zombie analysis or manipulation
    }
}
```

---

## 2. Dropped Items & Buckets (`Bucket` & `BucketType`)

In PvZ Fusion, fallen armor, metallic buckets, and upgrade items dropped by entities are encapsulated within the `Bucket` class.

### 2.1. Key Methods and Properties:
* `theBucketType`: Specifies the bucket variation (standard iron, golden, specialized helmet).
* `transform.position`: World position vector in the Unity scene.
* `AutoStorage(PlantType targetPlant)`: Attaches or stores the item into the storage component of the target plant type.
* `Die()`: Removes and destroys the bucket entity once consumed.

### 2.2. Locating and Delivering Items to Plants:
```csharp
var buckets = UnityEngine.Object.FindObjectsOfType<Bucket>();
if (buckets == null || buckets.Length == 0)
    return;

for (int b = 0; b < buckets.Length; b++)
{
    var bucket = buckets[b];
    if (bucket == null)
        continue;

    // Direct invocation via target plant's item receiver
    bool accepted = targetHypno.UseItem(bucket.theBucketType, bucket);

    // Fallback: Reposition to plant origin and trigger AutoStorage
    if (!accepted)
    {
        bucket.transform.position = targetHypno.transform.position;
        accepted = bucket.AutoStorage(PlantType.UltimateHypno);
    }

    if (accepted)
    {
        bucket.Die();
        break;
    }
}
```

---

## 3. Global Game Utility: `Lawnf`

The static utility class `Lawnf` centralizes core gameplay calculations, geometric transformations, and global state queries.

### Primary Functions:
1. **Travel Mode Buff Verification:**
   ```csharp
   bool active = Lawnf.TravelUltimate((UltiBuff)modifierIndex);
   ```
2. **Grid & Coordinate Projections:**
   * Converts between Unity World coordinates (`Vector3`) and Board grid cells (`row`, `col`).
3. **Combat & Area Computations:**
   * Damage radius calculations, collision queries, and projectile velocity evaluations.

---

Index: [Return to README.md](../README.md)
