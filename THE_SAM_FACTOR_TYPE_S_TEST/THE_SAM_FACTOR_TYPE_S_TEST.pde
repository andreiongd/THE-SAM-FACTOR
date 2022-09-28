//THE SAM FACTOR
//developed by Andreion de Castro @andreiongd

import processing.svg.*;
import processing.pdf.*;

OpenSimplexNoise noise;

// number of cluster
int num = 300;

ArrayList clusterCollection; 

boolean save = false;
boolean record = false;

float scal, theta;

PGraphics letter;
PGraphics pg;
PFont font, tFont;

String l = "S"; 

int marginX = 100;
int marginY = 100;
int txtSize = 800;
int numFrames = 120;

int backgroundCol = #000000;  // background colour
int logoCol = #ffffff; 
int strokeCol = #ffffff;

float dx,dy;

PImage img;
float t;

void setup() {
  
  size(900, 900);
  
  pg = createGraphics(width,height);
  letter = createGraphics(width, height);
  img = loadImage("circle.png");
  font = createFont("FontsFree-Net-AlteHaasGroteskRegular.ttf",txtSize);
  tFont = createFont("AktivGrotesk-Regular.ttf",20);
  
  noise = new OpenSimplexNoise();
  clusterCollection = new ArrayList();
  
  createStuff();

}

float periodicFunction(float p,float seed,float x,float y)
{
  float radius = 1;
  float sclX = 0.01;
  float sclY = 0.01;
  return 1*(float)noise.eval(seed+radius*cos(TWO_PI*p),radius*sin(TWO_PI*p),sclX*x,sclY*y);
}

float offset(float x,float y)
{
  return -0.1*x+y;
}

void draw() {
  
  t = map(frameCount-1, 0, numFrames, 0, 1);
  
 //if (record) beginRecord(SVG,"fr"+frameCount+".svg");
 if (record) saveFrame("fr"+frameCount+".png");
 
  background(backgroundCol);

  for (int i=0; i<clusterCollection.size (); i++) {
    Cluster mb = (Cluster)clusterCollection.get(i);
   
    mb.run();
  }  

  theta += .05;
 
  //noLoop();
  //saveFrame("fr###.png");
  //if (frameCount == numFrames) {
    
  //  stop();
  //}
  
   if (record) {
  endRecord();
  record = false;
  } 
}

void keyPressed() {
  if (key != CODED) l = str(key);
  createStuff();
}

void mousePressed() {
  record = true; 
}

void createStuff() {
  
  //float t = map(frameCount, 0, numFrames, 0, 1);
   
  clusterCollection.clear();
  
  letter.beginDraw();
  letter.noStroke();
  letter.background(255);
  letter.fill(0);
  letter.textFont(font, txtSize);
  letter.textAlign(CENTER);
  letter.text(l, width*0.5, height*0.8);
  letter.endDraw();
  letter.loadPixels();

  for (int i=0; i<num; i++) {
    
   int x = (int)random(marginX,width-marginX);
   int y = (int)random(marginY,height-marginY); 
    
    float dx = 50.0*periodicFunction(t-offset(x,y),1000,x,y);
    float dy = 20.0*periodicFunction(t-offset(x,y),123,x,y);
    
    //int c = letter.get(x,y);
    int c = letter.pixels[x+y*width];

     if (brightness(c) < 10) {
   
      PVector org = new PVector(x, y);
      
      float radius = random(0,40);
      PVector loc = new PVector(x, y);
      float offSet = random(TWO_PI);
      int dir = 1;
      float r = random(1);
      
      if (r>.5) dir =-1;
      
      Cluster myCluster = new Cluster(org, loc, radius, dir, offSet);
      clusterCollection.add(myCluster);    }
  }
   
}
