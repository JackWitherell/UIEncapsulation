/**  creates a UI element that can perpetrate recursively
     can contain other ui elements
     can recursively print all of the ui elements it contains
*/
class UIObject{
  int objX, objY;
  int objWidth, objHeight;
  PImage objVisual;
  String fileName;
  color objColor;
  ArrayList<UIObject> contents;
  PGraphics localUICanvas;
  UIObject(){
    objX=objY=0;
    objVisual=loadImage("data/broken.png");
    //no fileName
    objWidth=objVisual.width;
    objHeight=objVisual.height;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(String path){
    objX=objY=0;
    objVisual=loadImage(path);
    fileName=path;
    objWidth=objVisual.width;
    objHeight=objVisual.height;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(PImage graphic){
    objX=objY=0;
    objVisual=graphic;
    //no fileName
    objWidth=objVisual.width;
    objHeight=objVisual.height;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(String path, int _x, int _y){
    objX=_x;
    objY=_y;
    objVisual=loadImage(path);
    fileName=path;
    objWidth=objVisual.width;
    objHeight=objVisual.height;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(PImage graphic, int _x, int _y){
    objX=_x;
    objY=_y;
    objVisual=graphic;
    //no fileName
    objWidth=objVisual.width;
    objHeight=objVisual.height;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(color _color, int _width, int _height){
    objX=objY=0;
    objWidth=_width;
    objHeight=_height;
    objColor=_color;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(color _color, int x, int y, int _width, int _height){
    objX=x;
    objY=y;
    objWidth=_width;
    objHeight=_height;
    objColor=_color;
    initGraphics();
    localUICanvas.endDraw();
  }
  UIObject(JSONObject jtag){
    objX=jtag.getInt("xloc");
    objY=jtag.getInt("yloc");
    objWidth=jtag.getInt("objWidth");
    objHeight=jtag.getInt("objHeight");
    if(jtag.hasKey("color")){
      objColor=jtag.getInt("color");
    }
    else if(jtag.hasKey("filename")){
      fileName=jtag.getString("filename");
      objVisual=loadImage(fileName);
    }
    if(jtag.hasKey("uiObjects")){
      JSONArray ui;
      ui = jtag.getJSONArray("uiObjects");
      for(int i=0; i<ui.size(); i++){
        addElement(new UIObject(ui.getJSONObject(i)));
      }
    }
    initGraphics();
    localUICanvas.endDraw();
  }
  /** initialize graphics buffer
      uses data inherent to the UI object to set up buffer
      should only be used internally to reset the buffer
      assumes that you'll want to continue drawing to the buffer
      so it doesn't end the drawing state afterwards. used to save
      resources and not do extra work.
  */
  private void initGraphics(){
    if(localUICanvas==null){
      localUICanvas=createGraphics(objWidth, objHeight);
      localUICanvas.beginDraw();
    }
    else{
      localUICanvas.beginDraw();
      localUICanvas.clear();
    }
    if(objVisual!=null){
      localUICanvas.image(objVisual,0,0);
    }
    else if(alpha(objColor)!=0){
      //assume color
      localUICanvas.background(objColor);
    }
  }
  PImage getUI(){
    initGraphics();
    if(contents!=null){
      for (int i=0; i<contents.size();i++){
        localUICanvas.image(
            contents.get(i).getUI(),
            contents.get(i).objX,
            contents.get(i).objY);
        localUICanvas.stroke(255);
        localUICanvas.line(contents.get(i).objX,50,0,80);
      }
    }
    localUICanvas.endDraw();
    localUICanvas.updatePixels();
    return localUICanvas;
  }
  void showUI(){
    image(getUI(),objX,objY);
  }
  void addElement(UIObject obj){
    if(contents==null){
      contents=new ArrayList<UIObject>();
    }
    contents.add(obj);
  }
  JSONObject JSONify(){
    JSONObject jtag;
    jtag = new JSONObject();
    if(objVisual==null){ //if background is a color store the color
      jtag.setInt("color", objColor);
    }
    else if(fileName!=null){ //store sent in image
      jtag.setString("filename", fileName);
    }
    jtag.setInt("xloc", objX);
    jtag.setInt("yloc", objY);
    jtag.setInt("objWidth", objWidth);
    jtag.setInt("objHeight", objHeight);
    if(contents!=null){
      JSONArray ui;
      ui = new JSONArray();
      for(int i=0; i<contents.size(); i++){
        ui.setJSONObject(i,contents.get(i).JSONify());
      }
      jtag.setJSONArray("uiObjects",ui);
    }
    return jtag;
  }
}
