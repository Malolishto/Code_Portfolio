 _______   ________   _________   _____           __         __   ________ 
|       \ |  ______| |   ___   | |  __ \         |  \       /  | |  ______|
|  [_]  | |  |_____  |  |___|  | | |  | \        |   \     /   | |  |_____ 
|       / |   _____| |   ___   | | |  | |        |    \   /    | |   _____|
|  |\  \  |  |       |  |   |  | | |  | |        |  |\ \_/ /|  | |  |
|  | \  \ |  |_____  |  |   |  | | |__| /        |  | \   / |  | |  |_____
|__|  \__\|________| |__|   |__| |_____/         |__|  \_/  |__| |________|
 
Jacob Risch


This is a package that will allow for the efficient, ergonomic implementation of GUIs and menus into any Processing program with just a little copying and pasting so that you can focus on not GUIs.

The default program is a demo of how the menus work: there are six buttons, and clicking each one "changes" the menu which, in the demo, equates to the text in the upper-left hand corner changing.

The classes in this package are below:

Button: A class that encodes a button. Its initializable fields are 
	unpressed (PImage): The button that is displayed when the mouse is not over the button.
	pressed (PImage): The button that is displayed when the mouse is over the button and clicking it.
	hovering(PImage): The button that is displayed when the mouse is over the button, but not clicking it. 
	name(String): The name of the button. Not tied to what is displayed, merely used for tracking buttons.
	x, y, w, h (floats): The x and y coordinates, the width and height.
	The button can take either a single image or three. In the former case, the single image will occupy the three PImage variables.
	
	The button's one method (operate()) checks if the mouse has clicked the button, and returns true if it has been.

Menu: A class that encapsulates an array of buttons. Its intializable fields are
	button_list (Button []): The buttons in the menu.
	name (String): the name of the menu.
	state (int): the state number that the menu is associated with.
	
	The menu's one method (operate()) runs the operate() method in each button in the menu, returning the button's index value if it was pressed and returning the integer 50 if not.  