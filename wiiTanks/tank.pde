class tank{
    /*
    Overarching structure for AI and player controlled entities.
    Tanks can move, fire shells, lay mines and collide with terrain.
    */
    int ID = floor(random(10000000, 99999999)); //Unique identifying 8 digit sequence
    
    PVector pos;
    float speed = 0.0;
    float maxSpeed; //Thrusting speed
    float minSpeed; //Reversing speed
    float rotSpeed; //Rotation speed for chassis
    //**NOTE; Turret has no rotation speed limit, instantaneous
    boolean tCW  = false;
    boolean tCCW = false;
    
    float chassisRot;
    float turretRot;    //0-2*PI

    float sRel = 1.0;   //Scale factor for model size, relative to tWidth
    float turretDisp = 0.3; //SF offset of turret (in height), from tank centre point

    PVector turret;     //## IN FINAL VERSION, REPLACED WITH MODELS NOT COLOURS
    PVector chassis;    //##

    tank(PVector initPos, float initChassisRot, float initTurretRot){
        pos = initPos;
        chassisRot = initChassisRot;
        turretRot  = initTurretRot;
    }

    void calcPos(){
        PVector dir = new PVector(cos(chassisRot), sin(chassisRot), 0);
        pos.x += speed*dir.x;
        pos.y += speed*dir.y;
    }
    PVector getVelocity(){
        return new PVector(speed*cos(chassisRot), speed*sin(chassisRot), 0);
    }
    void calcRotation(){
        if(tCCW){
            chassisRot += rotSpeed;}
        if(tCW){
            chassisRot -= rotSpeed;}
    }
    void fireShell(map cMap){
        /*
        Creates a moving shell in front of the tank's turret
        Adds the shell to the 'shells' list in the given map

        Different types of tanks fire different shells, which is expressed 
        by overriding 'fireShell' with different params. e.g fast for rocket 
        shell, slow for normal shell, etc
        */
    }
    void layMine(map cMap){
        /*
        Creates a mine beneath the tank
        Sets the tank as white-listed
        Adds the mine to the 'mines' list in the given map
        */
        mine newMine = new mine( new PVector(pos.x, pos.y, pos.z -cMap.tWidth*sRel/2.0) );
        newMine.whiteList.add(ID);
        cMap.mines.add(newMine);
    }
    
}

class red_tank extends tank{
    //pass

    red_tank(PVector pos, float chassisRot, float turretRot){
        super(pos, chassisRot, turretRot);
        turret  = new PVector(255,60,60);
        chassis = new PVector(255,120,120);

        maxSpeed = 3.0;
        minSpeed = -maxSpeed;
        rotSpeed = (2.0*PI/60.0)/2.0;
    }

    @Override
    void fireShell(map cMap){
        /*
        Creates a moving shell in front of the tank's turret
        Adds the shell to the 'shells' list in the given map
        */
        float shellSpeed = 5.0;
        PVector turretDir = new PVector(cos(turretRot), sin(turretRot), 0);
        PVector shellPos  = new PVector(pos.x +cMap.tWidth*sRel*turretDir.x, pos.y +cMap.tWidth*sRel*turretDir.y, pos.z);
        PVector shellVel  = new PVector(shellSpeed*turretDir.x, shellSpeed*turretDir.y, 0);
        shell newShell = new shell(2, shellPos, shellVel, new PVector(0,0,0));
        cMap.shells.add(newShell);
    }
}
class blue_tank extends tank{
    //pass

    blue_tank(PVector pos, float chassisRot, float turretRot){
        super(pos, chassisRot, turretRot);
        turret  = new PVector(60,60,255);
        chassis = new PVector(255,120,120);

        maxSpeed = 3.0;
        minSpeed = -maxSpeed;
        rotSpeed = (2.0*PI/60.0)/2.0;
    }

    @Override
    void fireShell(map cMap){
        /*
        Creates a moving shell in front of the tank's turret
        Adds the shell to the 'shells' list in the given map
        */
        float shellSpeed = 5.0;
        PVector turretDir = new PVector(cos(turretRot), sin(turretRot), 0);
        PVector shellPos  = new PVector(pos.x +cMap.tWidth*sRel*turretDir.x, pos.y +cMap.tWidth*sRel*turretDir.y, pos.z);
        PVector shellVel  = new PVector(shellSpeed*turretDir.x, shellSpeed*turretDir.y, 0);
        shell newShell = new shell(2, shellPos, shellVel, new PVector(0,0,0));
        cMap.shells.add(newShell);
    }
}
class gray_tank extends tank{
    //pass

    gray_tank(PVector pos, float chassisRot, float turretRot){
        super(pos, chassisRot, turretRot);
        turret  = new PVector(80,80,80);
        chassis = new PVector(160,160,160);

        maxSpeed = 3.0;
        minSpeed = -maxSpeed;
        rotSpeed = (2.0*PI/60.0)/2.0;
    }

    @Override
    void fireShell(map cMap){
        /*
        Creates a moving shell in front of the tank's turret
        Adds the shell to the 'shells' list in the given map
        */
        float shellSpeed = 5.0;
        PVector turretDir = new PVector(cos(turretRot), sin(turretRot), 0);
        PVector shellPos  = new PVector(pos.x +cMap.tWidth*sRel*turretDir.x, pos.y +cMap.tWidth*sRel*turretDir.y, pos.z);
        PVector shellVel  = new PVector(shellSpeed*turretDir.x, shellSpeed*turretDir.y, 0);
        shell newShell = new shell(2, shellPos, shellVel, new PVector(0,0,0));
        cMap.shells.add(newShell);
    }
}
//...