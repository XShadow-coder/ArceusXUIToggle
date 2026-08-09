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
-- ARCEUS X TOGGLE - ANIMATED NEON UI
-- =========================================================

local VISIBLE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

local VISIBLE_FILE = "ArceusXToggle_Visible.png"
local HIDDEN_FILE = "ArceusXToggle_Hidden.png"


-- =========================================================
-- DOWNLOAD IMAGE
-- =========================================================

local function downloadImage(url, fileName)

    if isfile and isfile(fileName) then
        return getcustomasset(fileName)
    end

    local http = request or http_request

    if not http then
        warn("Arceus X Toggle: HTTP function not available")
        return nil
    end

    local success, response = pcall(function()
        return http({
            Url = url,
            Method = "GET"
        })
    end)

    if not success or not response then
        warn("Arceus X Toggle: failed to download " .. fileName)
        return nil
    end

    if not response.Body then
        warn("Arceus X Toggle: response has no Body")
        return nil
    end

    writefile(fileName, response.Body)

    return getcustomasset(fileName)
end


-- =========================================================
-- LOAD IMAGES
-- =========================================================

local visibleImage = downloadImage(
    VISIBLE_URL,
    VISIBLE_FILE
)

local hiddenImage = downloadImage(
    HIDDEN_URL,
    HIDDEN_FILE
)


-- =========================================================
-- ARCEUS X TOGGLE
-- Minimal / Clean / Premium UI
-- =========================================================

local TweenService = game:GetService("TweenService")


-- =========================================================
-- IMAGE URLS
-- =========================================================

local VISIBLE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

local VISIBLE_FILE = "ArceusXToggle_Visible.png"
local HIDDEN_FILE = "ArceusXToggle_Hidden.png"


-- =========================================================
-- DOWNLOAD IMAGE
-- =========================================================

local function downloadImage(url, fileName)

    if isfile and isfile(fileName) then
        local success, asset = pcall(function()
            return getcustomasset(fileName)
        end)

        if success then
            return asset
        end
    end

    local http = request or http_request

    if not http then
        warn("Arceus X Toggle: HTTP function not available")
        return nil
    end

    local success, response = pcall(function()
        return http({
            Url = url,
            Method = "GET"
        })
    end)

    if not success or not response or not response.Body then
        warn("Arceus X Toggle: failed to download " .. fileName)
        return nil
    end

    local saved = pcall(function()
        writefile(fileName, response.Body)
    end)

    if not saved then
        warn("Arceus X Toggle: failed to save " .. fileName)
        return nil
    end

    local assetSuccess, asset = pcall(function()
        return getcustomasset(fileName)
    end)

    if assetSuccess then
        return asset
    end

    return nil
end


-- =========================================================
-- LOAD IMAGES
-- =========================================================

local visibleImage = downloadImage(
    VISIBLE_URL,
    VISIBLE_FILE
)

local hiddenImage = downloadImage(
    HIDDEN_URL,
    HIDDEN_FILE
)


-- =========================================================
-- ARCEUS X TOGGLE - CLEAN UI
-- =========================================================

local VISIBLE_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4700.png"

local HIDDEN_IMAGE_URL =
    "https://raw.githubusercontent.com/XShadow-coder/ArceusXUIToggle/refs/heads/main/IMG_4701.png"

-- =========================================================
-- DOWNLOAD IMAGE
-- =========================================================

local function downloadImage(url, filename)
    local requestFunc = request or http_request

    if not requestFunc then
        return nil
    end

    local response = requestFunc({
        Url = url,
        Method = "GET"
    })

    if not response or not response.Body then
        return nil
    end

    if not isfile(filename) then
        writefile(filename, response.Body)
    end

    local assetFunc = getcustomasset or getsynasset

    if not assetFunc then
        return nil
    end

    return assetFunc(filename)
end

local visibleImage = downloadImage(
    VISIBLE_IMAGE_URL,
    "ArceusX_Toggle_Visible.png"
)

local hiddenImage = downloadImage(
    HIDDEN_IMAGE_URL,
    "ArceusX_Toggle_Hidden.png"
)

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
-- BUTTON
-- =========================================================

local button = Instance.new("ImageButton")
button.Name = "ToggleButton"

button.Size = UDim2.fromOffset(58, 58)
button.Position = UDim2.fromOffset(20, 100)

button.BackgroundColor3 = Color3.fromRGB(10, 14, 18)
button.BackgroundTransparency = 0.08

button.AutoButtonColor = false
button.Image = visibleImage or ""
button.ImageTransparency = 0

button.Active = true
button.Parent = toggleGui

-- =========================================================
-- ROUNDED CORNERS
-- =========================================================

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = button

-- =========================================================
-- INNER IMAGE PADDING
-- =========================================================

local imagePadding = Instance.new("UIPadding")
imagePadding.PaddingTop = UDim.new(0, 6)
imagePadding.PaddingBottom = UDim.new(0, 6)
imagePadding.PaddingLeft = UDim.new(0, 6)
imagePadding.PaddingRight = UDim.new(0, 6)
imagePadding.Parent = button

-- =========================================================
-- BORDER
-- =========================================================

local stroke = Instance.new("UIStroke")
stroke.Name = "StatusStroke"
stroke.Thickness = 2
stroke.Transparency = 0
stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
stroke.Parent = button

-- =========================================================
-- SUBTLE INNER SHADING
-- =========================================================

local gradient = Instance.new("UIGradient")
gradient.Rotation = 135
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(25, 32, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(7, 10, 13))
})
gradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.05),
    NumberSequenceKeypoint.new(1, 0.25)
})
gradient.Parent = button

-- =========================================================
-- STATE
-- =========================================================

local hidden = false

local ACTIVE_COLOR = Color3.fromRGB(0, 210, 255)
local INACTIVE_COLOR = Color3.fromRGB(205, 210, 215)

local function updateToggleAppearance()
    if hidden then

        -- OFF / HIDDEN
        button.Image = hiddenImage or ""
        button.BackgroundColor3 = Color3.fromRGB(12, 14, 16)

        stroke.Color = INACTIVE_COLOR
        stroke.Thickness = 1.5
        stroke.Transparency = 0.15

        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(
                0,
                Color3.fromRGB(28, 28, 30)
            ),
            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(7, 8, 9)
            )
        })

    else

        -- ON / VISIBLE
        button.Image = visibleImage or ""
        button.BackgroundColor3 = Color3.fromRGB(7, 18, 24)

        stroke.Color = ACTIVE_COLOR
        stroke.Thickness = 2.2
        stroke.Transparency = 0

        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(
                0,
                Color3.fromRGB(15, 45, 55)
            ),
            ColorSequenceKeypoint.new(
                1,
                Color3.fromRGB(5, 13, 18)
            )
        })

    end
end

updateToggleAppearance()

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

    updateToggleAppearance()
end)

-- =========================================================
-- CUSTOM DRAG
-- Prevents the button from jumping when clicked
-- =========================================================

local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPosition
local dragInput

local function updateDrag(input)
    local delta = input.Position - dragStart

    button.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

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

button.InputChanged:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)

    if input == dragInput and dragging then
        updateDrag(input)
    end

end)