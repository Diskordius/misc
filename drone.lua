local component = require("component")
local event = require("event")
local modem = component.modem

modem.open(67)

while true do
  local _, _, from, _, _, message = event.pull("modem_message")
  if message == "DISCOVER" then
    master = from
    break
  end
end

modem.close(67)
modem.open(22)

modem.send(master, 22, "CONNECT")

while true do
  local _, _, from, port, _, message = event.pull("modem_message")
  if (from == master and port == 22) then
    local command = load(message)
    local result = command()
    modem.send(master, 22, result)
  end
end
