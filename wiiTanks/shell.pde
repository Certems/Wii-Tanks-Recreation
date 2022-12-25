class shell{
    /*
    A projectile fired by tanks
    They can move with different speeds and accelerations
    If they collide with a tank, both entities are destroyed
    If they collide with a wall, they are deflected BUT will be destroyed after n bounces
    */
    PShape casing;  

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

        casing = shell_normal;
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