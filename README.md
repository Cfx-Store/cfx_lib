# CFX Lib

Modules, utilities and wrappers around ESX and QBCore.

## Server Wrappers

#### Inventory

- [x] es_extended
- [x] qb-inventory
- [x] ox_inventory
- [x] qs-inventory

* `cfx.inventory.addItem(source: number, item: string, count?: number)`
* `cfx.inventory.removeItem(source: number, item: string, count?: number)`
* `cfx.inventory.getItemCount(source: number, item: string)`
* `cfx.inventory.hasItem(source: number, item: string, count?: number)`

#### Player

- [x] es_extended
- [x] qb-core
- [ ] vrp

* `cfx.player.getFromId(source: number)`
* `player:addAccountMoney(account: "bank" | "cash", amount: number, reason?: string)`
* `player:setJob(name: string, grade: number)`
