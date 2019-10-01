local component = require("component")
local event = require("event")
local robot = reqiure("robot")
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
modem.open(23)

modem.send(master, 22, "CONNECT")

while true do
  local _, _, from, port, _, message = event.pull("modem_message")
  if (from == master and port == 22) then
    local command = load(message)
    local result = command()
    modem.send(master, 22, result)
  elseif (from == master and port == 23) then
    if     message == 'x' then robot.up()
    elseif message == 'v' then robot.forward()
    elseif message == 'l' then robot.down()
    elseif message == 'u' then robot.turnLeft()
    elseif message == 'i' then robot.back()
    elseif message == 'a' then robot.turnRight()
    elseif message == 'e' then robot.use()
    elseif message == 'o' then robot.drop() end
  end
end
