class calculator{
    /*
    Performs any major calculations required, having components 
    required specificly parsed to it rather than generally having 
    access to everything
    */
    //pass
    
    calculator(){
        //pass
    }

    void calcState(int nState){
        /*
        Calculates all requisites for the given state number, nState
        */
        if(nState == 0){
            calcMap(cEnviro.cMap);}
        if(nState == 1){
            //pass
        }
        //...
    }


    void calcMap(map cMap){
        calcTanks(cMap);
        calcShells(cMap.shells);
        calcMines(cMap);
    }
    void calcTanks(map cMap){
        calcAiTanks(cMap);
        calcPlayerTanks(cMap);
    }
    void calcAiTanks(map cMap){
        for(int i=cMap.AI_tanks.size()-1; i>=0; i--){
            calcTankTerrainCollision(cMap.AI_tanks.get(i), i, cMap);
        }
        for(int i=cMap.AI_tanks.size()-1; i>=0; i--){
            cMap.AI_tanks.get(i).calcRotation();
            cMap.AI_tanks.get(i).calcPos();
            //...
        }
    }
    void calcPlayerTanks(map cMap){
        for(int i=cMap.player_tanks.size()-1; i>=0; i--){
            calcTankTerrainCollision(cMap.player_tanks.get(i), i, cMap);
        }
        for(int i=cMap.player_tanks.size()-1; i>=0; i--){
            cMap.player_tanks.get(i).calcRotation();
            cMap.player_tanks.get(i).calcPos();
            //...
        }
    }
    void calcShells(ArrayList<shell> shells){
        /*
        Calculates everything about shells 
        Moves them all first, then evaluates situation (so fair for all shells)
        */
        for(int i=0; i<shells.size(); i++){
            calcShellDynamics(shells.get(i));
        }
        for(int i=shells.size()-1; i>=0; i--){
            calcShellTerrainCollision(shells.get(i), i, cEnviro.cMap);
            //...
        }
    }
    void calcShellDynamics(shell cShell){
        cShell.calcDynamics();
    }
    boolean checkSquareCollision(PVector objPos, PVector objVel, PVector targetPos, float r){
        /*
        [Point] with [Box] collision
        Checks whether a point (objPos, e.g a shell position) is colliding with a box 
        of centre [targetPos] and width [r]
        e.g
        |- - -| X = the point  (usually pos of terrain)
        |  X  | | = length r   (usually tWidth)
        |- - -|
        */
        boolean withinX = (targetPos.x -r/2.0 <= objPos.x+objVel.x) && (objPos.x+objVel.x < targetPos.x +r/2.0);
        boolean withinY = (targetPos.y -r/2.0 <= objPos.y+objVel.y) && (objPos.y+objVel.y < targetPos.y +r/2.0);
        if(withinX && withinY){
            //If will be inside terrain NEXT frame, then will collide
            return true;
        }
        else{
            return false;
        }
    }
    void calcShellTerrainCollision(shell cShell, int shellInd, map cMap){
        /*
        Calculates if a shell should collide WITH TERRAIN
        If a shell does collide, it determines its fate

        1.Finds the tile the shell is over
        2.Considers the terrain in 0th layer of surrounding tiles
        3.Checks collision with that set of terrain
        */
        PVector shellTile = findHoveredTile(cShell.pos, cEnviro.cMap);
        if(shellTile != null){
            //Check 3x3 around the shell
            for(int j=-1; j<=1; j++){
                for(int i=0; i<=1; i++){
                    if(i!=j){   //Dont check the tile the shell is on
                        boolean validTile = checkValidTileCoord( new PVector(shellTile.x +i, shellTile.y +j), cMap );
                        if(validTile){  //If not outside bounds of map
                            boolean hasTerrain = cMap.tiles.get( int(shellTile.y +j) ).get( int(shellTile.x +i) ).terrainSet.size() > 0;
                            if(hasTerrain){ //If there exists terrain to be collided with
                                terrain cTerrain = cMap.tiles.get( int(shellTile.y +j) ).get( int(shellTile.x +i) ).terrainSet.get(0);
                                boolean hasCollided = checkSquareCollision(cShell.pos, cShell.vel, cTerrain.pos, cMap.tWidth);
                                if(hasCollided && cTerrain.shellCol){
                                    if(cShell.nReflect > 0){    //Can reflect more times => Reflect
                                        cShell.deflectShell(cTerrain, cMap.tWidth);}
                                    else{                       //Can no longer reflect => Destroy
                                        println("--REMOVED SHELL--");
                                        cMap.shells.remove(shellInd);}
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    void calcTankTerrainCollision(tank cTank, int tankInd, map cMap){
        /*
        Calculates if a tank should collide WITH TERRAIN
        If a tank does collide, then it should be stopped

        1.Finds the tile the tank is over
        2.Considers the terrain in 0th layer of surrounding tiles
        3.Checks collision with that set of terrain
        */
        PVector tankTile = findHoveredTile(cTank.pos, cEnviro.cMap);
        if(tankTile != null){
            //Check 3x3 around the shell
            for(int j=-1; j<=1; j++){
                for(int i=0; i<=1; i++){
                    if(i!=j){   //Dont check the tile the shell is on
                        boolean validTile = checkValidTileCoord( new PVector(tankTile.x +i, tankTile.y +j), cMap );
                        if(validTile){  //If not outside bounds of map
                            boolean hasTerrain = cMap.tiles.get( int(tankTile.y +j) ).get( int(tankTile.x +i) ).terrainSet.size() > 0;
                            if(hasTerrain){ //If there exists terrain to be collided with
                                terrain cTerrain = cMap.tiles.get( int(tankTile.y +j) ).get( int(tankTile.x +i) ).terrainSet.get(0);
                                boolean hasCollided = checkSquareCollision(cTank.pos, cTank.getVelocity(), cTerrain.pos, cMap.tWidth);
                                if(hasCollided && cTerrain.tankCol){
                                    //If collides, stop all motion
                                    cTank.speed = 0.0;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    boolean checkValidTileCoord(PVector coord, map cMap){
        /*
        Checks if given coord is on map
        */
        boolean withinX = (0 <= coord.x) && (coord.x < cMap.tiles.get(0).size());
        boolean withinY = (0 <= coord.y) && (coord.y < cMap.tiles.size());
        if(withinX && withinY){
            return true;}
        else{
            return false;}
    }
    PVector findHoveredTile(PVector pos, map cMap){
        /*
        Finds the tile coord (in 2D) below a given position (considering only 
        x and y components)
        */
        PVector proposedCoord = new PVector( floor(pos.x/cMap.tWidth), floor(pos.y/cMap.tWidth) );
        boolean xPropCorrect  = (0 <= proposedCoord.x) && (proposedCoord.x < cMap.tiles.get(0).size());
        boolean yPropCorrect  = (0 <= proposedCoord.y) && (proposedCoord.y < cMap.tiles.size());
        if(!xPropCorrect || !yPropCorrect){
            //If either of the components are NOT feasible, return null
            return null;
        }
        else{
            return proposedCoord;
        }
    }
    void calcMines(map cMap){
        for(int i=0; i<cMap.mines.size(); i++){
            calcMineTriggering(cMap.mines.get(i), cMap);
        }
    }
    void calcMineTriggering(mine cMine, map cMap){
        /*
        Considers whether a single mine is set off by any tank
        */
        for(int i=0; i<cMap.AI_tanks.size(); i++){
            cMine.calcTriggered(cMap.AI_tanks.get(i), cMap.tWidth);
        }
        for(int i=0; i<cMap.player_tanks.size(); i++){
            cMine.calcTriggered(cMap.player_tanks.get(i), cMap.tWidth);
        }
    }


    void calcKeyPressed(int nState){
        if(nState == 0){
            calcKeyPressed_Map();}
        if(nState == 1){
            //pass
        }
        //...
    }
    void calcKeyReleased(int nState){
        if(nState == 0){
            calcKeyReleased_Map();}
        if(nState == 1){
            //pass
        }
        //...
    }
    void calcMousePressed(int nState){
        if(nState == 0){
            calcMousePressed_Map();}
        if(nState == 1){
            //pass
        }
        //...
    }
    void calcMouseReleased(int nState){
        if(nState == 0){
            calcMouseReleased_Map();}
        if(nState == 1){
            //pass
        }
        //...
    }


    //Map keys
    void calcKeyPressed_Map(){
        if(key == '1'){
            println("-- 1 Pressed --");
            cEnviro.cMap.AI_tanks.get(0).fireShell(cEnviro.cMap);
        }
        if(key == '2'){
            println("-- 2 Pressed --");
            cEnviro.cMap.AI_tanks.get(0).layMine(cEnviro.cMap);
        }
        if(key == 'w'){
            cEnviro.cMap.player_tanks.get(0).speed = cEnviro.cMap.player_tanks.get(0).maxSpeed;}
        if(key == 'a'){
            cEnviro.cMap.player_tanks.get(0).tCCW = true;}
        if(key == 's'){
            cEnviro.cMap.player_tanks.get(0).speed = cEnviro.cMap.player_tanks.get(0).minSpeed;}
        if(key == 'd'){
            cEnviro.cMap.player_tanks.get(0).tCW = true;}
        if(key == 'q'){
            cEnviro.cMap.player_tanks.get(0).layMine(cEnviro.cMap);}
        if(key == 'e'){
            cEnviro.cMap.player_tanks.get(0).fireShell(cEnviro.cMap);}
        //...
    }
    void calcKeyReleased_Map(){
        if(key == '1'){
            //pass
        }
        if(key == 'w'){
            cEnviro.cMap.player_tanks.get(0).speed = 0.0;}
        if(key == 'a'){
            cEnviro.cMap.player_tanks.get(0).tCCW = false;}
        if(key == 's'){
            cEnviro.cMap.player_tanks.get(0).speed = 0.0;}
        if(key == 'd'){
            cEnviro.cMap.player_tanks.get(0).tCW = false;}
    }
    void calcMousePressed_Map(){
        if(mouseButton == LEFT){
            //pass
        }
        else{
            //pass
        }
    }
    void calcMouseReleased_Map(){
        if(mouseButton == LEFT){
            //pass
        }
        else{
            //pass
        }
    }
}