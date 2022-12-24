class map{
    /*
    Holds details about the round currently being played, such 
    as map size, object dimensions, object locations, etc
    */
    ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
    ArrayList<tank> AI_tanks     = new ArrayList<tank>();   //Tanks controlled by AI
    ArrayList<tank> player_tanks = new ArrayList<tank>();   //Tanks controlled by ith player
    
    ArrayList<shell> shells = new ArrayList<shell>();   //Shells in motion
    ArrayList<mine> mines   = new ArrayList<mine>();    //Mines on map

    PVector startPos = new PVector(100,100,0);   //Indicates where the tile array should start being drawn from
    float tWidth = 30.0;

    map(){
        //pass
    }

    //pass
}