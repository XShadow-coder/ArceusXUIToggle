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
-- ARCEUS X TOGGLE
-- =========================================================

local VISIBLE_IMAGE =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_IMAGE =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

-- =========================================================
-- DOWNLOAD IMAGE
-- =========================================================

local function downloadImage(url, fileName)

    local path = "ArceusXUIToggle/" .. fileName

    if isfile and isfile(path) then
        return getcustomasset(path)
    end

    if not isfolder("ArceusXUIToggle") then
        makefolder("ArceusXUIToggle")
    end

    local response = request({
        Url = url,
        Method = "GET"
    })

    if response and response.Body then
        writefile(path, response.Body)
        return getcustomasset(path)
    end

    return nil
end

local visibleImage = downloadImage(VISIBLE_IMAGE, "visible.png")
local hiddenImage = downloadImage(HIDDEN_IMAGE, "hidden.png")

-- =========================================================
-- CREATE GUI
-- =========================================================

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ArceusXVisibilityToggle"
toggleGui.ResetOnSpawn = false
toggleGui.IgnoreGuiInset = true
toggleGui.DisplayOrder = 2147483647
toggleGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
toggleGui.Parent = targetParent

-- =========================================================
-- MAIN BUTTON
-- =========================================================

local button = Instance.new("ImageButton")
button.Name = "ToggleButton"

button.Size = UDim2.new(0, 54, 0, 54)
button.Position = UDim2.new(0, 20, 0, 100)

button.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
button.BackgroundTransparency = 0

button.Image = ""
button.AutoButtonColor = false

button.Active = true
button.Parent = toggleGui

-- =========================================================
-- ROUNDED CORNERS
-- =========================================================

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = button

-- =========================================================
-- INNER GRADIENT
-- =========================================================

local gradient = Instance.new("UIGradient")
gradient.Name = "InnerGradient"

gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(8, 8, 12)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 25, 32)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 12))
})

gradient.Rotation = 45
gradient.Parent = button

-- =========================================================
-- IMAGE
-- =========================================================

local image = Instance.new("ImageLabel")
image.Name = "Icon"

image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Position = UDim2.new(0.5, 0, 0.5, 0)

image.Size = UDim2.new(0, 38, 0, 38)

image.BackgroundTransparency = 1
image.Image = visibleImage or ""
image.ScaleType = Enum.ScaleType.Fit

image.ZIndex = 2
image.Parent = button

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 11)
imageCorner.Parent = image

-- =========================================================
-- BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")
stroke.Name = "Border"

stroke.Thickness = 2
stroke.Transparency = 0
stroke.Color = Color3.fromRGB(0, 200, 255)

stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = button

-- =========================================================
-- NEON EFFECT
-- =========================================================

local glow = Instance.new("UIStroke")
glow.Name = "Glow"

glow.Thickness = 5
glow.Transparency = 0.7
glow.Color = Color3.fromRGB(0, 190, 255)

glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
glow.Parent = button

-- =========================================================
-- STATE
-- =========================================================

local hidden = false

local function updateVisual()

    if hidden then

        -- Hidden
        image.Image = hiddenImage or ""

        stroke.Color = Color3.fromRGB(255, 255, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0

        -- No neon
        glow.Transparency = 1

    else

        -- Visible
        image.Image = visibleImage or ""

        stroke.Color = Color3.fromRGB(0, 200, 255)
        stroke.Thickness = 2
        stroke.Transparency = 0

        -- Neon
        glow.Color = Color3.fromRGB(0, 200, 255)
        glow.Thickness = 5
        glow.Transparency = 0.7
    end
end

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

    updateVisual()
end)

-- =========================================================
-- MANUAL DRAG
-- =========================================================

local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPosition

button.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true

        dragStart = input.Position
        startPosition = button.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end

        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    button.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end)

-- =========================================================
-- INITIAL STATE
-- =========================================================

updateVisual()
-- Initial state
updateButton()