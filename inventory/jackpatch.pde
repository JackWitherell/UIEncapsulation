void keyPressed(){
  keys.ih(key,keyCode,true);
}

void keyReleased(){
  keys.ih(key,keyCode,false);
}

static class keys{
  private static HashMap<Character, Boolean> keys=new HashMap<Character,Boolean>();
  private static HashMap<Integer, Boolean> tags=new HashMap<Integer,Boolean>();
  public static void ih(char keyv, int codes, boolean ins){
    if(keyv==CODED){
      tags.put(codes,ins);
    }
    else{
      keys.put(keyv,ins);
    }
  }
  public static boolean isPressed(char thing){
    if(keys.containsKey(thing)){
      return keys.get(thing);
    }
    else{return false;}
  }
  public static boolean isPressed(String thing){
    if(tags.containsKey(thing)){
      return tags.get(thing);
    }
    else{return false;}
  }
}

void error(String error, boolean passable){
  showMessageDialog(null, error, (passable?"Uh Oh":"This isn't good..."), (passable?INFORMATION_MESSAGE:ERROR_MESSAGE));
  if(!passable){
    exit();
  }
}

@Override
PImage loadImage(String path){
  PImage temp=super.loadImage(path);
  if(temp==null){
    error("Assets are Missing! ("+path+")", false);
    return createGraphics(16,16);
  }
  else{
    return temp;
  }
}
