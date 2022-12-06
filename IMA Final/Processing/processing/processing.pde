import processing.serial.*;
import osteele.processing.SerialRecord.*;

Serial serialPort;
SerialRecord serialRecord;
PImage Map,img1,img2,img3;

int S_MAP = 0,S_HEAP = 1,S_OCEAN= 2 ,S_FOREST = 3;
int STATE;
int portNum = 5;


int[] val = new int[portNum];
int[] pre = new int[portNum];
void setup() {
  size(960, 600);
  String serialPortName = SerialUtils.findArduinoPort();
  serialPort = new Serial(this, serialPortName, 9600);
  serialRecord = new SerialRecord(this, serialPort, portNum);
  Map = loadImage("map2.jpg");
  img1 = loadImage("ocean.jpg");
  img2 = loadImage("mountain.png");
  img3 = loadImage("forest.jpg");
  
  STATE = S_MAP;
  
  for(int i=0;i<portNum;i++){
    val[i] = 0;
    pre[i] = 0;
  }
}

void draw(){
  serialRecord.read();
  for(int i=0;i<portNum;i++){
    val[i] = serialRecord.get(i);
  }
  
  if(STATE == S_MAP){
    float posx = map(val[0],0,1023,-width,0);
    image(Map,posx,0,width*2,height);
    
    if(val[1]==1){
      if(pre[1]==0){
        STATE = S_OCEAN;
      }
    }    
    if(val[2]==1){
      if(pre[2]==0){
        STATE = S_HEAP;
      }
    }    
    if(val[3]==1){
      if(pre[3]==0){
        STATE = S_FOREST;
      }
    }
  }
  
  if(STATE == S_OCEAN){    
    image(img1,0,0,width,height);
    if(val[4]==1){
      if(pre[4]==0){
        STATE = S_MAP;
      }
    }   
    
  }
    
  if(STATE == S_HEAP){    
    image(img2,0,0,width,height);
    if(val[4]==1){
      if(pre[4]==0){
        STATE = S_MAP;
      }
    }   
    
  }
    
  if(STATE == S_FOREST){    
    image(img3,0,0,width,height);
    if(val[4]==1){
      if(pre[4]==0){
        STATE = S_MAP;
      }
    }   
    
  }
  for(int i=0;i<portNum;i++){
    pre[i] = val[i];
  }
}
