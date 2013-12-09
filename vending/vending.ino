// Arduino is used for controlling the Lights and firing the Pneumatic Valve
char val;


 void setup() {
   pinMode(2, OUTPUT); // Set pin as OUTPUT
   pinMode(3, OUTPUT); // Set pin as OUTPUT
   pinMode(4, OUTPUT); // Set pin as OUTPUT
   pinMode(5, OUTPUT); // Set pin as OUTPUT
   pinMode(6, OUTPUT); // Set pin as OUTPUT
   Serial.begin(9600); // Start serial communication at 9600 bps
 }
 
void loop() {
  //delay(10000);
  //digitalWrite(6,HIGH);
  //delay(10000);
  //digitalWrite(6,LOW);

   if (Serial.available()) 
   { // If data is available to read,
     val = Serial.read(); // read it and store it in val
   }
   if (val == '0') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,LOW);
     digitalWrite(4,LOW);
     digitalWrite(5,LOW);
     digitalWrite(6,LOW);     
   }
   
   if (val == '1') 
   { 
     digitalWrite(2,HIGH);
     digitalWrite(3,LOW);
     digitalWrite(4,LOW);
     digitalWrite(5,LOW);  
     digitalWrite(6,LOW);   
   }
   
   if (val == '2') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,HIGH);
     digitalWrite(4,LOW);
     digitalWrite(5,LOW);
     digitalWrite(6,LOW);     
   }
   
   if (val == '3') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,LOW);
     digitalWrite(4,HIGH);
     digitalWrite(5,LOW);
     digitalWrite(6,LOW);     
   }
   
   if (val == '4') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,LOW);
     digitalWrite(4,LOW);
     digitalWrite(5,HIGH); 
     digitalWrite(6,LOW);    
   }
   
   if (val == '5') 
   { 
     digitalWrite(2,HIGH);
     digitalWrite(3,LOW);
     digitalWrite(4,LOW);
     digitalWrite(5,LOW);
     digitalWrite(6,HIGH);     
   }
   
   if (val == '6') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,HIGH);
     digitalWrite(4,LOW);
     digitalWrite(5,LOW);
     digitalWrite(6,LOW);     
   }
   if (val == '7') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,LOW);
     digitalWrite(4,HIGH);
     digitalWrite(5,LOW);
     digitalWrite(6,LOW);     
   }
   if (val == '8') 
   { 
     digitalWrite(2,LOW);
     digitalWrite(3,LOW);
     digitalWrite(4,LOW);
     digitalWrite(5,HIGH);
     digitalWrite(6,LOW);     
   }

   delay(10); // Wait 10 milliseconds for next reading
}
