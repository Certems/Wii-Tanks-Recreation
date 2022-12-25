/*
A note about terminology; pos in all entities here refers to pos WITHIN board
e.g their position from the starting point, not the origin
*/
environment cEnviro;
void setup(){
    fullScreen(P3D);
    loadAll();
    cEnviro = new environment();
}
void draw(){
    cEnviro.displayRequired();
    cEnviro.calcRequired();
}