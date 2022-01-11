class Menu{
  //Initializable
  Button [] button_list;
  String name;
  int state;    //This should never change. This is the state that describes the specific menu.
  
  //Non-initializable
   
   Menu(Button [] button_list, String name, int state){
     this.button_list = button_list;
     this.name = name;
     this.state = state;
   }
   
   //Run "operate" on all buttons in the Menu. Return the state corresponding to the button called. 
   /* Example states:
   0: main menu
   1: game
   2: instructions
   3: save/load
   4: settings
   5,6,7..: miscellaneous
   You just need to plan ahead!
   */
   int operate(){
     for(int i=0;i<button_list.length;i++){
       if(button_list[i].operate()){
         return i; 
       }
     }
     return 50;
   }
}
