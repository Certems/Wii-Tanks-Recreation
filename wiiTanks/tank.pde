class tank extends entity{
    int ID = floor(random(10000000, 99999999)); //Unique identifier for each tank -> bullets have associated IDs for tanks

    float rChassis = 0.0;   //Rotation of chassis
    float rTurret  = 0.0;   //Rotation of turret

    tank(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.8, 0.8);    //Relative to tWidth, bounding box size
    }
}

class tank_red extends tank{
    //pass

    tank_red(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.8, 0.8);    //Relative to tWidth, bounding box size
    }
}
class tank_gray extends tank{
    //pass

    tank_gray(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.8, 0.8);    //Relative to tWidth, bounding box size
    }
}