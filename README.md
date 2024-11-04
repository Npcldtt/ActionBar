# ActionBar and ActionBarMenu for Roblox

This repository contains a Lua script designed for Roblox that creates a customizable action bar and action menu for players in the game. The script utilizes TweenService for smooth animations and dynamic UI updates.

## Features

- **Custom Action Bar**: Displays customizable buttons for each player.
- **Dynamic Menu System**: Allows players to add items to a menu that can be shown or hidden.
- **Animation Support**: Smooth transitions for UI elements using tweens.
- **Click Handling**: Easily connect functions to button clicks.

## Getting Started

### Prerequisites

- Roblox Studio
- Basic understanding of Lua scripting

### Installation

1. Download the model.
2. Open Roblox Studio.
3. Create or open a game project.
4. Insert a Downloaded model into `Workspace`.

Or

1. Go to this [link](https://create.roblox.com/store/asset/140501759706489/ActionBar).
2. Click **Get Model**.
3. Open Roblox Studio.
4. Create or open a game project.
5. Open toolbox.
6. Open invetory on toolbox.
7. Insert a model.

### Usage

1. **Action Bar Creation**: The `Icon` class allows you to create an action button for a player. Use the `Icon.new(player)` method to create a new button.

   ```lua
   local Icon = require(game.Workspace["ActionBar"].Icon)
   local Menu = require(game.Workspace["ActionBar"].Icon.Menu)
   local Players = game:GetService("Players")
   
   Icon.Attribute = true -- Enables attribute, You can disable it if you want.
   
   Players.PlayerAdded:Connect(function(player)
      local actionButton = Icon.new(player)
   end)
   ```

2. **Setting Button Images**: Use `setImage(decalid, TYPE)` to set the images for the button and its selected state.

   ```lua
   actionButton.setImage("12345678", "selected")
   ```

3. **Changing Button Labels**: Use `setLabel(text)` to change the text label on the button.

   ```lua
   actionButton.setLabel("My Action")
   ```

4. **Creating an Action Menu**: The `menu` class allows you to create a customizable action menu for the player.

   ```lua
   local actionMenu = menu.new(player)
   ```

5. **Adding Items to Menu**: Use `newItem(name)` to add items to the action menu.

   ```lua
   local item = actionMenu.newItem("New Item")
   ```

6. **Show/Hide Menu**: Control the visibility of the menu with `show()` and `hide()` methods.

   ```lua
   actionMenu.show()
   ```

### Example Code

Here is an example of how to create an action bar with a button and a menu with items:

```lua
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
```
