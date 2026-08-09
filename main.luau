local CoreGui = game:GetService("CoreGui")

-- gethui() nel tuo caso restituisce:
-- CoreGui.9rMgS4.mriOy9
local targetParent = (gethui and gethui()) or CoreGui

-- =========================================================
-- REMOVE OLD TOGGLES
-- =========================================================

for _, obj in ipairs(targetParent:GetChildren()) do
    if obj:IsA("ScreenGui") and obj.Name == "ArceusXVisibilityToggle" then
        obj:Destroy()
    end
end

-- =========================================================
-- FIND ARCEUS X
-- =========================================================

local function findArceusX()

    for _, obj in ipairs(targetParent:GetChildren()) do

        if obj:IsA("ScreenGui") then

            if obj.DisplayOrder == 1999999999 then
                return obj
            end

        end
    end

    return nil
end

-- =========================================================
-- IMAGE URLS
-- =========================================================

local VISIBLE_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"


-- =========================================================
-- CREATE TOGGLE
-- =========================================================

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ArceusXVisibilityToggle"
toggleGui.ResetOnSpawn = false
toggleGui.IgnoreGuiInset = true
toggleGui.DisplayOrder = 2147483647
toggleGui.Parent = targetParent


-- Main button
local button = Instance.new("ImageButton")
button.Name = "ToggleButton"

button.Size = UDim2.new(0, 55, 0, 55)
button.Position = UDim2.new(0, 20, 0, 100)

button.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
button.BackgroundTransparency = 0.05

button.AutoButtonColor = false
button.Image = ""

button.Active = true
button.Draggable = true

button.Parent = toggleGui


-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = button


-- =========================================================
-- IMAGE
-- =========================================================

local image = Instance.new("ImageLabel")
image.Name = "StateImage"

image.Size = UDim2.new(1, -8, 1, -8)
image.Position = UDim2.new(0, 4, 0, 4)

image.BackgroundTransparency = 1
image.ImageTransparency = 0

image.ScaleType = Enum.ScaleType.Fit

image.Parent = button


local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 9)
imageCorner.Parent = image


-- =========================================================
-- BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")
stroke.Name = "StateStroke"

stroke.Thickness = 2
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

stroke.Parent = button


-- =========================================================
-- NEON GLOW
-- =========================================================

local glow = Instance.new("UIStroke")
glow.Name = "NeonGlow"

glow.Thickness = 5
glow.Transparency = 0.65

glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

glow.Parent = button


-- =========================================================
-- STATE
-- =========================================================

local hidden = false


local function setVisibleStyle()

    -- Cyan neon
    stroke.Color = Color3.fromRGB(0, 200, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0

    glow.Color = Color3.fromRGB(0, 200, 255)
    glow.Thickness = 5
    glow.Transparency = 0.65

    button.BackgroundColor3 = Color3.fromRGB(8, 14, 18)

end


local function setHiddenStyle()

    -- White, no neon
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0

    glow.Transparency = 1

    button.BackgroundColor3 = Color3.fromRGB(15, 15, 15)

end


-- =========================================================
-- INITIAL STATE
-- =========================================================

setVisibleStyle()


-- =========================================================
-- TOGGLE
-- =========================================================

button.MouseButton1Click:Connect(function()

    local arceusGui = findArceusX()

    if not arceusGui then
        return
    end

    hidden = not hidden

    arceusGui.Enabled = not hidden

    if hidden then

        -- Arceus X hidden
        setHiddenStyle()

    else

        -- Arceus X visible
        setVisibleStyle()

    end
end)