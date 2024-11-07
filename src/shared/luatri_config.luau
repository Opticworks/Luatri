local cfg = {}

cfg.LUATRI_VERSION = "v0.1.0"

cfg.InteriorCulling = true
cfg.ParticleCulling = true
cfg.TreeImpostors = true
cfg.TreeImpostors_output = false
cfg.TreeImpostors_batch_output = true
cfg.InteriorCulling_output = true
cfg.ParticleCulling_output = false
cfg.DistanceFading = true
cfg.DistanceFading_output = true

cfg.MAX_FRAMETIME = 0.5 -- * 100 milliseconds

cfg.PARTICLE_CULLING_RANGE = 300
cfg.TREE_IMPOSTOR_RANGE = 500

cfg.DISTANCE_FADING_RANGE_SMALL = 250
cfg.DISTANCE_FADING_RANGE_MEDIUM = 500
cfg.DISTANCE_FADING_RANGE_LARGE = 750
cfg.DISTANCE_FADING_RANGE_ULTRA = 1000

cfg.DISTANCE_FADING_TWEEN = true

cfg.DISTANCE_FADING_TIME = 0.25

cfg.SERIAL_MODE = false

return cfg
