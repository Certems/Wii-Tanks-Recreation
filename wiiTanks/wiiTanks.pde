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
    //pass
}
void keyReleased(){
    //pass
}
void mousePressed(){
    //pass
}
void mouseReleased(){
    //pass
}