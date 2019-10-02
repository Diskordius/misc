local drone = component.proxy(component.list("drone")())
local modem = component.proxy(component.list("modem")())

modem.open(67)

while true do
  local event, _, from, _, _, message = computer.pullSignal()
  if (event == "modem_message" and message == "DISCOVER") then
    master = from
    break
  end
end

modem.close(67)
modem.open(22)
modem.open(23)

modem.send(master, 22, "CONNECT")

while true do
  local event, _, from, port, _, message = computer.pullSignal()
  if (event == "modem_message" and from == master and port == 22) then
    local command = pcall(load(message))
    local result = command()
    modem.send(master, 22, result)
  elseif (from == master and port == 23) then
    if     message == 'x' then drone.move(  0,  1,  0)
    elseif message == 'v' then drone.move(  0,  0, -1)
    elseif message == 'l' then drone.move(  0, -1,  0)
    elseif message == 'u' then drone.move( -1,  0,  0)
    elseif message == 'i' then drone.move(  0,  0,  1)
    elseif message == 'a' then drone.move(  1,  0,  0)
    elseif message == 'e' then drone.swing()
    elseif message == 'o' then drone.drop() end
  end
end
