class mine extends entity{
    /*
    Mine that explodes when a tank enters its proximity
    */
    float activeRad = 2.0;  //Relative to tWidth

    mine(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.5,0.5); //Relative to tWidth
    }
}