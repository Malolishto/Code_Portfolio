//Global 
int state;

//Main menu 
Menu main_menu0;
Button button1;
Button button2;
Button button3;
Button button4;
Button button5;
Button button6;
Button [] button_list;
PImage unpressed;
PImage pressed;
PImage hovering;

//Instructions menu

//Game menu

//Saveload menu

//Pause menu

void setup(){
size(700, 800);
state = 0;

//Main menu 
unpressed = loadImage("button1/unpressed.jpg");
pressed = loadImage("button1/pressed.jpg");
hovering = loadImage("button1/hovering.jpg");
button1 = new Button(unpressed, pressed, hovering , "button1", 250, 100, 200, 100);
button2 = new Button(unpressed, pressed, hovering , "button2", 250, 200, 200, 100);
button3 = new Button(unpressed, pressed, hovering , "button3", 250, 300, 200, 100);
button4 = new Button(unpressed, pressed, hovering , "button3", 250, 400, 200, 100);
button5 = new Button(unpressed, pressed, hovering , "button3", 250, 500, 200, 100);
button6 = new Button(unpressed, pressed, hovering , "button3", 250, 600, 200, 100);

button_list = new Button [6];
button_list[0] = button1; button_list[1] = button2; button_list[2] = button3; button_list[3] = button4;button_list[4] = button5; button_list[5] = button6;
main_menu0 = new Menu(button_list, "main menu", 0);


}


void draw(){
  if(state == 0){
    main_menu();
  } else if (state == 1){
    game();
  } else if (state == 2){
    instructions();
  } else if (state == 3){
    loadsave();
  } else if (state == 4){
    setting();
  } else if (state == 5){
    pause(); 
  }
}

void main_menu(){
  background(0);
  text("Main Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}

void instructions(){
  background(80);
  text("Instructions Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}
void game(){
  background(40);
  text("Game Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}

void loadsave(){
  background(120);
  text("Load/Save Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}

void setting(){
  background(160);
  text("Settings Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}

void pause(){
background(200);
  text("Pause Menu", 20, 20);
  int inter = 0;
  inter = main_menu0.operate();
  if (inter != state & inter != 50){
    state = inter;
  }
}
