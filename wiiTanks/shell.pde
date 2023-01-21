class shell extends entity{
    //pass

    shell(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.2,0.2); //Relative to tWidth, bounding radius(???)
    }
}
class shell_normal extends shell{
    //pass

    shell_normal(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.2,0.2); //Relative to tWidth, bounding radius(???)
    }
}
class shell_rocket extends shell{
    //pass

    shell_rocket(PVector pos, PVector vel, PVector acc){
        super(pos, vel, acc);
        dim = new PVector(0.2,0.2); //Relative to tWidth, bounding radius(???)
    }
}