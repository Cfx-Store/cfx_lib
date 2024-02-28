cfx.target = {}

---@param options TargetOptions
local function convertOptions(options)
  options.distance = options.distance or 2.0

  local caller = cfx.caller.createTargetCaller({
    ["ox_target"] = function()
      ---@type OxTargetOption
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
    end,
    ["qb-target"] = function()
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
        }
      }
    end,
    -- ["qtarget"] = function() end,
  })

  local options = caller()
  return options
end

---@param options EntityTargetOptions
function cfx.target.addGlobalVehicle(options)
  local targetOptions = convertOptions(options)
  local caller = cfx.caller.createTargetCaller({
    ["ox_target"] = function()
      ---@cast targetOptions OxTargetOption
      exports.ox_target:addGlobalVehicle(targetOptions)
    end,
    ["qb-target"] = function()
      exports["qb-target"]:AddGlobalVehicle(targetOptions)
    end,
    -- ["qtarget"] = function() end,
  })

  caller()
end

---@param options EntityTargetOptions
function cfx.target.addGlobalPlayer(options)
  local targetOptions = convertOptions(options)
  local caller = cfx.caller.createTargetCaller({
    ["ox_target"] = function()
      ---@cast targetOptions OxTargetOption
      exports.ox_target:addGlobalPlayer(targetOptions)
    end,
    ["qb-target"] = function()
      exports["qb-target"]:AddGlobalPlayer(targetOptions)
    end,
    -- ["qtarget"] = function() end,
  })

  caller()
end

return cfx.target
