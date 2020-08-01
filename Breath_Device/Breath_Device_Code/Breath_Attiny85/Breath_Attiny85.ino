//MICROPHONE SETUP

 int soundPin = 2;

//////////////////////////////////////////////////////////////////////////////////////////////////

// LDR SETUP

//Attiny Pin
int sensorPin = 3;
int sensorValue = 0; // variable to store the value coming from the sensor

//Variables to handle timing for LED

float timerSensor = 0;
float timeSensor = 600;

//////////////////////////////////////////////////////////////////////////////////////////////////

// LED SETUP
//Attiny Pin
int led = 4;
int brightness = 0;    // how bright the LED is
int fadeAmount = 3;    // how many points to fade the LED by

int gstate = 0;

//Variables to handle timing for LED
float timerLed = 0;
float timeLed = 2000;

//////////////////////////////////////////////////////////////////////////////////////////////////

int period = 500;
unsigned long time_now = 0;


void setup() {


  pinMode(led, OUTPUT);

  // Store actual time in every timer
  timerSensor = millis();
  timerLed = millis();
}

void loop() {

  switch (gstate) {

    case 0:
        readMic();
      // If enough time has passed (more than timeSensor - 600ms- )
      if (millis() - timerSensor >= timeSensor) {
        // Get a new time reference in timerSensor (a new timer count is started)
        timerSensor = millis();
        sensorValue = analogRead(sensorPin); // read the value from the sensor
        if (sensorValue > 400) {
          gstate = 1;
        }
      }
     break;
    case 1:
      brightness = brightness + fadeAmount;

      if ( brightness >= 255) {
        time_now = millis();
        delay(500);


        fadeAmount = -fadeAmount;
      }
      if (brightness < 0) {
        resetSystem();
      }

      //if (millis() - timerLed >= timeLed) {
      //timerLed = millis();
      analogWrite(led, brightness);
      delay(30);
      break;
      //  }
  }
}
void readMic() {

  long sum = 0;
  for (int i = 0; i < 100; i++)
  {
    sum += analogRead(soundPin);
  }
  sum = sum / 100;
  //Serial.println(sum);
  if  (sum > 66) gstate = 1;
}

void resetSystem() {
  fadeAmount = 3;
  gstate = 0;
  brightness = 0;
}
