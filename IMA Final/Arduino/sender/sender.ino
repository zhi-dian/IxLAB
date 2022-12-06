#include "SerialRecord.h"

SerialRecord writer(5);
//potentiometer, back, image1, image2
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(8,INPUT);
  pinMode(9,INPUT);
  pinMode(10,INPUT);
  pinMode(11,INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int value1 = analogRead(A0);
  int value2 = digitalRead(8);
  int value3 = digitalRead(9);
  int value4 =  digitalRead(10);
  int value5 =  digitalRead(11);
  // Serial.println(value1,value2,value3,value4);
  writer[0] = value1;
  writer[1] = value2;
  writer[2] = value3;
  writer[3] = value4;
  writer[4] = value5;
  writer.send();
  delay(20);
}