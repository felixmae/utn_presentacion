#include <Adafruit_NeoPixel.h>
#include <Arduino.h>
#include <WiFi.h>
#include <WebServer.h>
#include <ArduinoJson.h>
#include <FreeRTOS.h>
 
#include <Adafruit_NeoPixel.h>


const char *SSID = "Wifi_ssid";
const char *PWD = "Password";

#define NUM_OF_LEDS 1 
#define PIN 18
 
// Web server running on port 80
WebServer server(80);
 
// Neopixel LEDs strip
Adafruit_NeoPixel pixels(NUM_OF_LEDS, PIN, NEO_GRB + NEO_KHZ800);
 
// JSON data buffer
StaticJsonDocument<250> jsonDocument;
char buffer[250];
 
int randomNumber;
 
void connectToWiFi() {
  Serial.print("Connecting to ");
  Serial.println(SSID);
  
  WiFi.begin(SSID, PWD);
  
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
 
  Serial.print("Connected. IP: ");
  Serial.println(WiFi.localIP());
}

void setup_routing() {         
  server.on("/number", getNumber);     
  server.on("/led", HTTP_POST, handlePost);  
  // start server    
  server.begin();    
}
 
void read_sensor_data(void * parameter) {
   for (;;) {
     randomNumber = random(-100, 100);
     Serial.print("Number is: ");
     Serial.println(randomNumber);
 
     // delay 1s the task
     vTaskDelay(1000 / portTICK_PERIOD_MS);
   }
}
 
void getNumber() {
  Serial.println("Get number");
  jsonDocument.clear();
  jsonDocument["number"] = randomNumber;
  serializeJson(jsonDocument, buffer);
  server.send(200, "application/json", buffer);
}

void handlePost() {
  if (server.hasArg("plain") == false) {
    //handle error here
  }
  String body = server.arg("plain");
  deserializeJson(jsonDocument, body);
  
  // Get RGB components
  int red = jsonDocument["red"];
  int green = jsonDocument["green"];
  int blue = jsonDocument["blue"];
  
  pixels.fill(pixels.Color(red, green, blue));
  pixels.show();
  // Respond to the client
  server.send(200, "application/json", "{Ok}");
}

void setup_task() {    
  xTaskCreate(     
  read_sensor_data,      
  "Read sensor data",      
  1000,      
  NULL,      
  1,     
  NULL     
  );     
}
void setup() {     
  Serial.begin(9600);    
  randomSeed(analogRead(0));
       
  connectToWiFi();     
  setup_task();    
  setup_routing();     
  // Initialize Neopixel     
  pixels.begin();    
}    
       
void loop() {    
  server.handleClient();     
}

