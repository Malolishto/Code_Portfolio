class Button{
  //inputted variables
  PImage unpressed;
  PImage hovering;
  PImage pressed;
  String name;
  float x;
  float y;
  float w;
  float h;
  
  //intrinsic variables
  boolean pmousePressed = false;
  //If you prefer a simple button with no intermediate shapes 
  Button(PImage unpressed, String name, float x, float y, float w, float h){
    this.unpressed = unpressed;
    this.hovering = unpressed;
    this.pressed = unpressed;
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  //If you prefer the most complex button with unpressed, pressed, and hovered-over forms.
  Button(PImage unpressed, PImage pressed,PImage hovering, String name, float x, float y, float w, float h){
    this.unpressed = unpressed;
    this.hovering = hovering;
    this.pressed = pressed;
    this.name = name;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  boolean operate(){
    //If button is hovered over, display hovering_shape, prep for press
    if (x < mouseX & mouseX < x + w & y < mouseY & mouseY < y + h){
      //If mouse is pressed, display pressed_shape
      if(mousePressed == true){
        image(pressed, x, y, w, h);
        
      }
      //If mouse is released while over the button, return true
      else if(pmousePressed == true){
        image(unpressed, x, y, w, h);
        //println("returned true");
        pmousePressed = mousePressed; 
        return true;
      }
      
      //if mouse isn't pressed, display hovering_shape
      else{image(hovering, x, y, w, h);}
      pmousePressed = mousePressed; 
      return false;
    }
    //If button isn't hovered over, display unpressed_shape
    else{
      image(unpressed, x, y, w, h);
    }
   pmousePressed = mousePressed; 
   return false;
  }

}
