class manager{
    /*
    Controls triggering of events and flow of game

    GameStates;
    -----------
    0 = game screen
    1 = score screen
    ...
    */
    calculator cCalculator  = new calculator();
    graphics cGraphics      = new graphics();

    stage cStage;

    ArrayList<Integer> gameState = new ArrayList<>();   //Lists which menus to show, in which order

    manager(){
        initialiseManager();
    }

    void initialiseManager(){
        /*
        Initialised everything required
        e.g gameStates, 1st stage, ... 
        */
        gameState.add(0);
        loadStagePreset(0);
    }


    void displayGameState(){
        for(int i=0; i<gameState.size(); i++){
            cGraphics.displayState( gameState.get(i) );
        }
    }
    void calcGameState(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcState( gameState.get(i) );
        }
    }


    void loadStagePreset(int nPreset){
        if(nPreset == 0){
            cStage = createStagePreset(preset0, new PVector(8,8));}
        //...
    }
    stage createStagePreset(IntList cList, PVector dimTiles){
        stage nStage = new stage();
        ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
        for(int j=0; j<dimTiles.y; j++){
            tiles.add( new ArrayList<tile>() );
            for(int i=0; i<dimTiles.x; i++){
                tile newTile = new tile();
                if(preset0.get(i +j*int(dimTiles.x)) == 0){
                    //Add unique tille volume / terrain stuff here
                    //pass
                }
                //...
                tiles.get(j).add(newTile);
            }
        }
        nStage.tiles = tiles;
        return nStage;
    }
}

IntList preset0 = new IntList(
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0
);
//...