---@alias Framework
---| '"ESX"'
---| '"QB"'
---| '"auto"'


---@alias TargetSystem
---| '"ox_target"'
---| '"qb_target"'
---| '"qtarget"'
---| '"auto"'


---@alias InventorySystem
---| '"ox_inventory"'
---| '"qb-inventory"'
---| '"es_extended"'
---| '"qs-inventory"'
---| '"auto"'


---@alias AccountType
---| '"bank"'
---| '"money"'


---@class CommandParams
---@field name string
---@field help? string
---@field type? 'number' | 'playerId' | 'string'
---@field optional? boolean
---@field full? boolean


---@class CommandProperties
---@field help string?
---@field params CommandParams[]?
---@field restricted boolean | string | string[]?
