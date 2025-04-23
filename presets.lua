-- Função para criar presets refinados de efeitos visuais com reflexos
local function getRefinedPresets()
    return {
        ULTRA = {
            Lighting = {
                Ambient = Color3.fromRGB(150, 150, 150),
                Brightness = 2.5,
                ColorShift_Bottom = Color3.fromRGB(240, 220, 200),
                ColorShift_Top = Color3.fromRGB(255, 230, 210),
                OutdoorAmbient = Color3.fromRGB(120, 120, 120),
                EnvironmentDiffuseScale = 1.3,
                EnvironmentSpecularScale = 1.3,
                GlobalShadows = true,
                ShadowSoftness = 0.4,
                FogColor = Color3.fromRGB(220, 220, 240),
                FogEnd = 1000,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 6},
                Bloom = {Intensity = 1.2, Threshold = 0.6, Size = 70},
                ColorCorrection = {
                    Brightness = 0.1,
                    Saturation = 0.3,
                    Contrast = 0.3,
                    TintColor = Color3.fromRGB(255, 240, 220)
                },
                DepthOfField = {
                    FocusDistance = 60,
                    InFocusRadius = 250,
                    FarIntensity = 0.2,
                    NearIntensity = 0.1
                },
                SunRays = {Intensity = 0.25, Spread = 0.4}
            },
            GroundReflectivity = 0.3 -- Reflexos no chão
        },
        CLEAN = {
            Lighting = {
                Ambient = Color3.fromRGB(170, 170, 170),
                Brightness = 2,
                OutdoorAmbient = Color3.fromRGB(150, 150, 150),
                EnvironmentDiffuseScale = 1.1,
                EnvironmentSpecularScale = 1.1,
                GlobalShadows = true,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(240, 240, 255),
                FogEnd = 1200,
                FogStart = 250
            },
            Effects = {
                Blur = {Size = 4},
                Bloom = {Intensity = 0.2, Threshold = 0.9, Size = 50},
                ColorCorrection = {
                    Brightness = 0.05,
                    Saturation = 0.2,
                    Contrast = 0.2,
                    TintColor = Color3.fromRGB(255, 255, 255)
                }
            },
            GroundReflectivity = 0.2
        },
        NOIR = {
            Lighting = {
                Ambient = Color3.fromRGB(60, 60, 60),
                Brightness = 1.5,
                OutdoorAmbient = Color3.fromRGB(70, 70, 70),
                GlobalShadows = true,
                ShadowSoftness = 0.7,
                FogColor = Color3.fromRGB(50, 50, 50),
                FogEnd = 800,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 3}, -- Reduzido para evitar exageros
                ColorCorrection = {
                    Brightness = -0.1,
                    Saturation = -0.8,
                    Contrast = 0.6,
                    TintColor = Color3.fromRGB(200, 200, 200)
                }
            },
            GroundReflectivity = 0.1
        },
        DREAMY = {
            Lighting = {
                Ambient = Color3.fromRGB(200, 180, 255),
                Brightness = 2.2,
                ColorShift_Top = Color3.fromRGB(255, 210, 250),
                OutdoorAmbient = Color3.fromRGB(150, 120, 200),
                EnvironmentDiffuseScale = 1.2,
                EnvironmentSpecularScale = 1.2,
                ShadowSoftness = 0.5,
                FogColor = Color3.fromRGB(230, 200, 255),
                FogEnd = 850,
                FogStart = 200
            },
            Effects = {
                Blur = {Size = 10}, -- Suavizado
                Bloom = {Intensity = 1.0, Threshold = 0.7, Size = 100},
                ColorCorrection = {
                    Brightness = 0.2,
                    Saturation = 0.5,
                    Contrast = 0.2,
                    TintColor = Color3.fromRGB(255, 230, 255)
                },
                SunRays = {Intensity = 0.35, Spread = 0.5}
            },
            GroundReflectivity = 0.25
        },
        RETRO = {
            Lighting = {
                Ambient = Color3.fromRGB(100, 80, 60),
                Brightness = 1.5,
                ColorShift_Bottom = Color3.fromRGB(50, 40, 30),
                EnvironmentDiffuseScale = 0.8,
                EnvironmentSpecularScale = 0.8,
                ShadowSoftness = 0.6,
                FogColor = Color3.fromRGB(80, 60, 50),
                FogEnd = 700,
                FogStart = 150
            },
            Effects = {
                Blur = {Size = 5},
                ColorCorrection = {
                    Brightness = 0,
                    Saturation = -0.4,
                    Contrast = 0.4,
                    TintColor = Color3.fromRGB(200, 180, 160)
                },
                FilmGrain = {Intensity = 0.25},
                ChromaticAberration = {Intensity = 0.3}
            },
            GroundReflectivity = 0.4 -- Reflexos mais intensos
        }
    }
end

-- Função para aplicar reflexos no chão
local function applyGroundReflectivity(reflectivity)
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsA("MeshPart") and part.Material == Enum.Material.Concrete then
            part.Reflectance = reflectivity
        end
    end
end

-- Função para aplicar os presets refinados
local function applyRefinedPreset(presetName)
    local presets = getRefinedPresets()
    local preset = presets[presetName]

    if not preset then
        warn("Preset não encontrado: " .. tostring(presetName))
        return
    end

    -- Configuração de Lighting
    local lighting = game:GetService("Lighting")
    for property, value in pairs(preset.Lighting or {}) do
        lighting[property] = value
    end

    -- Remove efeitos antigos
    for _, effect in pairs(lighting:GetChildren()) do
        if effect:IsA("PostEffect") then
            effect:Destroy()
        end
    end

    -- Aplica novos efeitos
    for effectName, properties in pairs(preset.Effects or {}) do
        local effect = Instance.new(effectName .. "Effect")
        for prop, value in pairs(properties) do
            effect[prop] = value
        end
        effect.Parent = lighting
    end

    -- Aplica reflexos no chão
    if preset.GroundReflectivity then
        applyGroundReflectivity(preset.GroundReflectivity)
    end
end

-- Interface refinada com presets aprimorados
local function createRefinedUI()
    local screenGui = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"))
    screenGui.Name = "RefinedVisualEffects"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 400, 0, 500)
    frame.Position = UDim2.new(0.5, -200, 0.5, -250)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(100, 100, 100)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "Refined Visual Effects"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1

    local buttonContainer = Instance.new("Frame", frame)
    buttonContainer.Size = UDim2.new(1, -20, 1, -70)
    buttonContainer.Position = UDim2.new(0, 10, 0, 60)
    buttonContainer.BackgroundTransparency = 1

    local uiListLayout = Instance.new("UIListLayout", buttonContainer)
    uiListLayout.Padding = UDim.new(0, 10)
    uiListLayout.FillDirection = Enum.FillDirection.Vertical
    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    local presets = getRefinedPresets()
    for presetName, _ in pairs(presets) do
        local button = Instance.new("TextButton", buttonContainer)
        button.Size = UDim2.new(1, 0, 0, 50)
        button.Text = presetName
        button.Font = Enum.Font.Gotham
        button.TextSize = 18
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        button.BorderSizePixel = 2
        button.BorderColor3 = Color3.fromRGB(80, 80, 80)

        -- Efeito de hover
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end)
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        end)

        -- Aplica o preset ao clicar
        button.MouseButton1Click:Connect(function()
            applyRefinedPreset(presetName)
        end)
    end

    return screenGui
end

-- Alternador de visibilidade com hotkey
local function toggleRefinedUI()
    local screenGui = createRefinedUI()
    local uis = game:GetService("UserInputService")
    local uiVisible = true

    uis.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.F6 then
            uiVisible = not uiVisible
            screenGui.Enabled = uiVisible
        end
    end)
end

-- Inicializa a interface
toggleRefinedUI()
