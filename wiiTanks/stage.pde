class stage{
    /*
    Maps which rounds are played on
    Stores information about tiles and entities
    */
    ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
    ArrayList<tank> player_tanks = new ArrayList<tank>();   //Tanks controlled by ith players
    ArrayList<tank> ai_tanks     = new ArrayList<tank>();   //Ai controlled tanks
    ArrayList<shell> shells      = new ArrayList<shell>();
    ArrayList<mine> mines        = new ArrayList<mine>();

    PVector startPos = new PVector(width/3.0,height/3.0,0);  //Where tiles start being drawn from (top-left corner)
    float tWidth = 30.0; //Width of a tile

    stage(){
        //pass
    }
}