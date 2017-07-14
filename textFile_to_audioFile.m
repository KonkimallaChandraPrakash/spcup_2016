%% Variables Setting Up
inputFile='input.txt';
outputFile='output.wav';
number_of_minutes=28; %No:of minutes of recording
no_of_samples=number_of_minutes*60*1000;%No:of samples for the duration
%% Importing ADC value and Conversion to voltage
imported_text=importdata(inputFile);
imported_text=imported_text(1:number_of_minutes*1000*60);
imported_voltage=(imported_text-mean(imported_text))*5/1023;
%% audio write at 1000 hz of 
fs=1000;
audiowrite(outputFile,imported_voltage,fs);