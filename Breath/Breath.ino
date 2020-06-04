#include <dht_nonblocking.h>
#define DHT_SENSOR_TYPE DHT_TYPE_11

static const int DHT_SENSOR_PIN = A2;
DHT_nonblocking dht_sensor( DHT_SENSOR_PIN, DHT_SENSOR_TYPE );

int sensorPin = A0; // select the input pin for LDR
int sensorValue = 0; // variable to store the value coming from the sensor

int led = 9;
int brightness = 0;    // how bright the LED is
int fadeAmount = 5;    // how many points to fade the LED by

int ldrperiod = 100;
unsigned long time_now = 0;

int hdtperiod = 10000;
unsigned long time_now1 = 0;

unsigned long previousMillis = 0;
unsigned long interval = 6000;
int a = 60;


int gstate = 0;

const int numReadings = 1;

int readings[numReadings];      // the readings from the analog input
int readIndex = 0;              // the index of the current reading
int total = 0;                  // the running total
int average = 0;                // the average

void setup() {

  Serial.begin(9600); //sets serial port for communication
  pinMode(led, OUTPUT);
  for (int thisReading = 0; thisReading < numReadings; thisReading++) {
    readings[thisReading] = 0;
  }
}

void loop() {
  //LDR Sensor LED Setup
  switch (gstate) {

    case 0:
      if (millis() >= time_now + ldrperiod) {
        sensorValue = analogRead(sensorPin); // read the value from the sensor
        if (sensorValue > 200) {
          delay(600);
          gstate = 1;
        }
        time_now += ldrperiod;
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
      delay(30);
      break;
  }

  //Humidity Sensor
  switch (gstate) {
    case 0:
      float temperature;
      float humidity;

      if (measure_environment( &temperature, &humidity ) == true) {
        // subtract the last reading:
        total = total - readings[readIndex];
        // read from the sensor:
        readings[readIndex] = humidity;
        // add the reading to the total:
        total = total + readings[readIndex];
        // advance to the next position in the array:
        readIndex = readIndex + 1;

        if (readIndex >= numReadings) {
          // ...wrap around to the beginning:
          readIndex = 0;
        }
        // calculate the average:
        average = total / numReadings;
        // send it to the computer as ASCII digits

        unsigned long currentMillis = millis();

        //        if (currentMillis - previousMillis > interval) {
        //          previousMillis = currentMillis;
        Serial.println(average);
        if (average >= 75) {
          gstate = 1;
        }
      }
      //      }
      break;

    case 1:
      break;
  }
}

static bool measure_environment( float *temperature, float *humidity ) {

  static unsigned long measurement_timestamp = millis( );

  if ( millis( ) - measurement_timestamp > 3000ul )
  {
    if ( dht_sensor.measure( temperature, humidity ) == true ) {
      return ( true );
    }
    return false;
  }
}

void reset() {

  fadeAmount = 5;
  gstate = 0;
  brightness = 0;
}
