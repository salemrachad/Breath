//MICROPHONE SETUP

int soundPin = A0;

//Attiny Pin
//int soundPin = 2;

//////////////////////////////////////////////////////////////////////////////////////////////////


void setup() {

  Serial.begin(115200); //sets serial port for communication
}

void loop() {
  readMic();
}

void readMic() {

  long sum = 0;
  for (int i = 0; i < 100; i++)
  {
    sum += analogRead(soundPin);
  }
  sum = sum / 100;
  Serial.println(sum);
}
