#Requirements python with serial 
import serial
import time
import datetime

#variables
myfile=open("input.txt", "wb+");#ADC values are written into this file
mbed = serial.Serial('/dev/cu.usbmodem1411', 115200,timeout=5);#declare the port accordingly
recording_minutes=1;#You can give your time for recording

#start
in_buff='';
time.sleep(5);
time_req=1*recording_minutes*60;#in seconds

time_req+=time.time();

while mbed.inWaiting() and (time_req-time.time()>0):
    in_buff+=mbed.read(mbed.inWaiting())    #read the contents of the buffer
    time.sleep(0.1005)

#print(in_buff);#prints in terminal if needed

myfile.write(in_buff);#writes into input.txt
myfile.close();