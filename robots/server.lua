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
  if input == 'move' then
    while true do
		  _, _, _, key, _ = event.pull("key_down")
      if     key == 45.0 then modem.send(slave, 23, 'x')
      elseif key == 47.0 then modem.send(slave, 23, 'v')
      elseif key == 38.0 then modem.send(slave, 23, 'l')
      elseif key == 22.0 then modem.send(slave, 23, 'u')
      elseif key == 23.0 then modem.send(slave, 23, 'i')
      elseif key == 30.0 then modem.send(slave, 23, 'a')
      elseif key == 18.0 then modem.send(slave, 23, 'e')
      elseif key == 24.0 then modem.send(slave, 23, 'o')
      elseif key == 46.0 then break end
    end
  else
    modem.send(slave, 22, input)
		while true do
			local _, _, from, port, _, message = event.pull("modem_message")
			if (from == slave and port == 22) then
				print(message)
				break
			end
		end
  end
end
