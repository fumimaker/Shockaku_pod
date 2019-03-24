import processing.serial.*;
float gx, gy, gz, ax, ay, az;
int serialTimer;
Serial myPort;

void setup() {
  size(500, 500);
  frameRate(60);
  myPort = new Serial(this, "/dev/tty.usbserial-A7043P8Y", 57600);
}

void draw() {
  if (millis()-serialTimer > 20) {
    serialTimer = millis();
    
    myPort.write(0x6d);
    delay(2);
    byte[] inBuf = new byte[8];
    //println(myPort.available());
    if (myPort.available() == 8) {
      myPort.readBytes(inBuf);
      gx = ((( inBuf[0] & 0x03 ) << 8 ) | inBuf[1]) / 100.0f * 6.0f;
      gy = ((( inBuf[2] & 0x03 ) << 8 ) | inBuf[3]) / 100.0f * 6.0f;
      gz = ((( inBuf[4] & 0x03 ) << 8 ) | inBuf[5]) / 100.0f * 6.0f;
      ax = ((( inBuf[6] & 0x03 ) << 8 ) | inBuf[7]) / 100.0f * 6.0f;
    }
    else if(myPort.available() < 8){
      //do nothing
    }
    else{
      while(myPort.available() > 0){
        myPort.readBytes();
      }
    }
  }
  background(0);
  
  fill(255,0,0);
  rect(50, 450, 50, -gx*100.0f);
  fill(0,255,0);
  rect(120, 450, 50, -gy*100.0f);
  fill(0,0,255);
  rect(190, 450, 50, -gz*100.0f);
  fill(255,255,255);
  rect(260, 450, 50, -ax*100.0f);
  
  textSize(15);
  text(nf(gx, 0, 2), 50, 470);
  text(nf(gy, 0, 2), 120, 470);
  text(nf(gz, 0, 2), 190, 470);
  text(nf(ax, 0, 2), 260, 470);
  
  //delay(50);
  
  
}