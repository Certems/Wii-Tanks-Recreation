class mine extends entity{
    /*
    Mine that explodes when a tank enters its proximity
    */
    ArrayList<Integer> whitelist = new ArrayList<Integer>();
    float activeRad  = 1.5;  //Relative to tWidth
    float explodeRad = 1.8;  //

    mine(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.5,0.5); //Relative to tWidth
    }
}