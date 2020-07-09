#include <dht_nonblocking.h>
#define DHT_SENSOR_TYPE DHT_TYPE_11

static const int DHT_SENSOR_PIN = A2;
DHT_nonblocking dht_sensor( DHT_SENSOR_PIN, DHT_SENSOR_TYPE );

int sensorPin = A0; // select the input pin for LDR
int sensorValue = 0; // variable to store the value coming from the sensor

int led = 9;
int brightness = 0;    // how bright the LED is
int fadeAmount = 3;    // how many points to fade the LED by

int period = 100;
unsigned long time_now = 0;

int gstate = 0;

void setup() {

  Serial.begin(9600); //sets serial port for communication
  pinMode(led, OUTPUT);

}

void loop() {
  //LED Sensor
  switch (gstate) {

    case 0:
      if (millis() >= time_now + period) {
        sensorValue = analogRead(sensorPin); // read the value from the sensor
        Serial.println(sensorValue);
        if (sensorValue > 200) {
          delay(600);
          gstate = 1;
        }
        time_now += period;
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

          if(humidity >= 90){
            gstate = 1;
          }
//        Serial.print( "T = " );
//        Serial.print( temperature, 1 );
//        Serial.print( " deg. C, H = " );
//        Serial.print( humidity, 1 );
//        Serial.println( "%" );
      }
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
  fadeAmount = 3;
  gstate = 0;
  brightness = 0;
}
