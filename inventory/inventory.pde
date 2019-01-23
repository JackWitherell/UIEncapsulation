import static javax.swing.JOptionPane.*;

UIObject mark;

void setup(){
  size(500,500);
  frameRate(2);
  mark=new UIObject(loadJSONObject("test.json"));
  //mark=new UIObject(color(0),250,250);
  //for(int i=0; i<20;i++){
  //  mark.addElement(new UIObject("data/box.png",16+i*11,30));
  //}
  //saveJSONObject(mark.JSONify(),"test.json");
}

void draw(){
  background(60);
  line(frameCount,0,frameCount,10);
  stroke(255);
  mark.showUI();
}

//todo list
//done!make recognizable data reloadable
//done!load and store ui
//done!jsonify
//make UIObject easily extendable /w polymorphism
//make the JSONify function overloadable for custom UI
