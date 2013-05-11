import com.shigeodayo.ardrone.processing.*;
/*FullScreeeen*/
//import fullscreen.*; 
//FullScreen fs;
ARDroneForP5 ardrone;


void setup() {
  size(1280, 960);
  PFont cfont = createFont("serif", 10);
  textFont(cfont);
  /*FullScreeeen*/
  //fs = new FullScreen(this); 
  //fs.enter();
  ardrone=new ARDroneForP5("192.168.1.1");
  // connect to the AR.Drone
  ardrone.connect();
  // for getting sensor information
  ardrone.connectNav();
  // for getting video informationp
  ardrone.connectVideo();
  // start to control AR.Drone and get sensor and video data of it
  ardrone.start();
}

void draw() {
  background(204);  
  sysEngage();
  // getting image from AR.Drone
  // true: resizeing image automatically
  // false: not resizing
  PImage img = ardrone.getVideoImage(false);
  if (img == null)
    return;
  image(img, 0, 0, 1280, 960);
  showData();
  sysEngage();
}

//PCのキーに応じてAR.Droneを操作できる．
// controlling AR.Drone through key input
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      ardrone.forward(); // go forward
    } 
    else if (keyCode == DOWN) {
      ardrone.backward(); // go backward
    } 
    else if (keyCode == LEFT) {
      ardrone.goLeft(); // go left
    } 
    else if (keyCode == RIGHT) {
      ardrone.goRight(); // go right
    } 
    else if (keyCode == SHIFT) {
      ardrone.takeOff(); // take off, AR.Drone cannot move while landing
    } 
    else if (keyCode == CONTROL) {
      ardrone.landing();
      // landing
    }
  } 
  else {
    if (key == 's') {
      ardrone.stop(); // hovering
    } 
    else if (key == 'r') {
      ardrone.spinRight(); // spin right
    } 
    else if (key == 'l') {
      ardrone.spinLeft(); // spin left
    } 
    else if (key == 'u') {
      ardrone.up(); // go up
    }
    else if (key == 'd') {
      ardrone.down(); // go down
    }
    else if (key == '1') {
      ardrone.setHorizontalCamera(); // set front camera
    }
    else if (key == '2') {
      ardrone.setHorizontalCameraWithVertical(); // set front camera with second camera (upper left)
    }
    else if (key == '3') {
      ardrone.setVerticalCamera(); // set second camera
    }
    else if (key == '4') {
      ardrone.setVerticalCameraWithHorizontal(); //set second camera with front camera (upper left)
    }
    else if (key == '5') {
      ardrone.toggleCamera(); // set next camera setting
    }
  }
}

void sysEngage(){
  fill(255, 0, 0, 80);
  rect(320, 150, 640, 100);
  fill(255, 255, 255);
  textSize(60);
  text("System Engage", 440, 220);  
}

void showData(){
  // print out AR.Drone information
  ardrone.printARDroneInfo();
  // getting sensor information of AR.Drone
  float pitch = ardrone.getPitch();
  float roll = ardrone.getRoll();
  float yaw = ardrone.getYaw();
  float altitude = ardrone.getAltitude();
  float[] velocity = ardrone.getVelocity();
  int battery = ardrone.getBatteryPercentage();
  textSize(40);
  String attitude = "PITCH:\t" + pitch + "\n\nROLL:\t" + roll + "\n\nYAW:\t" + yaw + "\n\nALTITUDE:\t" + altitude;
  text(attitude, 20, 200);
  String vel = "VX:" + velocity[0] + "\n\nVY:" + velocity[1];
  text(vel, 20, 500);
  String bat = "BATTERY:" + battery + " %";
  text(bat, 20, 900);
}
void pointer(){

}
