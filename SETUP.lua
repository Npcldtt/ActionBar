	--[[
    This script provides explanations for the Icon and Menu modules used in Roblox.
    
    Icon Module:
    - The Icon module is responsible for creating and managing an interactive icon in the player's UI.
    - It allows toggling the selection state, changing icon images, and connecting click events.

    Key Features:
    - **Creating a new Icon**: The `Icon.new(player)` function initializes a new icon for a player.
    - **Selection state**: Clicking the icon toggles its selected state.
    - **Setting images**: The `setImage(decalid, TYPE)` function allows updating the icon's image based on its selection state.
    - **Destroying the icon**: The `Destroy()` function removes the icon from the UI.

    Menu Module:
    - The Menu module manages the menu interface, enabling dynamic addition of items.
    - It provides methods to show/hide the menu and add clickable items.

    Key Features:
    - **Creating a new Menu**: The `menu.new(player)` function initializes a new menu for a player.
    - **Adding items**: The `newItem(name)` function allows adding new items to the menu with their own properties and click events.
    - **Visibility control**: The `show()` and `hide()` functions control the visibility of the menu.
    - **Positioning**: Methods like `xpos(pos)` and `ypos(pos)` allow for adjusting the menu's position.

    Usage:
    - To use these modules, you would typically require them in your game and call their functions to create and manage UI elements dynamically for each player.
]]

local Icon = require(game.Workspace["ActionBar"].Icon)
local Menu = require(game.Workspace["ActionBar"].Icon.Menu)
local Players = game:GetService("Players")

Icon.Attribute = true -- Enables attribute, You can disable it if you want.

Players.PlayerAdded:Connect(function(player)
	local ResetCharacter = Icon.new(player)
	local OpenMenu = Icon.new(player)
	
	local TestMenu = Menu.new(player)
	TestMenu.hide()
	local Reset = TestMenu.newItem("Reset Character")
	
	local function resetCharacter()
		player.Character.Humanoid.Health = 0
	end
	
	ResetCharacter.MouseButton1Click(resetCharacter)
	ResetCharacter.setLabel("Reset Character")
	
	OpenMenu.setLabel("Open TestMenu")
	
	local function OpenTestMenu()
		if OpenMenu.Selected then
			TestMenu.xpos(UDim2.new(0, 180))
			TestMenu.show()
			OpenMenu.setLabel("Close TestMenu")
		else
			TestMenu.hide()
			OpenMenu.setLabel("Open TestMenu")
		end
	end
	
	OpenMenu.MouseButton1Click(OpenTestMenu)
	Reset.MouseButton1Click(resetCharacter)
end)
