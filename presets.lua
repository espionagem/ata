-- Função para criar presets refinados de efeitos visuais com reflexos HDR
local function getRefinedPresets()
    return {
        ULTRA = {
            Lighting = {
                Ambient = Color3.fromRGB(140, 140, 140),
                Brightness = 2.0,
                ColorShift_Bottom = Color3.fromRGB(230, 210, 190),
                ColorShift_Top = Color3.fromRGB(245, 220, 200),
                OutdoorAmbient = Color3.fromRGB(110, 110, 110),
                EnvironmentDiffuseScale = 1.2,
                EnvironmentSpecularScale = 1.2,
                GlobalShadows = true,
                ShadowSoftness = 0.4,
                FogColor = Color3.fromRGB(200, 200, 220),
                FogEnd = 900,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 5},
                Bloom = {Intensity = 1.0, Threshold = 0.7, Size = 60},
                ColorCorrection = {
                    Brightness = 0.08,
                    Saturation = 0.25,
                    Contrast = 0.25,
                    TintColor = Color3.fromRGB(255, 230, 210)
                },
                DepthOfField = {
                    FocusDistance = 60,
                    InFocusRadius = 250,
                    FarIntensity = 0.15,
                    NearIntensity = 0.1
                },
                SunRays = {Intensity = 0.2, Spread = 0.35}
            },
            GroundReflectivity = 0.25 -- Reflexos HDR no chão
        },
        CLEAN = {
            Lighting = {
                Ambient = Color3.fromRGB(160, 160, 160),
                Brightness = 1.8,
                OutdoorAmbient = Color3.fromRGB(140, 140, 140),
                EnvironmentDiffuseScale = 1.0,
                EnvironmentSpecularScale = 1.0,
                GlobalShadows = true,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(220, 220, 240),
                FogEnd = 1100,
                FogStart = 250
            },
            Effects = {
                Blur = {Size = 4},
                Bloom = {Intensity = 0.15, Threshold = 0.9, Size = 50},
                ColorCorrection = {
                    Brightness = 0.04,
                    Saturation = 0.18,
                    Contrast = 0.18,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }
            },
            GroundReflectivity = 0.2 -- Reflexos HDR
        },
        NOIR = {
            Lighting = {
                Ambient = Color3.fromRGB(60, 50, 40),
                Brightness = 1.5,
                OutdoorAmbient = Color3.fromRGB(60, 50, 40),
                GlobalShadows = true,
                ShadowSoftness = 0.7,
                FogColor = Color3.fromRGB(50, 45, 40),
                FogEnd = 800,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 3},
                ColorCorrection = {
                    Brightness = -0.1,
                    Saturation = -0.8,
                    Contrast = 0.6,
                    TintColor = Color3.fromRGB(180, 150, 120) -- Filtro amarelado/marrom café
                }
            },
            GroundReflectivity = 0.15 -- Reflexos HDR
        },
        DREAMY = {
            Lighting = {
                Ambient = Color3.fromRGB(190, 170, 240),
                Brightness = 2.0,
                ColorShift_Top = Color3.fromRGB(245, 200, 240),
                OutdoorAmbient = Color3.fromRGB(140, 110, 190),
                EnvironmentDiffuseScale = 1.1,
                EnvironmentSpecularScale = 1.1,
                ShadowSoftness = 0.5,
                FogColor = Color3.fromRGB(220, 190, 240),
                FogEnd = 800,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 8},
                Bloom = {Intensity = 0.9, Threshold = 0.8, Size = 90},
                ColorCorrection = {
                    Brightness = 0.15,
                    Saturation = 0.4,
                    Contrast = 0.2,
                    TintColor = Color3.fromRGB(250, 220, 250)
                },
                SunRays = {Intensity = 0.3, Spread = 0.45}
            },
            GroundReflectivity = 0.2 -- Reflexos HDR
        },
        RETRO = {
            Lighting = {
                Ambient = Color3.fromRGB(110, 90, 70),
                Brightness = 1.8, -- Mais brilho
                ColorShift_Bottom = Color3.fromRGB(60, 50, 40),
                EnvironmentDiffuseScale = 0.9,
                EnvironmentSpecularScale = 0.9,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(90, 70, 60),
                FogEnd = 700,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 5},
                ColorCorrection = {
                    Brightness = 0.1,
                    Saturation = -0.3,
                    Contrast = 0.4,
                    TintColor = Color3.fromRGB(210, 190, 170)
                },
                FilmGrain = {Intensity = 0.3},
                ChromaticAberration = {Intensity = 0.3}
            },
            GroundReflectivity = 0.4 -- Reflexos HDR mais intensos
        }
    }
end

-- As funções de aplicação e interface permanecem as mesmas
-- Basta substituir a função `getRefinedPresets` pelo código acima para aplicar as mudanças.
