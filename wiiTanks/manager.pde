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

    ArrayList<Integer> gameState = new ArrayList<Integer>();   //Lists which menus to show, in which order

    manager(){
        loadAll();
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
        cStage.ai_tanks.add(new tank_blue(      new PVector(250,50,30), new PVector(0,0,0), new PVector(0,0,0)));
        cStage.ai_tanks.add(new tank_blue(      new PVector(250,280,30), new PVector(0,0,0), new PVector(0,0,0)));
    }


    void displayGameState(){
        for(int i=0; i<gameState.size(); i++){
            cGraphics.displayState( gameState.get(i) );
        }
    }
    void calcGameState(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcState( gameState.get(i) );}
    }
    void calcControls_keyPressed(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcKeyPressed( gameState.get(i), cStage );}
    }
    void calcControls_keyReleased(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcKeyReleased( gameState.get(i), cStage );}
    }
    void calcControls_mousePressed(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcMousePressed( gameState.get(i),cStage );}
    }
    void calcControls_mouseReleased(){
        for(int i=0; i<gameState.size(); i++){
            cCalculator.calcMouseReleased( gameState.get(i),cStage );}
    }


    void loadStagePreset(int nPreset){
        if(nPreset == 0){
            cStage = createStagePreset(preset0_tiles, preset0_tanks, new PVector(23,12));}
        //...
    }
    stage createStagePreset(IntList tileList, IntList tankList, PVector dimTiles){
        stage nStage = new stage();
        ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
        for(int j=0; j<dimTiles.y; j++){
            tiles.add( new ArrayList<tile>() );
            for(int i=0; i<dimTiles.x; i++){
                int tileType = tileList.get(i +j*int(dimTiles.x));
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

        //####
        //## DO AGAIN FOR TANKS
        //####
        return nStage;
    }
}