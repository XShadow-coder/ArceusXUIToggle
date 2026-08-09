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
-- ARCEUS X TOGGLE - MINIMAL TECH UI
-- =========================================================

local VISIBLE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

-- =========================================================
-- DOWNLOAD / LOAD IMAGE
-- =========================================================

local function loadImage(url, filename)
    local filePath = "ArceusXUIToggle/" .. filename

    local success, data = pcall(function()
        if isfile(filePath) then
            return readfile(filePath)
        end

        local response = request({
            Url = url,
            Method = "GET"
        })

        if response and response.Body then
            if not isfolder("ArceusXUIToggle") then
                makefolder("ArceusXUIToggle")
            end

            writefile(filePath, response.Body)
            return response.Body
        end
    end)

    if not success or not data then
        return nil
    end

    local assetFunction =
        getcustomasset
        or getsynasset

    if not assetFunction then
        return nil
    end

    local assetSuccess, asset = pcall(function()
        return assetFunction(filePath)
    end)

    if assetSuccess then
        return asset
    end

    return nil
end

local visibleImage = loadImage(VISIBLE_URL, "visible.png")
local hiddenImage = loadImage(HIDDEN_URL, "hidden.png")

-- =========================================================
-- CREATE GUI
-- =========================================================

local toggleGui = Instance.new("ScreenGui")
toggleGui.Name = "ArceusXVisibilityToggle"
toggleGui.ResetOnSpawn = false
toggleGui.IgnoreGuiInset = true
toggleGui.DisplayOrder = 2147483647
toggleGui.Parent = targetParent

-- =========================================================
-- MAIN BUTTON
-- =========================================================

local button = Instance.new("ImageButton")
button.Name = "ToggleButton"

-- Small compact size
button.Size = UDim2.fromOffset(42, 42)
button.Position = UDim2.fromOffset(18, 110)

button.BackgroundColor3 = Color3.fromRGB(10, 13, 17)
button.BackgroundTransparency = 0.05

button.AutoButtonColor = false
button.Image = visibleImage or ""
button.ImageTransparency = 0

button.Parent = toggleGui

-- =========================================================
-- ROUNDED CORNERS
-- =========================================================

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 11)
corner.Parent = button

-- =========================================================
-- IMAGE PADDING
-- =========================================================

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0, 5)
padding.PaddingBottom = UDim.new(0, 5)
padding.PaddingLeft = UDim.new(0, 5)
padding.PaddingRight = UDim.new(0, 5)
padding.Parent = button

-- =========================================================
-- TECHNOLOGICAL BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")
stroke.Name = "TechBorder"
stroke.Thickness = 1.5
stroke.Transparency = 0
stroke.Color = Color3.fromRGB(0, 217, 255)
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = button

-- =========================================================
-- INNER DARK OVERLAY
-- =========================================================

local overlay = Instance.new("Frame")
overlay.Name = "InnerOverlay"
overlay.Size = UDim2.new(1, -8, 1, -8)
overlay.Position = UDim2.fromOffset(4, 4)

overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.72

overlay.BorderSizePixel = 0
overlay.ZIndex = button.ZIndex + 1
overlay.Parent = button

local overlayCorner = Instance.new("UICorner")
overlayCorner.CornerRadius = UDim.new(0, 8)
overlayCorner.Parent = overlay

-- Keep image above overlay
button.ZIndex = 2

-- =========================================================
-- SMALL TECH CORNER
-- =========================================================

local cornerMark = Instance.new("Frame")
cornerMark.Name = "CornerMark"
cornerMark.Size = UDim2.fromOffset(8, 2)
cornerMark.Position = UDim2.new(1, -11, 0, 5)

cornerMark.BackgroundColor3 = Color3.fromRGB(0, 217, 255)
cornerMark.BorderSizePixel = 0
cornerMark.ZIndex = 5
cornerMark.Parent = button

local markCorner = Instance.new("UICorner")
markCorner.CornerRadius = UDim.new(1, 0)
markCorner.Parent = cornerMark

-- =========================================================
-- DRAG SYSTEM
-- =========================================================

local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPosition
local dragMoved = false

button.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragMoved = false

        dragStart = input.Position
        startPosition = button.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            dragMoved = true
        end

        button.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

-- =========================================================
-- TOGGLE STATE
-- =========================================================

local hidden = false

local function updateButton()

    if hidden then

        -- Arceus X hidden
        stroke.Color = Color3.fromRGB(210, 215, 220)
        stroke.Thickness = 1.2

        button.BackgroundColor3 =
            Color3.fromRGB(16, 16, 18)

        button.Image = hiddenImage or ""

        cornerMark.BackgroundColor3 =
            Color3.fromRGB(210, 215, 220)

    else

        -- Arceus X visible
        stroke.Color = Color3.fromRGB(0, 217, 255)
        stroke.Thickness = 1.7

        button.BackgroundColor3 =
            Color3.fromRGB(8, 14, 18)

        button.Image = visibleImage or ""

        cornerMark.BackgroundColor3 =
            Color3.fromRGB(0, 217, 255)
    end
end

-- =========================================================
-- CLICK
-- =========================================================

button.Activated:Connect(function()

    -- Don't toggle if the user was dragging
    if dragMoved then
        dragMoved = false
        return
    end

    local arceusGui = findArceusX()

    if not arceusGui then
        return
    end

    hidden = not hidden

    arceusGui.Enabled = not hidden

    updateButton()
end)

-- Initial state
updateButton()