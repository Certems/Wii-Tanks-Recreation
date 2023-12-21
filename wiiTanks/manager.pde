class manager{
    /*
    Controls triggering of events and flow of game

    GameStates;
    -----------
    0 = game screen
    1 = banners
    2 = results menu
    3 = transition menu
    ...
    */
    calculator cCalculator  = new calculator();
    graphics cGraphics      = new graphics();

    stage cStage;
    info cInfo = new info();

    ArrayList<Integer> gameState = new ArrayList<Integer>();   //Lists which menus to show, in which order
    ArrayList<coordinator> coordEvents = new ArrayList<coordinator>();  //Stores coordination instances (timed sequences of events) to be resolved

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
        gameState.add(1);
        loadStagePreset(1);
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
    void resolveCoordinator(){
        for(int i=coordEvents.size()-1; i>=0; i--){
            if(!coordEvents.get(i).eventComplete){
                coordEvents.get(i).progressEvent();}
            else{
                coordEvents.remove(i);}
        }
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


    tile generate_tile(int tileType){
        /*
        Takes a specified tile type, and creates an object corresponding to the 
        given type
        #####
        ## THIS IS SUCH A BAD WAY OF DOING THIS, HAVE SOME SORT OF RETURN TYPE STATIC FUNC WITHIN EACH CLASS --> DEFO REDO
        #####
        */
        if(tileType == 0){
            empty newEmpty = new empty();
            return newEmpty;}
        else if(tileType == 1){
            crate newCrate = new crate();
            return newCrate;}
        else if(tileType == 2){
            cork newCork = new cork();
            return newCork;}
        else if(tileType == 3){
            hole newHole = new hole();
            return newHole;}
        else{
            return null;}
        //...
    }
    tank generate_tank(int tankType, PVector tPos){
        /*
        Takes a specified tank type, and creates an object corresponding to the 
        given type.
        It also ensures the tank position is fixed to an initial point too.

        Player tanks are -ve
        AI tanks are +ve

        #####
        ## THIS IS SUCH A BAD WAY OF DOING THIS, HAVE SOME SORT OF RETURN TYPE STATIC FUNC WITHIN EACH CLASS --> DEFO REDO
        #####
        */
        if(tankType == -1){
            tank_red newTank = new tank_red( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 1){
            tank_brown newTank = new tank_brown( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 2){
            tank_gray newTank = new tank_gray( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 3){
            tank_teal newTank = new tank_teal( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 4){
            tank_yellow newTank = new tank_yellow( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 5){
            tank_pink newTank = new tank_pink( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 6){
            tank_green newTank = new tank_green( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 7){
            tank_purple newTank = new tank_purple( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 8){
            tank_white newTank = new tank_white( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else if(tankType == 9){
            tank_black newTank = new tank_black( new PVector(tPos.x, tPos.y, tPos.z), new PVector(0,0,0), new PVector(0,0,0) );
            return newTank;}
        else{
            return null;}
        //...
    }
    void loadStagePreset(int nPreset){
        if(nPreset == 1){
            cStage = createStagePreset(preset1_tiles, preset1_tanks, new PVector(23,12));}
        if(nPreset == 2){
            cStage = createStagePreset(preset2_tiles, preset2_tanks, new PVector(23,12));}
        //...
    }
    stage createStagePreset(IntList tileList, IntList tankList, PVector dimTiles){
        stage nStage = new stage();
        ArrayList<ArrayList<tile>> tiles = new ArrayList<ArrayList<tile>>();
        for(int j=0; j<dimTiles.y; j++){
            tiles.add( new ArrayList<tile>() );
            for(int i=0; i<dimTiles.x; i++){
                int tileType = tileList.get(i +j*int(dimTiles.x));
                tile newTile = generate_tile(tileType);
                tiles.get(j).add(newTile);
            }
        }
        nStage.tiles = tiles;

        ArrayList<tank> playerTanks = new ArrayList<tank>();
        ArrayList<tank> aiTanks     = new ArrayList<tank>();
        for(int j=0; j<dimTiles.y; j++){
            for(int i=0; i<dimTiles.x; i++){
                int tankType = tankList.get(i +j*int(dimTiles.x));
                PVector tPos = new PVector((i+0.5)*nStage.tWidth, (j+0.5)*nStage.tWidth, nStage.tWidth);
                tank newTank = generate_tank(tankType, tPos);
                if(newTank != null){
                    if(tankType < 0){
                        playerTanks.add(newTank);}
                    else{
                        aiTanks.add(newTank);}
                }
            }
        }
        nStage.player_tanks = playerTanks;
        nStage.ai_tanks     = aiTanks;

        return nStage;
    }
}