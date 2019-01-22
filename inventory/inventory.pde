import static javax.swing.JOptionPane.*;

UIObject mark;
int x;


void setup(){
  size(500,500);
  frameRate(2);
  PGraphics boxSprite;
  boxSprite=createGraphics(10,10);
  boxSprite.beginDraw();
  boxSprite.image(loadImage("data/box.png"),0,0);
  boxSprite.endDraw();
  mark=new UIObject(color(0),250,250);
  for(int i=0; i<20;i++){
    mark.addElement(new UIObject(boxSprite,16+i*11,30));
  }
}

void draw(){
  background(60);
  line(frameCount,0,frameCount,10);
  stroke(255);
  mark.showUI();
}
