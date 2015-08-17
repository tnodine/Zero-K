unitDef = {
  unitname                      = [[geo]],
  name                          = [[Geothermal Powerplant]],
  description                   = [[Produces Energy (25)]],
  acceleration                  = 0,
  activateWhenBuilt             = true,
  brakeRate                     = 0,
  buildAngle                    = 2048,
  buildCostEnergy               = 500,
  buildCostMetal                = 500,
  builder                       = false,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 7,
  buildingGroundDecalSizeY      = 7,
  buildingGroundDecalType       = [[geo_aoplane.dds]],
  buildPic                      = [[GEO.png]],
  buildTime                     = 500,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[84 84 84]],
  collisionVolumeTest           = 1,
  collisionVolumeType           = [[ellipsoid]],
  corpse                        = [[DEAD]],
  

  customParams                  = {
    description_de = [[Erzeugt Energie (25)]],
    description_pl = [[Produkuje energie (25)]],
    helptext       = [[Geothermal plants are highly efficient energy sources that can only be built on geovents on the map. They explode quite violently when destroyed, so avoid placing anything directly adjacent.]],
    helptext_de    = [[Geothermische Anlagen sind hocheffiziente Energiequellen, die nur auf Thermalquellen auf der Karte gebaut werden können. Sie explodieren heftig, wenn sie zerstört werden. Von daher vermeide es, sie in unmittelbarer Nähe zu deiner Basis zu bauen.]],
    helptext_pl    = [[Elektrownie geotermalne sa bardzo oszczednym i efektywnym zrodlem energii, jednak moga byc budowane tylko na wylotach geotermalnych, a zniszczenie ich wiaze sie z dosc silnym wybuchem.]],
    pylonrange = 150,
    aimposoffset   = [[0 0 0]],
    midposoffset   = [[0 -10 0]],
    modelradius    = [[42]],
	removewait     = 1,
    
    morphto = [[amgeo]],
    morphtime = [[90]],
	
	priority_misc = 1, -- Medium
  },

  energyMake                    = 25,
  energyUse                     = 0,
  explodeAs                     = [[ESTOR_BUILDING]],
  footprintX                    = 5,
  footprintZ                    = 5,
  iconType                      = [[energygeo]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  maxDamage                     = 1750,
  maxSlope                      = 255,
  maxVelocity                   = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[geo.obj]],
  script                        = [[geo.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[ESTOR_BUILDING]],
  side                          = [[ARM]],
  sightDistance                 = 273,
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 0,
  yardMap                       = [[ooooo ogggo ogggo ogggo ooooo]],

  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Geothermal Powerplant]],
      blocking         = true,
      damage           = 1750,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 4,
      footprintZ       = 4,
      metal            = 200,
      object           = [[geo_dead.obj]],
      reclaimable      = true,
      reclaimTime      = 200,
    },


    HEAP  = {
      description      = [[Debris - Geothermal Powerplant]],
      blocking         = false,
      damage           = 1750,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      metal            = 100,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 100,
    },

  },

}

return lowerkeys({ geo = unitDef })
