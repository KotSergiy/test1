require "pigpio"
include Pigpio::Constant

pi=Pigpio.new
unless pi.connect
  exit -1
end

led_red = pi.gpio(4)
led_red.mode = PI_OUTPUT
led_green = pi.gpio(27)
led_green.mode = PI_OUTPUT

10.times do |i|
  print "*r"
  led_red.write 1
  led_green.write 0
  sleep 0.5
  print "*g"
  led_red.write 0
  led_green.write 1
  sleep 0.5
end

print "*end"
led_red.write 0
led_green.write 0
pi.stop
