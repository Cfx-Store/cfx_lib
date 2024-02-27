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


---@class WebhookParams
---@field content? string
---@field username? string
---@field avatar_url? string
---@field embeds WebhookEmbed[]

---@class WebhookEmbed
---@field title? string
---@field description? string
---@field timestamp? number|osdate
---@field color? number
---@field fields? { name: string, value: string, inline: boolean }[]
