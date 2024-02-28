# CFX Lib

Modules, utilities and wrappers around ESX and QBCore.

## Server Wrappers

### Inventory

- [x] es_extended
- [x] qb-inventory
- [x] ox_inventory
- [x] qs-inventory

* `cfx.inventory.addItem(source: number, item: string, count?: number)`
* `cfx.inventory.removeItem(source: number, item: string, count?: number)`
* `cfx.inventory.getItemCount(source: number, item: string)`
* `cfx.inventory.hasItem(source: number, item: string, count?: number)`

### Player

- [x] es_extended
- [x] qb-core
- [ ] vrp

* `cfx.player.getFromId(source: number)`
* `player:addAccountMoney(account: "bank" | "cash", amount: number, reason?: string)`
* `player:setJob(name: string, grade: number)`

## Client Wrappers

### Target

- [x] ox_target
- [x] qb-target 

##### Options

**TargetOptions**
```lua
TargetOptions
label string
icon? string
distance? number
onSelect fun(data: table)
canInteract fun(data: table): boolean
```

**EntityTargetOptions : TargetOptions**
```lua
onSelect fun(data: { entity: number })
canInteract fun(data: { entity: number }): boolean
```

- [x] `cfx.target.addGlobalVehicle(options)`
- [x] `cfx.target.addGlobalPlayer(options)`

- [ ]  `cfx.target.addGlobalPed(options)`
- [ ]  `cfx.target.addObject(entity, options)`
- [ ]  `cfx.target.addModel(entity, options)`
- [ ]  `cfx.target.removeGlobalVehicle(options)`
- [ ]  `cfx.target.removeGlobalPlayer(options)`
- [ ]  `cfx.target.removeGlobalPed(options)`
- [ ]  `cfx.target.removeModel(entity, options)`
- [ ]  `cfx.target.removeObject(entity, options)`
