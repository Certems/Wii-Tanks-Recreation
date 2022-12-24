/*
The actual key and mouse press results can be found/added in the calculator

If you want to add more bindings, go to the calculator

This section detects a key/mouse press/release, then asks the enviroment to check the 
presses against each active state's conditions, which is an action performed by the 
calcuator as well. Therefore, only the key presses for the currently active states will 
be checked and the other states ignored
*/
void keyPressed(){
    cEnviro.keyPressedRequired();
}
void keyReleased(){
    cEnviro.keyReleasedRequired();
}

void mousePressed(){
    cEnviro.mousePressedRequired();
}
void mouseReleased(){
    cEnviro.mouseReleasedRequired();
}