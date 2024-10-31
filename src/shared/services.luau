local services = {}

services.players = game:GetService("Players")
services.userInput = game:GetService("UserInputService")
services.run = game:GetService("RunService")
services.tween = game:GetService("TweenService")
services.collection = game:GetService("CollectionService")
services.replicatedStorage = game:GetService("ReplicatedStorage"):WaitForChild("Luatri")
services.lighting = game:GetService("Lighting")

return services
