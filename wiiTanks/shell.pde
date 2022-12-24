class shell{
    /*
    A projectile fired by tanks
    They can move with different speeds and accelerations
    If they collide with a tank, both entities are destroyed
    If they collide with a wall, they are deflected BUT will be destroyed after n bounces
    */
    PVector casing = new PVector(255,255,255);  //## MAKE A MODEL IN FUTURE, NOT JUST A COLOUR ##  

    int nReflect;   //Number of reflections allowed

    PVector pos;
    PVector vel;
    PVector acc;
    //##############################################################################
    //## CAN ADD FINER TICKING IF NEEDED, BUT SHOULD BE SLOW ENOUGH THAT ITS FINE ##
    //##############################################################################

    shell(int reflectionNumber, PVector initPos, PVector initVel, PVector initAcc){
        nReflect = reflectionNumber;
        pos = initPos;
        vel = initVel;
        acc = initAcc;
    }

    void calcDynamics(){
        calcAcc();
        calcVel();
        calcPos();
    }
    void calcAcc(){
        //pass
    }
    void calcVel(){
        vel.x += acc.x;
        vel.y += acc.y;
    }
    void calcPos(){
        pos.x += vel.x;
        pos.y += vel.y;
    }
    boolean checkTerrainCollision(terrain cTerrain, float tWidth){
        /*
        [Point] with [Box] collision
        Checks whether this shell is colliding with a given piece of terrain
        Terrain is only checked if within a radius of the shell
        True is returned if collision should occur

        **Note; Checks if inside next frame so velocity can be reversed now without
            getting stuck inside the terrain
        */
        boolean withinX = (cTerrain.pos.x -tWidth/2.0 < pos.x+vel.x) && (pos.x+vel.x < cTerrain.pos.x +tWidth/2.0);
        boolean withinY = (cTerrain.pos.y -tWidth/2.0 < pos.y+vel.y) && (pos.y+vel.y < cTerrain.pos.y +tWidth/2.0);
        if(withinX && withinY){
            //If will be inside terrain NEXT frame, then will collide
            return true;
        }
        else{
            return false;
        }
    }
    void deflectShell(terrain cTerrain, float tWidth){
        /*
        Deflects shell veocities according to wall
        (A simple case here as walls are paraxial)

        **Note; The death of a shell is calculated inside the calculator
            ALSO Elastic collisions
        */
        println("Deflected");
        nReflect--;
        float hRatio = abs(pos.x-cTerrain.pos.x)/vel.x;
        float vRatio = abs(pos.y-cTerrain.pos.y)/vel.y;
        boolean hWallCollision = hRatio < vRatio;
        if(hWallCollision){
            vel.y *= -1;}
        else{
            vel.x *= -1;}
    }
}