PImage background_wood;

PShape shell_normal;

PShape tank_red_chassis;
PShape tank_red_turret;
PShape tank_blue_chassis;
PShape tank_blue_turret;
PShape tank_gray_chassis;
PShape tank_gray_turret;

PShape terrain_wood;
PShape terrain_cork;

void loadAll(){
    loadTextures();
    loadModels();
    loadSounds();
}


void loadTextures(){
    loadTextures_wood();
}
void loadTextures_wood(){
    background_wood = loadImage("background_wood.jpg");
}


void loadModels(){
    loadModels_shells();
    loadModels_tanks();
    loadModels_terrain();
}
void loadModels_shells(){
    loadModels_shellNormal();
}
void loadModels_tanks(){
    loadModels_redTank();
    loadModels_blueTank();
    loadModels_grayTank();
}
void loadModels_terrain(){
    loadModels_terrain_wood();
    loadModels_terrain_cork();
}
void loadModels_shellNormal(){
    shell_normal = loadShape("shell_normal.obj");
}
void loadModels_redTank(){
    tank_red_turret  = loadShape("tank_red_turret.obj");
    tank_red_chassis = loadShape("tank_red_chassis.obj");
}
void loadModels_blueTank(){
    tank_blue_turret  = loadShape("tank_blue_turret.obj");
    tank_blue_chassis = loadShape("tank_blue_chassis.obj");
}
void loadModels_grayTank(){
    tank_gray_turret  = loadShape("tank_gray_turret.obj");
    tank_gray_chassis = loadShape("tank_gray_chassis.obj");
}
void loadModels_terrain_wood(){
    terrain_wood = loadShape("terrain_wood.obj");
}
void loadModels_terrain_cork(){
    terrain_cork = loadShape("terrain_cork.obj");
}


void loadSounds(){
    //pass
}