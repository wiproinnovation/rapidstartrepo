pi@raspberrypi ~/rr $ cat command_rr.py
import RPi.GPIO as GPIO
import time
import sys

# USE BOARD PIN NUMBERS
GPIO.setmode(GPIO.BOARD)

# PIN DEFINITIONS
proximity_in    = 16
led_out         = 18
motor1_0_out    = 22
motor1_1_out    = 32
motor2_0_out    = 36
motor2_1_out    = 38

# SET I/O
GPIO.setup(proximity_in, GPIO.IN)
GPIO.setup(led_out, GPIO.OUT)
GPIO.setup(motor1_0_out, GPIO.OUT)
GPIO.setup(motor1_1_out, GPIO.OUT)
GPIO.setup(motor2_0_out, GPIO.OUT)
GPIO.setup(motor2_1_out, GPIO.OUT)

# CONTROL PARAMS
direction = 0 # 0 - static, 1 - forward, 2 - reversing action

# ACTION SEQUENCES
def turn_right():
        direction = 2
        print("   Turning Right...")
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 01
        GPIO.output(motor2_1_out, GPIO.HIGH)
        time.sleep(2.5)
        print("   Forward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        return

def turn_left():
        direction = 3
        print("   Turning Left...")
        GPIO.output(motor1_0_out, GPIO.LOW) # Motor 1 value 01
        GPIO.output(motor1_1_out, GPIO.HIGH)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        time.sleep(2.5)
        print("   Forward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        return

def u_turn_by_right():
        direction = 2
        print("   Reversing...")
        GPIO.output(motor1_0_out, GPIO.LOW) # Motor 1 value 01
        GPIO.output(motor1_1_out, GPIO.HIGH)
        GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 01
        GPIO.output(motor2_1_out, GPIO.HIGH)
        time.sleep(1)
        print("   Turning Right...")
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 01
        GPIO.output(motor2_1_out, GPIO.HIGH)
        time.sleep(2.5)
        print("   Forward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        time.sleep(1)
        print("   Turning Right...")
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 01
        GPIO.output(motor2_1_out, GPIO.HIGH)
        time.sleep(2.5)
        print("   Forward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        return

def forward():
        print("   Forward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.HIGH) # Motor 1 value 10
        GPIO.output(motor1_1_out, GPIO.LOW)
        GPIO.output(motor2_0_out, GPIO.HIGH)  # Motor 2 value 10
        GPIO.output(motor2_1_out, GPIO.LOW)
        return

def backward():
        print("   Backward...")
        direction = 1
        GPIO.output(motor1_0_out, GPIO.LOW) # Motor 1 value 01
        GPIO.output(motor1_1_out, GPIO.HIGH)
        GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 01
        GPIO.output(motor2_1_out, GPIO.HIGH)
        return

task = {'t' : u_turn_by_right,
                'r' : turn_right,
                'l' : turn_left,
                'f' : forward,
                'b' : backward
}

# MAIN
loop_control = 1
GPIO.output(motor1_0_out, GPIO.LOW) # Motor 1 value 00
GPIO.output(motor1_1_out, GPIO.LOW)
GPIO.output(motor2_0_out, GPIO.LOW)  # Motor 2 value 00
GPIO.output(motor2_1_out, GPIO.LOW)
print("Waiting for command: f - forward, b - backward, r - right turn, l - left turn, t - u turn, any other key to exist command mode")
try:
        while loop_control == 1:
                proximity = GPIO.input(proximity_in)
                print("Proximity value: ", proximity)
                if proximity == 1:
                        print("Obstacle detected, starting U-Turn-by-Right Sequence")
                        cmd = 't'
                else:
                        cmd = raw_input()
                task[cmd]();

except KeyError:
        print "Wrong Command";
except KeyboardInterrupt or KeyError:
        loop_control = 0

print("Detected an interrupt. Cleaning up and Exiting...")
GPIO.cleanup()
