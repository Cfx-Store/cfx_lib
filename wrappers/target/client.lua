cfx.target = {}

-------------
-- Options --
-------------

---@param options TargetOptions
local function createOptions_ox(options)
   ---@type OxTargetOption
   return {
      label = options.label,
      icon = options.icon,
      name = options.name,
      canInteract = function(entity)
         return options.canInteract({
            entity = entity
         })
      end,
      onSelect = function(entity)
         options.onSelect({
            entity = entity
         })
      end
   }
end

---@param options TargetOptions
local function createOptions_qb(options)
   ---@type QbTargetOptions
   return {
      options = {
         {
            label = options.label,
            icon = options.icon,
            canInteract = function(entity)
               return options.canInteract({
                  entity = entity,
               })
            end,
            action = function(entity)
               options.onSelect({
                  entity = entity
               })
            end
         }
      },
      distance = options.distance
   }
end

---@param options TargetOptions
local function convertOptions(options)
   options.distance = options.distance or 2.0

   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = createOptions_ox,
      ["qb-target"] = createOptions_qb,
      -- ["qtarget"] = function() end,
   })

   return caller(options)
end

---------------
-- Functions --
---------------

-- Vehicle --

local function addGlobalVehicle_ox(options)
   exports.ox_target:addGlobalVehicle(options)
end

local function addGlobalVehicle_qb(options)
   exports["qb-target"]:AddGlobalVehicle(options)
end

---@param options EntityTargetOptions
function cfx.target.addGlobalVehicle(options)
   local targetOptions = convertOptions(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = addGlobalVehicle_ox,
      ["qb-target"] = addGlobalVehicle_qb,
      -- ["qtarget"] = function() end,
   })

   caller(targetOptions)
   return targetOptions
end

---@param options OxTargetEntity
local function removeGlobalVehicle_ox(options)
   exports.ox_target:removeGlobalVehicle(options.name)
end

---@param options QbTargetOption
local function removeGlobalVehicle_qb(options)
   exports["qb-target"]:RemoveGlobalVehicle(options.label)
end

---@param options OxTargetEntity | QbTargetOption
function cfx.target.removeGlobalVehicle(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = removeGlobalVehicle_ox,
      ["qb-target"] = removeGlobalVehicle_qb,
      -- ["qtarget"] = function() end,
   })

   caller(options)
end

-- Player --

local function addGlobalPlayer_ox(options)
   exports.ox_target:addGlobalPlayer(options)
end

local function addGlobalPlayer_qb(options)
   exports["qb-target"]:AddGlobalPlayer(options)
end

---@param options EntityTargetOptions
function cfx.target.addGlobalPlayer(options)
   local targetOptions = convertOptions(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = addGlobalPlayer_ox,
      ["qb-target"] = addGlobalPlayer_qb,
      -- ["qtarget"] = function() end,
   })

   caller(targetOptions)
   return targetOptions
end

local function removeGlobalPlayer_ox(options)
   exports.ox_target:removeGlobalPlayer(options.name)
end

local function removeGlobalPlayer_qb(options)
   exports["qb-target"]:RemoveGlobalPlayer(options.label)
end

---@param options EntityTargetOptions
function cfx.target.removeGlobalPlayer(options)
   local targetOptions = convertOptions(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = removeGlobalPlayer_ox,
      ["qb-target"] = removeGlobalPlayer_qb,
      -- ["qtarget"] = function() end,
   })

   caller(targetOptions)
   return targetOptions
end

-- Ped --

local function addGlobalPed_ox(options)
   exports.ox_target:addGlobalPed(options)
end

local function addGlobalPed_qb(options)
   exports["qb-target"]:AddGlobalPed(options)
end

---@param options EntityTargetOptions
function cfx.target.addGlobalPed(options)
   local targetOptions = convertOptions(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = addGlobalPed_ox,
      ["qb-target"] = addGlobalPed_qb,
      -- ["qtarget"] = function() end,
   })

   caller(targetOptions)
   return targetOptions
end

local function removeGlobalPed_ox(options)
   exports.ox_target:removeGlobalPed(options.name)
end

local function removeGlobalPed_qb(options)
   exports["qb-target"]:RemoveGlobalPed(options.label)
end

---@param options EntityTargetOptions
function cfx.target.removeGlobalPed(options)
   local targetOptions = convertOptions(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = removeGlobalPed_ox,
      ["qb-target"] = removeGlobalPed_qb,
      -- ["qtarget"] = function() end,
   })

   caller(targetOptions)
   return targetOptions
end

-- Models --

local function addModel_ox(models, options)
   exports.ox_target:addModel(models, options)
end

local function addModel_qb(models, options)
   options.models = models
   exports["qb-target"]:AddTargetModel(models, options)
end

---@param models string|string[]
---@param options TargetOptions
function cfx.target.addModel(models, options)
   local targetOptions = convertOptions(options)
   local caller, target = cfx.caller.createTargetCaller({
      ["ox_target"] = addModel_ox,
      ["qb-target"] = addModel_qb,
      -- ["qtarget"] = function() end,
   })

   if target == "qb-target" then
      targetOptions.models = models
   end

   caller(models, targetOptions)
   return targetOptions
end

local function removeModel_ox(options)
   exports.ox_target:removeModel(options.name)
end

local function removeModel_qb(options)
   cfx.logger.info(options)
   exports["qb-target"]:RemoveTargetModel(options.models, options.label)
end

---@param options EntityTargetOptions
function cfx.target.removeModel(options)
   local caller = cfx.caller.createTargetCaller({
      ["ox_target"] = removeModel_ox,
      ["qb-target"] = removeModel_qb,
      -- ["qtarget"] = function() end,
   })

   caller(options)
end

return cfx.target
