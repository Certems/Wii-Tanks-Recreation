/*
load in assets
-Models
-Textures
-Sounds
*/

//1
PShape entity_tank_red_chassis;
PShape entity_tank_red_turret;
PShape entity_tank_blue_chassis;
PShape entity_tank_blue_turret;
PShape entity_tank_gray_chassis;
PShape entity_tank_gray_turret;
PShape entity_shell_normal;
PShape entity_shell_rocket;
PShape entity_mine;
PShape terrain_cork;
PShape terrain_crate;
PShape terrain_hole;

//2
PImage background_wood;
PImage text_cork;
PImage text_crate;

//3


void loadAll(){
    loadModels();
    loadTextures();
    loadSounds();
}


void loadModels(){
    loadModels_tanks();
    loadModels_shells();
    loadModels_mines();
    loadModels_terrain();
}
void loadTextures(){
    loadText_backgrounds();
    loadTextures_terrain();
}
void loadSounds(){
    loadSounds_tanks();
    loadSounds_music();
    loadSounds_menus();
}


void loadModels_tanks(){
    loadModels_tanks_red();
    loadModels_tanks_blue();
    loadModels_tanks_gray();
}
void loadModels_tanks_red(){
    entity_tank_red_chassis = loadShape("tank_red_chassis.obj");
    entity_tank_red_turret  = loadShape("tank_red_turret.obj");
}
void loadModels_tanks_blue(){
    entity_tank_blue_chassis = loadShape("tank_blue_chassis.obj");
    entity_tank_blue_turret  = loadShape("tank_blue_turret.obj");
}
void loadModels_tanks_gray(){
    //entity_tank_red_chassis = loadShape("tank_gray_chassis.obj");
    //entity_tank_red_turret  = loadShape("tank_gray_turret.obj");
}
void loadModels_shells(){
    entity_shell_normal = loadShape("shell_normal.obj");
    //entity_shell_rocket = loadShape("shell_rocket.obj");
}
void loadModels_mines(){
    //pass
}
void loadModels_terrain(){
    terrain_cork  = loadShape("terrain_cork.obj");
    terrain_crate = loadShape("terrain_wood.obj");
    //terrain_hole  = loadShape("terrain_hole.obj");
}


void loadText_backgrounds(){
    background_wood = loadImage("background_wood.jpg");
}
void loadTextures_terrain(){
    text_cork  = loadImage("wood_plywood_new_0008_01_s.jpg");
    text_crate = loadImage("wood_plywood_new_0009_01_s.jpg");
}


void loadSounds_tanks(){
    //pass
}
void loadSounds_music(){
    //pass
}
void loadSounds_menus(){
    //pass
}