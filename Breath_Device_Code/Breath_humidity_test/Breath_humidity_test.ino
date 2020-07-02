int sensorPin = A0; // select the input pin for LDR
int sensorValue = 0; // variable to store the value coming from the sensor

int led = 9;
int brightness = 0;    // how bright the LED is
int fadeAmount = 3;    // how many points to fade the LED by

int gstate = 0;

void setup() {

  Serial.begin(9600); //sets serial port for communication
  pinMode(led, OUTPUT);

}

void loop() {

  switch (gstate) {

    case 0:
      sensorValue = analogRead(sensorPin); // read the value from the sensor
      Serial.println(sensorValue); //prints the values coming from the sensor on the screen
      delay(100);
      if (sensorValue > 200) {
        delay(600);
        gstate = 1;
      }
      break;
    case 1:
      brightness = brightness + fadeAmount;
      if ( brightness >= 255) {
        delay(500);
        fadeAmount = -fadeAmount;
      }
      if (brightness < 0) {
        reset();
      }
      analogWrite(led, brightness);
      Serial.println(brightness);
      delay(30);
      break;
  }
}

void reset(){
  fadeAmount = 3;
  gstate = 0;
  brightness =0;
}
