local component = require("component")
local table = require("table")

function setup ()
  INVENTORY_CONTROLLERS = {}
  for address, name in component.list("inventory_controller") do
    table.insert(INVENTORY_CONTROLLERS, component.proxy(address))
  end 
end

function work ()
  print(INVENTORY_CONTROLLERS)
end

function main ()
  setup()
  work()
end

main()
