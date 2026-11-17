using MelonLoader;
using Il2Cpp;
using UnityEngine;

[assembly: MelonInfo(typeof(PvZMod.CharmatronAutoFeedMod), "CharmatronAutoFeedMetalObject", "1.0.6", "DeM3n")]
[assembly: MelonGame(null, null)]

namespace PvZMod
{
    public class CharmatronAutoFeedMod : MelonMod
    {
        private float scanTimer = 0f;
        private float modCheckTimer = 0f;
        private bool cachedHasMod19 = false;

        public override void OnInitializeMelon()
        {
            LoggerInstance.Msg("Charmatron Auto Feed Mod v1.0.6 initialized.");
        }

        private static bool CheckModifier19()
        {
            try
            {
                return Lawnf.TravelUltimate((UltiBuff)19);
            }
            catch
            {
                return false;
            }
        }

        public override void OnUpdate()
        {
            var board = Board.Instance;
            if (board == null || board.boardEntity == null)
                return;

            float dt = Time.deltaTime;
            scanTimer += dt;
            modCheckTimer += dt;

            // Cache Modifier 19 every 2.5s (only changes between rounds)
            if (modCheckTimer >= 2.5f)
            {
                modCheckTimer = 0f;
                cachedHasMod19 = CheckModifier19();
            }

            // Throttle execution to 4 Hz (every 0.25s)
            if (scanTimer < 0.25f)
                return;

            scanTimer = 0f;

            var plantList = board.boardEntity.plantArray;
            if (plantList == null || plantList.Count == 0)
                return;

            // Find first Charmatron needing charge
            UltimateHypno targetHypno = null;

            for (int i = 0; i < plantList.Count; i++)
            {
                var plant = plantList[i];
                if (plant == null || plant.dying || plant.waitingDestory)
                    continue;

                if (plant.thePlantType == PlantType.UltimateHypno)
                {
                    var hypno = plant.TryCast<UltimateHypno>();
                    if (hypno != null)
                    {
                        // Level cap: Lv3 with Mod 19, otherwise Lv2
                        bool isFull = cachedHasMod19
                            ? (hypno.mag3 != null && hypno.mag3.activeInHierarchy)
                            : ((hypno.mag2 != null && hypno.mag2.activeInHierarchy) ||
                               (hypno.mag3 != null && hypno.mag3.activeInHierarchy));

                        if (!isFull)
                        {
                            targetHypno = hypno;
                            break;
                        }
                    }
                }
            }

            // Short-circuit: skip if no plant needs charge
            if (targetHypno == null)
                return;

            var buckets = Object.FindObjectsOfType<Bucket>();
            if (buckets == null || buckets.Length == 0)
                return;

            for (int b = 0; b < buckets.Length; b++)
            {
                var bucket = buckets[b];
                if (bucket == null)
                    continue;

                try
                {
                    // Feed via UseItem, fallback to AutoStorage
                    bool accepted = targetHypno.UseItem(bucket.theBucketType, bucket);
                    if (!accepted)
                    {
                        bucket.transform.position = targetHypno.transform.position;
                        accepted = bucket.AutoStorage(PlantType.UltimateHypno);
                    }

                    if (accepted)
                    {
                        LoggerInstance.Msg($"[Charmatron] Consumed {bucket.theBucketType} (Mod19: {cachedHasMod19})");
                        bucket.Die();
                        break;
                    }
                }
                catch (System.Exception ex)
                {
                    LoggerInstance.Error($"Feed error: {ex.Message}");
                }
            }
        }
    }
}
