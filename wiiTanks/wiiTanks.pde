manager cManager;

void setup(){
    fullScreen(P3D);
    cManager = new manager();
}
void draw(){
    background(0,0,0);
    cManager.calcGameState();
    cManager.displayGameState();
    cManager.resolveCoordinator();
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