unsigned long prev_micro=0;
unsigned long interval=1000;
void setup() {
  Serial.begin(115200);//Serial Communication at 115200 baud rate
}

void loop() {
  //transmits after 1000x10^(-6) seconds
  if ((unsigned long)(micros() - prev_micro) >= interval){
    prev_micro=prev_micro+1000;
    Serial.println(analogRead(A0));//printing in serial
  }
}
