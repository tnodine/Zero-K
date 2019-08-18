return {
  ["ataalaser"] = {
		
    groundsmoke = {
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = 0,
						unit = 1,

      properties = {
        airdrag            = 0.8,
        colormap           = [[0.2 0 0.25 1  0.4 0 0.7 1   0 0 0 0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 20,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 2, 0]],
        numparticles       = 3,
        particlelife       = 4,
        particlelifespread = 10,
        particlesize       = 4,
        particlesizespread = 20,
        particlespeed      = 1,
        particlespeedspread = 7,
        pos                = [[0 r-10 r10, 0 r-10 r10, 0 r-10 r10]],
        sizegrowth         = 1.7,
        sizemod            = 1,
        texture            = [[smokesmall]],
      },
    },
	
	flash = {
      class              = [[CSimpleParticleSystem]],
      count              = 2,
      ground             = 1,
      air = 1,

      properties = {
        airdrag            = 0.8,
        colormap           = [[0.25 0.35 1 0.01   0 0 0 0]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 20,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 2, 0]],
        numparticles       = 3,
        particlelife       = 8,
        particlelifespread = 8,
        particlesize       = 4,
        particlesizespread = 18,
        particlespeed      = 1,
        particlespeedspread = 7,
        pos                = [[0 r-10 r10, 0 r-10 r10, 0 r-10 r10]],
        sizegrowth         = 1.5,
        sizemod            = 1,
        texture            = [[flare]],
      },
    },
	flash2 = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = 1,
						air = 1,

      properties = {
        airdrag            = 0.8,
        colormap           = [[0.3 0.15 0.9 0.01   0 0 0 0]],
        directional        = 0,
        emitrot            = 0,
        emitrotspread      = 0,
        emitvector         = [[0, 1, 0]],
        gravity            = [[0, 0, 0]],
        numparticles       = 1,
        particlelife       = 15,
        particlelifespread = 4,
        particlesize       = 8,
        particlesizespread = 4,
        particlespeed      = 1,
        particlespeedspread = 7,
        pos                = [[0,15,0]],
        sizegrowth         = 1,
        sizemod            = 1.1,
        texture            = [[flare]],
      },
    },
	
	stacheln1 = {
      air                = true,
      class              = [[explspike]],
      count              = 8,
      ground             = true,
      water              = true,
      properties = {
        alpha              = 2,
        alphadecay         = 0.25,
        color              = [[0.15, 0.25, 1]],
        dir                = [[r20 r-15, r-15 r20, r20 r-15]],
        length             = 10,
        lengthgrowth       = -3,
        pos                = [[0, 1, 0]],
        width              = 20,
      },
    },
	
	funken = {
      class              = [[CSimpleParticleSystem]],
      count              = 5,
      ground             = true,
      unit               = 1,
      properties = {
        airdrag            = 1,
        colormap           = [[0.15 0.25 1 0.01  0.3 0.15 0.75 0.01   0 0 0 0.01]],
        directional        = true,
        emitrot            = 0,
        emitrotspread      = 90,
        emitvector         = [[0,1,0]],
        gravity            = [[0,0, 0]],
        numparticles       = 5,
        particlelife       = 12,
        particlelifespread = 15,
        particlesize       = 6,
        particlesizespread = 0,
        particlespeed      = 4,
        particlespeedspread = 5,
        pos                = [[0, 1, 0]],
        sizegrowth         = 0,
        sizemod            = 1.0,
        texture            = [[gunshot]],
      },
    },

	yudell = {
      air                = false,
      class              = [[CSimpleGroundFlash]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        
        colormap           = [[0.6 0.25 1 0.2  0.4 0.2 1 0.2    0 0 0 0]],
        size               = 80,
        sizegrowth         = [[-1.25]],
        texture            = [[groundflash]],
        ttl                = 60,
      },
    },
	
	yudell3 = {
      air                = false,
      class              = [[CSimpleGroundFlash]],
      count              = 1,
      ground             = true,
      water              = false,
      properties = {
        
        colormap           = [[1 1 0 0.2  1 .45 0 0.2     0 0 0 0]],
        size               = 20,
        sizegrowth         = [[-1.25]],
        texture            = [[groundflash]],
        ttl                = 60,
      },
    },
				
  },

}
