manager cManager;

void setup(){
    fullScreen(P3D);
    cManager = new manager();
}
void draw(){
    cManager.calcGameState();
    cManager.displayGameState();
}

void keyPressed(){
    cManager.calcControls_keyPressed();
}
void keyReleased(){
    cManager.calcControls_keyReleased();
}
void mousePressed(){
    cManager.calcControls_mousePressed();
}
void mouseReleased(){
    cManager.calcControls_mouseReleased();
}