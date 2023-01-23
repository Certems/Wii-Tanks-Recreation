class tile{
    /*
    Holds information about terrain on this tile
    */
    String name;
    boolean tankCollision;      //Tanks cannot move through this
    boolean shellCollision;     //Shells cannot move through this
    boolean destructable;       //Explosives (mines) can destroy this

    tile(){
        //pass
    }
}

class empty extends tile{
    //pass

    empty(){
        name = "tile_empty";
        tankCollision  = false;
        shellCollision = false;
        destructable   = false;
    }
}
class hole extends tile{
    //pass

    hole(){
        name = "tile_hole";
        tankCollision  = true;
        shellCollision = false;
        destructable   = false;
    }
}
class cork extends tile{
    //pass

    cork(){
        name = "tile_cork";
        tankCollision  = true;
        shellCollision = true;
        destructable   = true;
    }
}
class crate extends tile{
    //pass

    crate(){
        name = "tile_crate";
        tankCollision  = true;
        shellCollision = true;
        destructable   = false;
    }
}