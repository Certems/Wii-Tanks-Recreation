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
        cStage.player_tanks.add(new tank_red(   new PVector(50,50,30), new PVector(0,0,0), new PVector(0,0,0)));
        cStage.ai_tanks.add(new tank_gray(      new PVector(250,50,30), new PVector(0,0,0), new PVector(0,0,0)));
        cStage.ai_tanks.add(new tank_gray(      new PVector(250,280,30), new PVector(0,0,0), new PVector(0,0,0)));
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
            cStage = createStagePreset(preset0, new PVector(12,12));}
        //...
    }
    stage createStagePreset(IntList cList, PVector dimTiles){
        stage nStage = new stage();
        ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
        for(int j=0; j<dimTiles.y; j++){
            tiles.add( new ArrayList<tile>() );
            for(int i=0; i<dimTiles.x; i++){
                int tileType = preset0.get(i +j*int(dimTiles.x));
                if(tileType == 0){
                    empty newEmpty = new empty();
                    tiles.get(j).add(newEmpty);}
                if(tileType == 1){
                    crate newCrate = new crate();
                    tiles.get(j).add(newCrate);}
                if(tileType == 2){
                    cork newCork = new cork();
                    tiles.get(j).add(newCork);}
                if(tileType == 3){
                    hole newHole = new hole();
                    tiles.get(j).add(newHole);}
                //...
            }
        }
        nStage.tiles = tiles;
        return nStage;
    }
}

/*
For presets;
0 = empty
1 = crate
2 = cork
3 = hole
*/
IntList preset0 = new IntList(
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 1, 1, 0, 0, 2, 0, 0, 1,
    1, 0, 0, 0, 0, 1, 0, 0, 2, 0, 0, 1,
    1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 3, 3, 3, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
);
//...