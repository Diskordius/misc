local component = require("component")
local event = require("event")
local io = require("io")
local modem = component.modem

modem.open(22)
modem.broadcast(67, "DISCOVER")

while true do
  local _, _, from, _, _, message = event.pull("modem_message")
  if message == "CONNECT" then
    slave = from
    print("Connected to: " .. slave)
    break
  end
end

while true do
  input = io.read()
  modem.send(slave, 22, result)
  while true do
    local _, _, from, port, _, message = event.pull("modem_message")
    if (from == slave and port == 22) then
      print(message)
      break
    end
  end
end
