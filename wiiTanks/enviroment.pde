class environment{
    /*
    Manages the state of the game as a whole and what the play should be shown 
    and calculated

    States;
    0 = map screen
    1 = round stats
    ...

    Terrain key;
    0 = nothing
    1 = crate
    2 = cork
    */
    graphics cGraphics = new graphics();
    calculator cCalculator = new calculator();

    ArrayList<Integer> states = new ArrayList<Integer>();

    map cMap = new map();

    environment(){
        states.add(0);  //Initialise with map screen
        setNewMap_preset(0);
    }

    void displayRequired(){
        for(int i=0; i<states.size(); i++){
            cGraphics.displayState( states.get(i) );
        }
    }
    void calcRequired(){
        for(int i=0; i<states.size(); i++){
            cCalculator.calcState( states.get(i) );
        }
    }
    void keyPressedRequired(){
        for(int i=0; i<states.size(); i++){
            cCalculator.calcKeyPressed( states.get(i) );
        }
    }
    void keyReleasedRequired(){
        for(int i=0; i<states.size(); i++){
            cCalculator.calcKeyReleased( states.get(i) );
        }
    }
    void mousePressedRequired(){
        for(int i=0; i<states.size(); i++){
            cCalculator.calcMousePressed( states.get(i) );
        }
    }
    void mouseReleasedRequired(){
        for(int i=0; i<states.size(); i++){
            cCalculator.calcMouseReleased( states.get(i) );
        }
    }


    void setNewMap_random(){
        /*
        Creates a random map and makes it the current map
        */
        //pass
    }
    void setNewMap_preset(int preset){
        /*
        Creates a map preset and makes it the current map
        1. Creates a new map
        2. Makes current map the new map
        */
        map nMap = new map();
        nMap = generateMap_preset(preset);
        nMap = generateMap_tanks_AI_preset(nMap, preset);
        nMap = generateMap_tanks_player_preset(nMap, preset);
        cMap = nMap;
    }
    map generateMap_tanks_AI_preset(map nMap, int preset){
        /*
        Generates AI tanks required for this map preset
        */
        nMap.AI_tanks.clear();
        if(preset == 0){
            gray_tank tank0 = new gray_tank( new PVector(270,300, 30), PI/8.0, PI/8.0 );
            gray_tank tank1 = new gray_tank( new PVector(450,280, 30), 0.0, 0.0 );
            gray_tank tank2 = new gray_tank( new PVector(250,440, 30), 0.0, 0.0 );
            nMap.AI_tanks.add(tank0);nMap.AI_tanks.add(tank1);nMap.AI_tanks.add(tank2);
        }
        return nMap;
    }
    map generateMap_tanks_player_preset(map nMap, int preset){
        /*
        Generates player tanks required for this map preset
        */
        nMap.player_tanks.clear();
        if(preset == 0){
            red_tank tank0  = new red_tank( new PVector(150,150, 30), PI/8.0, PI/8.0 );
            blue_tank tank1 = new blue_tank( new PVector(150,450, 30), PI/8.0, PI/8.0 );
            nMap.player_tanks.add(tank0);nMap.player_tanks.add(tank1);
        }
        return nMap;
    }
    map generateMap_preset(int preset){
        map nMap = new map();
        if(preset == 0){
            nMap = generateMap_empty(nMap, new PVector(20,20));
            nMap = generateMap_terrain_layer(nMap, pre0_layer0);
        }
        return nMap;
    }
    map generateMap_empty(map nMap, PVector dim){
        /*
        Fills a map with [dim.x, dim.y] tiles and nothing else
        */
        nMap.tiles.clear();
        for(int j=0; j<int(dim.y); j++){
            nMap.tiles.add( new ArrayList<tile>() );
            for(int i=0; i<int(dim.x); i++){
                nMap.tiles.get(j).add( new tile() );
            }
        }
        return nMap;
    }
    map generateMap_terrain_layer(map nMap, IntList terrainPieces){
        /*
        Generates a layer of terrain

        NOTE; Assumes the terrainPieces will match the size of the map given
            Will give errors and crash if does not.
            Additionally, notice the Z position is set to 0 as this is ignored
            in all collision calculation, just considers XY comp of 0th layer
        */
        int cols = nMap.tiles.size();
        int rows = nMap.tiles.get(0).size();
        for(int j=0; j<cols; j++){
            for(int i=0; i<rows; i++){
                PVector cPos = new PVector(i*nMap.tWidth, j*nMap.tWidth, 0);   //Current pos
                if(terrainPieces.get(i +j*cols) == 1){
                    nMap.tiles.get(j).get(i).terrainSet.add( new crate( new PVector(cPos.x, cPos.y, cPos.z) ) );}
                if(terrainPieces.get(i +j*cols) == 2){
                    nMap.tiles.get(j).get(i).terrainSet.add( new cork( new PVector(cPos.x, cPos.y, cPos.z) ) );}
            }
        }
        return nMap;
    }
}

IntList pre0_layer0 = new IntList
(1, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 2, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

IntList pre0_layer1 = new IntList
(1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 1, 1, 0, 0, 0, 0,
 0, 0, 0, 0, 1, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 1, 0, 0, 0, 0, 0, 0, 1, 0, 0);