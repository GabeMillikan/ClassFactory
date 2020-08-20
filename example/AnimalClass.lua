local ClassFactory = require(game.ReplicatedStorage:WaitForChild("ClassFactory"))
local Animal = ClassFactory:New("Animal")

--[[
	DECLARATIONS
    (these are not necessary, but its nice to have a list of functions at the top of a class)
]]--
function Animal:init(species, sound) end
function Animal:speak() end

--[[
	DEFINITIONS
]]--
function Animal:init(species, sound)
    self.species = species
    self.sound = sound
end

function Animal:speak()
    print("I'm a", self.species, "and i say", self.sound)
end

return Animal
