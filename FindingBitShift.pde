import codeanticode.syphon.*; 
import processing.video.*;

// Size of each cell in the grid
int cellSize = 20;
// Number of columns and rows in our system
int cols, rows;
// Variable for capture device
Capture video;
Movie mov;
SyphonServer server;
void setup() {
  size(1280, 720, P3D);
  // Set up columns and rows
  cols = width / cellSize;
  rows = height / cellSize;
  colorMode(HSB, 100);
  rectMode(CENTER);
  smooth();
  // This the default video input, see the GettingStartedCapture 
  // example if it creates an error
  //video = new Capture(this, width, height);
  mov = new Movie(this, "finding.mp4");
  mov.loop();
  server = new SyphonServer(this, "Processing Syphon");
  // Start capturing the imatges from the camera
 // mov.start();  
 


  background(0);
}


void draw() { 
  if (mov.available()) {
    mov.read();
    mov.loadPixels();
    
    background(0, 20);

    // Begin loop for columns
    for (int i = 0; i < cols;i++) {
      // Begin loop for rows
      for (int j = 0; j < rows;j++) {

        // Where are we, pixel-wise?
        int x = i * cellSize;
        int y = j * cellSize;
        //int loc = (mov.width - x - 1) + y*mov.width; // Reversing x to mirror the image

        // Each rect is colored white with a size determined by brightness
        color c = mov.get(i*cellSize, j*cellSize);
        float sz = (brightness(c)  / 255.0) * (cellSize + 35);

//        fill(255);
//        noStroke();
//        rect(x + cellSize/2, y + cellSize/2, sz, sz);
        fill(c << 1, 20);
        noStroke();
        rect(x + cellSize/2, y + cellSize/2, sz*3, sz*3);
        stroke(c << 2);
        strokeWeight(2);
        noFill();
        ellipse(x + cellSize/2, y + cellSize/2, sz + 10, sz + 10);
      }
    }
  }
  server.sendScreen();
}

