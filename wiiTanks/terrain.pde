class terrain{
    /*
    Objects that can be placed on the map. Each can interact in unique 
    ways with the tanks, such as being destroyed, reflecting shells, 
    colliding with tanks, etc

    When tanks are stored in the map, they are listed at a given XY coordinate.
    The list specifies the order in which they appear in a 'stack'/'tower' at 
    that coord
    */
    //## HAVE MODEL HERE ##
    float hRatio;   //Height ratio, sets height as a ratio of width

    PVector pos;
    PShape geometry;

    boolean shellCol;  //e.g shells off walls
    boolean tankCol;   //e.g tanks and holes

    terrain(PVector initPos){
        pos = initPos;
        shellCol = false;
        tankCol  = false;
    }

    //pass
}


class crate extends terrain{
    //pass

    crate(PVector pos){
        super(pos);
        hRatio = 1.0;
        geometry = terrain_wood;
        shellCol = true;
        tankCol  = true;
    }

    //pass
}
class cork extends terrain{
    //pass

    cork(PVector pos){
        super(pos);
        hRatio = 1.5;
        geometry = terrain_cork;
        shellCol = true;
        tankCol  = true;
    }

    //pass
}
class hole extends terrain{
    //pass

    hole(PVector pos){
        super(pos);
        hRatio = 0.0;
        //## HAVE MODEL HERE ##
        shellCol = false;
        tankCol  = true;
    }

    //pass
}
class shield extends terrain{
    //pass

    shield(PVector pos){
        super(pos);
        hRatio = 0.0;
        //## HAVE MODEL HERE ##
        shellCol = true;
        tankCol  = false;
    }

    //pass
}
//...