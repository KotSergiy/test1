require "pigpio"
include Pigpio::Constant

pi=Pigpio.new
unless pi.connect
  exit -1
end

led_red = pi.gpio(4)
led_red.mode = PI_OUTPUT
led_red.write 0

led_green = pi.gpio(27)
led_green.mode = PI_OUTPUT
led_green.write 0

button=pi.gpio(22)
button.mode=PI_INPUT
button.pud=PI_PUD_UP
button.glitch_filter(5000)

cb=button.callback(EITHER_EDGE){|tick,level|
  led_red.write level
  led_green.write (level xor 1)
  print '*'
}

led_red.write 1
while true do
  if (gets.strip.downcase=='stop')
    break
  end
end
puts
cb.cancel
led_red.write 0
led_green.write 0
pi.stop
