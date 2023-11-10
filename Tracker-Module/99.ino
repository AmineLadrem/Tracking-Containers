#include <TinyGPS++.h>
#include <SoftwareSerial.h>

#define SIM_RX 5
#define SIM_TX 4

#define GPS_RX 9
#define GPS_TX 8
#define DELAY_MS 1000
#define DELAY_MS_HTTP 600
#define DELAY_MS_SHORT 50


SoftwareSerial gpsM(GPS_RX, GPS_TX);
TinyGPSPlus gps;

SoftwareSerial SIM(SIM_RX, SIM_TX);

//----------------------------------------------------Variables---------------------------------------
String data;
double lat=0,lng=0;
int year=0,month=0,day=0,hour=0,minute=0,second=0;

const String APN  = "";
const String USER = "";
const String PASS = "";

const String FIREBASE_HOST  = "";
const String FIREBASE_SECRET  = "";

boolean locationfound=false;


//----------------------------------------------------Fonctions/Procedures---------------------------------------
void SIM_init();
void gprs_init();
boolean if_gprs();
void SIM_respond();
String get_location(double lat, double lng,int year,int month,int day,int hour,int minute,int second);
void post_firebase(String data);

//---------------------------------------------------------------------------------------------------------------

void setup() {
  Serial.begin(9600);

  gpsM.begin(9600);
  Serial.println("Init GPS...");
  delay(500);

  SIM.begin(9600);
  Serial.println("Init SIM...");
  delay(500);

  SIM_init();
  gprs_init();
 

}

void loop() {

  gpsM.listen();
  while (gpsM.available()>0){
  
    gps.encode(gpsM.read());
    if (gps.location.isUpdated()){ 

      locationfound=true;
      lat=gps.location.lat();
      lng=gps.location.lng();
      year=gps.date.year();
      month=gps.date.month();
      day=gps.date.day();
      hour=gps.time.hour()+1;
      minute=gps.time.minute();
      second=gps.time.second();          
      Serial.print(lat,8);
      Serial.print("       ");
      Serial.println(lng,8);
      data=get_location(lat,lng,year,month,day,hour,minute,second);

   if(locationfound){
  post_firebase(data);
  return 0;
  }
    }
  }
  
}

void SIM_respond(){
 while(SIM.available()){
 Serial.write( SIM.read());
}
}

void SIM_init(){

  
 SIM.println("AT");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.println("AT+CPIN?");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.println("AT+CFUN=1");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.println("AT+CMEE=2");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.println("AT+CBATCHK=1");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.println("AT+CREG?");
 delay(DELAY_MS_SHORT);
 SIM_respond();

 SIM.print("AT+CMGF=1\r");
 delay(DELAY_MS_SHORT);
 SIM_respond();

}

void gprs_init(){

  SIM.println("AT+SAPBR=3,1,\"Contype\",\"GPRS\"");
  delay(DELAY_MS_SHORT);
  SIM_respond();
  
  SIM.println("AT+SAPBR=3,1,\"APN\","+APN);
  delay(DELAY_MS_SHORT);
  SIM_respond();
   
  SIM.println("AT+SAPBR=3,1,\"USER\","+USER);
  delay(DELAY_MS_SHORT);
  SIM_respond();
 
  SIM.println("AT+SAPBR=3,1,\"PASS\","+PASS);
  delay(DELAY_MS_SHORT);
  SIM_respond();
  
  SIM.println("AT+SAPBR=1,1");
  delay(DELAY_MS);
  SIM_respond();
 
  SIM.println("AT+SAPBR=2,1");
  delay(DELAY_MS_SHORT);
  SIM_respond();
 
}

boolean if_gprs(){
 
    SIM.println("AT+CGATT?");
  while (SIM.available()) {
  String c = SIM.readString();
  if(c.indexOf("+CGATT: 1") != -1) {
    return true;
  }
}

  return false;
}

String get_location(double lat, double lng,int year,int month,int day,int hour,int minute,int second){
  String data ;
  String slat = String(lat, 8);
  String slng = String(lng, 8);
  String syear = String(year);  
  String smonth = String(month);  
  String sday = String(day);  
  String shour = String(hour);  
  String sminute = String(minute);  
  String ssecond = String(second);  

  data = "{";

  data += "\"lat\":\"" + slat + "\",";
  data += "\"lng\":\"" + slng + "\",";
  data += "\"timestamp\":\"" + syear + "-" + smonth + "-" + sday + "   " + shour + ":" + sminute + ":" + ssecond + " \"";
    
  data += "}";

  return data;
}

void post_firebase(String data){

  SIM.println("AT+HTTPINIT");
  delay(DELAY_MS_HTTP);
  SIM_respond();

  SIM.println("AT+HTTPSSL=1");
  delay(DELAY_MS_HTTP);
  SIM_respond();
 
  SIM.println("AT+HTTPPARA=\"CID\",1");
  delay(DELAY_MS_SHORT);
  SIM_respond();

  SIM.println("AT+HTTPPARA=\"URL\","+FIREBASE_HOST+".json?auth="+FIREBASE_SECRET);
  delay(DELAY_MS_SHORT);
  SIM_respond();
  
  SIM.println("AT+HTTPPARA=\"REDIR\",1");
  delay(DELAY_MS_SHORT);
  SIM_respond();

  SIM.println("AT+HTTPPARA=\"CONTENT\",\"application/json\"");
  delay(DELAY_MS_SHORT);
  SIM_respond();

  SIM.println("AT+HTTPDATA=" + String(data.length()) + ",10000");
  delay(DELAY_MS_HTTP);
  SIM_respond();

  SIM.println(data);
  delay(DELAY_MS_HTTP);
  SIM_respond();

  SIM.println("AT+HTTPACTION=1");
  delay(DELAY_MS_HTTP);
  SIM_respond();
  
  SIM.println("AT+HTTPREAD");
  delay(DELAY_MS_HTTP);
  SIM_respond();

  SIM.println("AT+HTTPTERM");
  delay(DELAY_MS_SHORT);
  SIM_respond();

  return 0;
}


