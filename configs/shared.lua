SharedConfig = {}

-- WARNING!!! DONT touch this
SharedConfig.debug = true
SharedConfig.logLevel = 3

SharedConfig.primaryIdentifier = "license"

---@type Framework
SharedConfig.framework = "auto" -- 'ESX' | 'QB' | 'auto'

---@type TargetSystem
SharedConfig.target = "auto" -- 'ox_target' | 'qb_target' | 'qtarget' | 'auto'

---@type InventorySystem
SharedConfig.inventory = "auto" -- 'ox_inventory' | 'qb-inventory'
