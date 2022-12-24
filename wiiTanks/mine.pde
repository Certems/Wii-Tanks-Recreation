class mine{
    /*
    .Can be placed on the map beneath a given tank
    .The are activated when another (non-white listed) tank comes within a certain
     radius of them, where they then explode X ticks later
    .The tank that places a mine is automatically white-listed (for multiple player 
     controlled tanks, you may have it be the case that all 'friends' are white-listed 
     too)
    .Mines can destroy certain terrain, such as cork
    */
    PVector pos;

    boolean triggered = false;
    float aRadius = 1.2;   //Activation radius, SF relative to tile
    ArrayList<Integer> whiteList = new ArrayList<Integer>();    //Which tank IDs cannot trigger the mine

    mine(PVector initPos){
        pos = initPos;
    }

    void calcTriggered(tank cTank, float tWidth){
        /*
        Checks if given tank is white-listed
        If not, if its close enough trigger the mine
        */
        boolean isListed = false;
        for(int i=0; i<whiteList.size(); i++){
            if(cTank.ID == whiteList.get(i)){
                //If a match...
                isListed = true;
                break;
            }
        }
        if(!isListed){
            //Not white-listed, check if close enough...
            float dist = vecDist(pos, cTank.pos);
            if(dist < aRadius*tWidth){
                //If close enough, then trigger#
                triggered = true;
            }
        }
    }
}