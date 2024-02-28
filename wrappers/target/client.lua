cfx.target = {}

-------------
-- Options --
-------------

---@param options TargetOptions
---@return OxTargetOption
local function createOptions_ox(options)
   return {
      label = options.label,
      icon = options.icon,
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
---@return QbTargetOptions
local function createOptions_qb(options)
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
      }
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
end

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
end

return cfx.target
