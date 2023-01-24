class calculator{
    /*
    Performs all major calculations within the game
    e.g collision
    */
    //pass

    calculator(){
        //pass
    }

    void calcState(int state){
        if(state == 0){
            calcInMatch(cManager.cStage);
        }
        //...
    }
    void calcKeyPressed(int state, stage cStage){
        if(state == 0){
            //Player Tank controls
            //---------------------
            if(key == 'w'){
                //P1 accelerate up (+ve)
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).accUp    = true;}
            }
            if(key == 's'){
                //P1 accelerate down (-ve)
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).accDwn   = true;}
            }
            if(key == 'a'){
                //P1 turn chassis CCW
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).tCCW     = true;}
            }
            if(key == 'd'){
                //P1 turn chassis CW
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).tCW      = true;}
            }
            if(key == 'q'){
                //P1 fire shell
                if(cStage.player_tanks.size()>0){
                    println("--Firing Shell--");
                    cStage.player_tanks.get(0).tryFireShell(cStage, this);}
            }
            if(key == 'e'){
                //P1 lay mine
                if(cStage.player_tanks.size()>0){
                    println("--Laying Mine--");
                    cStage.player_tanks.get(0).layMine(cStage);}
            }

            //...
            //-----
        }
        //...
    }
    void calcKeyReleased(int state, stage cStage){
        if(state == 0){
            //Player Tank controls
            //---------------------
            if(key == 'w'){
                //P1 accelerate up (+ve)
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).accUp    = false;}
            }
            if(key == 's'){
                //P1 accelerate down (-ve)
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).accDwn   = false;}
            }
            if(key == 'a'){
                //P1 turn chassis CCW
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).tCCW     = false;}
            }
            if(key == 'd'){
                //P1 turn chassis CW
                if(cStage.player_tanks.size()>0){
                    cStage.player_tanks.get(0).tCW      = false;}
            }

            //...
            //-----
        }
        //...
    }
    void calcMousePressed(int state, stage cStage){
        if(state == 0){
            //####
            //## SPECIFY HERE WHAT MOUSE PR DOES IN GAMESTATE X
            //####
        }
        //...
    }
    void calcMouseReleased(int state, stage cStage){
        if(state == 0){
            //####
            //## SPECIFY HERE WHAT MOUSE RE DOES IN GAMESTATE X
            //####
        }
        //...
    }


    void calcInMatch(stage cStage){
        calcTanks(cStage);
        calcShells(cStage);
        calcCollisionCases(cStage);
    }
    void calcTanks(stage cStage){
        /*
        Performs calculations for tanks
        e.g dynamics, ...
        */
        calcPlayerTanks(cStage);
        calcAiTanks(cStage);
    }
    void calcPlayerTanks(stage cStage){
        for(int i=0; i<cStage.player_tanks.size(); i++){
            cStage.player_tanks.get(i).calcDynamics();
        }
    }
    void calcAiTanks(stage cStage){
        for(int i=0; i<cStage.ai_tanks.size(); i++){
            cStage.ai_tanks.get(i).calcDynamics();
        }
    }
    void calcShells(stage cStage){
        for(int i=0; i<cStage.shells.size(); i++){
            cStage.shells.get(i).calcDynamics();
        }
    }


    boolean checkBoxBoxCollision(PVector p1, PVector d1, PVector p2, PVector d2, stage cStage){
        /*
        Checks if 2 boxes, specified each by a centre point and dimension, are 
        colliding with eachother
        NOTE; dimensions (d1, d2) here are in pixels e.g have already been specified in terms of number of tWidths when parsed in
        p = pos
        d = dimension

        ########
        #####################################################################
        ## NEED TO CHANGE TO ROTATING RECTANGLE COLLISION, NOT JUST STATIC ##
        #####################################################################
        ########
        */
        boolean withinX = abs(p1.x-p2.x) < (cStage.tWidth*d1.x/2.0) + (cStage.tWidth*d2.x/2.0);
        boolean withinY = abs(p1.y-p2.y) < (cStage.tWidth*d1.y/2.0) + (cStage.tWidth*d2.y/2.0);
        if(withinX && withinY){
            return true;}
        else{
            return false;}
    }
    boolean checkCircleBoxCollision(){
        /*
        Checks if a circle and box overlap by;
        If circle above box, check y dist topside
        vice versa for below
        similarly for left and right

        OR two bounding circle, reduce options
        then check for corners
        */
        return false;
    }
    PVector findTileCoord(PVector point, stage cStage){
        /*
        Finds the coordinate of the tile located under the given point
        */
        return new PVector( floor(point.x /cStage.tWidth), floor(point.y /cStage.tWidth) );
    }
    ArrayList<PVector> searchNearby_walls(PVector iCoord, int n, int mode, stage cStage){
        /*
        Looks for walls in and n x n (n usually being 3) radius around a given initial coordinate (of a tile, iCoord)
        for tiles that are;
        --> mode 0; tank collideable
        --> mode 1; shell collideable
        Returns a list of coordinates where these cases are true

        1. Look in n x n
        2. If not out of bounds
        3. Check specific rules for mode
        4. If both, mark it
        5. Return marked
        */
        ArrayList<PVector> marked = new ArrayList<PVector>();
        //1
        for(int j=-floor(float(n)/2.0); j<ceil(float(n)/2.0); j++){
            for(int i=-floor(float(n)/2.0); i<ceil(float(n)/2.0); i++){
                PVector cCoord = new PVector(iCoord.x +i, iCoord.y +j);
                //2
                boolean inBounds = ( (0<=int(cCoord.x))&&(int(cCoord.x)<cStage.tiles.get(0).size()) ) && ( (0<=int(cCoord.y))&&(int(cCoord.y)<cStage.tiles.size()) );
                if(inBounds){
                    //3
                    boolean valid = false;
                    if(mode == 0){
                        if(cStage.tiles.get( int(cCoord.y) ).get( int(cCoord.x) ).tankCollision){
                            valid = true;}}
                    if(mode == 1){
                        if(cStage.tiles.get( int(cCoord.y) ).get( int(cCoord.x) ).shellCollision){
                            valid = true;}}
                    //...
                    if(valid){
                        //4
                        marked.add( new PVector(cCoord.x, cCoord.y) );
                    }
                }
            }
        }
        return marked;
    }
    void moveEntityOutBoxCollision(entity cEntity, PVector p, PVector d, stage cStage){
        /*
        Moves an entity backwards out of a box
        Centre = p
        Dim = d (in terms of # tWidths NOT pixels)
        Then sets velocity of entity to 0
        */
        float scale = 0.20;         //**Resolution of backwards moving (relative to frames)
        int countermeasure = 0;     //**Safety against infinite loops
        PVector nVel = new PVector(scale*cEntity.vel.x, scale*cEntity.vel.y, scale*cEntity.vel.z);   //New velocity
        while(countermeasure < 300){
            cEntity.pos.x -= nVel.x;
            cEntity.pos.y -= nVel.y;
            cEntity.pos.z -= nVel.z;
            boolean stillColliding = checkBoxBoxCollision(cEntity.pos, cEntity.dim, p, d, cStage);
            if(!stillColliding){
                cEntity.vel = new PVector(0,0,0);
                break;}
            countermeasure++;
        }
    }
    void calcCollisionCases(stage cStage){
        /*
        Checks all collision cases for the main game
        */
        checkCollision_tankWall(cStage);
        checkCollision_tankTank(cStage);
        checkCollision_shellWall(cStage);
        checkCollision_shellTank(cStage);
        checkCollision_mineTank(cStage);
        checkCollision_mineShell(cStage);
    }
    void deflectShellOffWall(shell cShell, PVector p, PVector d, stage cStage){
        /*
        Move out of wall
        Find which wall the shell will collide with
        Deflect its velocity accordingly
        */
        //pass
    }
    void checkCollision_tankWall(stage cStage){
        /*
        Looks through all tanks, checks for nearby walls that they could 
        collide with
        If they would collide, then move them out of the wall

        1. Look through all tanks
        2. Checks walls around tile tank is over
        3. If any that could collide with tank, check them
        4. If a collision does occur, move tank backwards out of wall
        */

        // PLAYER VERSION
        //----------------
        //1
        for(int i=0; i<cStage.player_tanks.size(); i++){
            //2
            PVector tankTileCoord = findTileCoord(cStage.player_tanks.get(i).pos, cStage);
            ArrayList<PVector> possibleWalls = searchNearby_walls(tankTileCoord, 3, 0, cStage);
            //3
            for(int j=0; j<possibleWalls.size(); j++){
                PVector wallPos = new PVector(possibleWalls.get(j).x*cStage.tWidth, possibleWalls.get(j).y*cStage.tWidth);
                PVector wallDim = new PVector(1.0, 1.0);
                boolean isColliding = checkBoxBoxCollision(cStage.player_tanks.get(i).pos, cStage.player_tanks.get(i).dim, wallPos, wallDim, cStage);
                if(isColliding){
                    //4
                    moveEntityOutBoxCollision(cStage.player_tanks.get(i), wallPos, wallDim, cStage);
                }
            }
        }

        // AI VERSION --> COPIED OVER
        //----------------------------
        for(int i=0; i<cStage.ai_tanks.size(); i++){
            //2
            PVector tankTileCoord = findTileCoord(cStage.ai_tanks.get(i).pos, cStage);
            ArrayList<PVector> possibleWalls = searchNearby_walls(tankTileCoord, 3, 0, cStage);
            //3
            for(int j=0; j<possibleWalls.size(); j++){
                PVector wallPos = new PVector(possibleWalls.get(j).x*cStage.tWidth, possibleWalls.get(j).y*cStage.tWidth);
                PVector wallDim = new PVector(cStage.tWidth, cStage.tWidth);
                boolean isColliding = checkBoxBoxCollision(cStage.ai_tanks.get(i).pos, cStage.ai_tanks.get(i).dim, wallPos, wallDim, cStage);
                if(isColliding){
                    //4
                    moveEntityOutBoxCollision(cStage.ai_tanks.get(i), wallPos, wallDim, cStage);
                }
            }
        }
    }
    void checkCollision_tankTank(stage cStage){
        for(int i=0; i<cStage.player_tanks.size(); i++){
            for(int p=0; p<cStage.player_tanks.size(); p++){
                if(i != p){    
                    boolean isColliding = checkBoxBoxCollision(cStage.player_tanks.get(i).pos, cStage.player_tanks.get(i).dim, cStage.player_tanks.get(p).pos, cStage.player_tanks.get(p).dim, cStage);
                    if(isColliding){
                        moveEntityOutBoxCollision(cStage.player_tanks.get(i), cStage.player_tanks.get(p).pos, cStage.player_tanks.get(p).dim, cStage);}
                }
            }
            for(int p=0; p<cStage.ai_tanks.size(); p++){   
                boolean isColliding = checkBoxBoxCollision(cStage.player_tanks.get(i).pos, cStage.player_tanks.get(i).dim, cStage.ai_tanks.get(p).pos, cStage.ai_tanks.get(p).dim, cStage);
                if(isColliding){
                    moveEntityOutBoxCollision(cStage.player_tanks.get(i), cStage.ai_tanks.get(p).pos, cStage.ai_tanks.get(p).dim, cStage);}
            }
        }

        // AI VERSION --> COPIED OVER BUT JUST FOR OTHER AI (ai vs player check already done)
        //----------------------------
        for(int i=0; i<cStage.ai_tanks.size(); i++){
            for(int p=0; p<cStage.ai_tanks.size(); p++){
                if(i != p){
                    boolean isColliding = checkBoxBoxCollision(cStage.ai_tanks.get(i).pos, cStage.ai_tanks.get(i).dim, cStage.ai_tanks.get(p).pos, cStage.ai_tanks.get(p).dim, cStage);
                    if(isColliding){
                        moveEntityOutBoxCollision(cStage.ai_tanks.get(i), cStage.ai_tanks.get(p).pos, cStage.ai_tanks.get(p).dim, cStage);}
                }
            }
        }
    }
    void checkCollision_shellWall(stage cStage){
        /*
        Checks all shells to see if they will
        */
        //1
        for(int i=cStage.shells.size()-1; i>=0; i--){
            //2
            PVector shellTileCoord = findTileCoord(cStage.shells.get(i).pos, cStage);
            ArrayList<PVector> possibleWalls = searchNearby_walls(shellTileCoord, 3, 1, cStage);
            //3
            for(int j=0; j<possibleWalls.size(); j++){
                PVector wallPos = new PVector(possibleWalls.get(j).x*cStage.tWidth, possibleWalls.get(j).y*cStage.tWidth);
                PVector wallDim = new PVector(1.0, 1.0);
                //####################################
                //## CHANGE TO CIRCLE-BOX COLLISION ##
                //####################################
                boolean isColliding = checkBoxBoxCollision(cStage.shells.get(i).pos, cStage.shells.get(i).dim, wallPos, wallDim, cStage);
                if(isColliding){
                    //4
                    boolean atLimit = cStage.shells.get(i).checkDeflectLimit();
                    if(atLimit){
                        //Remove if at limit
                        cStage.shells.remove(i);
                        break;
                    }
                    else{
                        //Otherwise deflect it
                        deflectShellOffWall(cStage.shells.get(i), wallPos, wallDim, cStage);
                    }
                }
            }
        }
    }
    void checkCollision_shellTank(stage cStage){
        //1
        for(int i=cStage.shells.size()-1; i>=0; i--){
            boolean shellRemoved = false;   //Skips second check (which would be IMPOSSIBLE if destroyed => ABSOLUTELY NEEDED DO NOT REMOVE)

            //FOR PLAYER TANKS
            //------------------
            for(int j=cStage.player_tanks.size()-1; j>=0; j--){
                //####################################
                //## CHANGE TO CIRCLE-BOX COLLISION ##
                //####################################
                boolean isColliding = checkBoxBoxCollision(cStage.shells.get(i).pos, cStage.shells.get(i).dim, cStage.player_tanks.get(j).pos, cStage.player_tanks.get(j).dim, cStage);
                if(isColliding){
                    //Destroy both
                    cStage.shells.remove(i);
                    cStage.player_tanks.remove(j);
                    shellRemoved = true;
                    break;
                }
            }

            //FOR AI TANKS
            //--------------
            if(!shellRemoved){
                for(int j=cStage.ai_tanks.size()-1; j>=0; j--){
                    //####################################
                    //## CHANGE TO CIRCLE-BOX COLLISION ##
                    //####################################
                    boolean isColliding = checkBoxBoxCollision(cStage.shells.get(i).pos, cStage.shells.get(i).dim, cStage.ai_tanks.get(j).pos, cStage.ai_tanks.get(j).dim, cStage);
                    if(isColliding){
                        //Destroy both
                        cStage.shells.remove(i);
                        cStage.ai_tanks.remove(j);
                        break;
                    }
                }
            }
        }
    }
    void checkCollision_mineTank(stage cStage){
        for(int i=cStage.mines.size()-1; i>=0; i--){
            boolean alreadyExploded = false;

            //For PLAYER
            //------------
            for(int j=cStage.player_tanks.size()-1; j>=0; j--){
                //Check whitelist
                boolean isWhitelisted = false;
                for(int z=0; z<cStage.mines.get(i).whitelist.size(); z++){
                    if(cStage.mines.get(i).whitelist.get(z) == cStage.player_tanks.get(j).ID){
                        isWhitelisted = true;
                        break;}
                }

                if(!isWhitelisted){
                    //####################################
                    //## CHANGE TO CIRCLE-BOX COLLISION ##
                    //####################################
                    boolean isColliding = checkBoxBoxCollision(cStage.mines.get(i).pos, new PVector(cStage.mines.get(i).activeRad, cStage.mines.get(i).activeRad, 0), cStage.player_tanks.get(i).pos, cStage.player_tanks.get(i).dim, cStage);
                    if(isColliding){
                        //If they collide, activate mine and destroy both
                        explodeMine(cStage.mines.get(i), cStage);
                        alreadyExploded = true;
                        break;
                    }
                }
            }

            //For AI
            //--------
            if(!alreadyExploded){
                for(int j=cStage.ai_tanks.size()-1; j>=0; j--){
                    //Check whitelist
                    boolean isWhitelisted = false;
                    for(int z=0; z<cStage.mines.get(i).whitelist.size(); z++){
                        if(cStage.mines.get(i).whitelist.get(z) == cStage.ai_tanks.get(j).ID){
                            isWhitelisted = true;
                            break;}
                    }

                    if(!isWhitelisted){
                        //####################################
                        //## CHANGE TO CIRCLE-BOX COLLISION ##
                        //####################################
                        boolean isColliding = checkBoxBoxCollision(cStage.mines.get(i).pos, new PVector(cStage.mines.get(i).activeRad, cStage.mines.get(i).activeRad, 0), cStage.ai_tanks.get(i).pos, cStage.ai_tanks.get(i).dim, cStage);
                        if(isColliding){
                            //If they collide, activate mine and destroy both
                            explodeMine(cStage.mines.get(i), cStage);
                            break;
                        }
                    }
                }
            }
        }
    }
    void checkCollision_mineShell(stage cStage){
        for(int i=cStage.mines.size()-1; i>=0; i--){
            for(int j=cStage.shells.size()-1; j>=0; j--){
                //####################################
                //## CHANGE TO CIRCLE-BOX COLLISION ##
                //####################################
                boolean isColliding = checkBoxBoxCollision(cStage.mines.get(i).pos, cStage.mines.get(i).dim, cStage.shells.get(i).pos, cStage.shells.get(i).dim, cStage);
                if(isColliding){
                    //If they collide, activate mine and destroy both
                    explodeMine(cStage.mines.get(i), cStage);
                    break;
                }
            }
        }
    }


    void explodeMine(mine cMine, stage cStage){
        explodeMine_shells(cMine, cStage);
        explodeMine_tanks(cMine, cStage);
        explodeMine_walls(cMine, cStage);
        explodeMine_mines(cMine, cStage);
    }
    void explodeMine_shells(mine cMine, stage cStage){
        for(int i=cStage.shells.size()-1; i>=0; i--){
            float dist = vecDist(cMine.pos, cStage.shells.get(i).pos);
            if(dist < cMine.explodeRad*cStage.tWidth){
                cStage.shells.remove(i);
            }
        }
    }
    void explodeMine_tanks(mine cMine, stage cStage){
        //For PLAYERS
        //------------
        for(int i=cStage.player_tanks.size()-1; i>=0; i--){
            float dist = vecDist(cMine.pos, cStage.player_tanks.get(i).pos);
            if(dist < cMine.explodeRad*cStage.tWidth){
                cStage.player_tanks.remove(i);
            }
        }

        //For AI
        //--------
        for(int i=cStage.ai_tanks.size()-1; i>=0; i--){
            float dist = vecDist(cMine.pos, cStage.ai_tanks.get(i).pos);
            if(dist < cMine.explodeRad*cStage.tWidth){
                cStage.ai_tanks.remove(i);
            }
        }
    }
    void explodeMine_walls(mine cMine, stage cStage){
        /*
        When a mine explodes, the check is made
        Looks in radius for tiles applicatable
        Then destroys all applicable

        NOTE; Only destroys tiles with their CENTRE in the blast zone
        */
        //**This is inefficient, but the calculation rarely occurs (once a million frames), so is probably fine
        ArrayList<PVector> marked = new ArrayList<PVector>();   //So dont skip rows or cols when deleting halfway through
        for(int j=0; j<cStage.tiles.size(); j++){
            for(int i=0; i<cStage.tiles.get(j).size(); i++){
                float dist = vecDist(cMine.pos, new PVector(i*cStage.tWidth, j*cStage.tWidth, cMine.pos.z));
                if(dist < cMine.explodeRad*cStage.tWidth){
                    marked.add( new PVector(i,j) );
                }
            }
        }
        for(int i=0; i<marked.size(); i++){
            cStage.tiles.get(int(marked.get(i).y)).remove( int(marked.get(i).x) );
            cStage.tiles.get(int(marked.get(i).y)).add( int(marked.get(i).x), new empty() );
        }
    }
    void explodeMine_mines(mine cMine, stage cStage){
        /*
        This current mine is included in the search => clears itself
        */
        for(int i=cStage.mines.size()-1; i>=0; i--){
            float dist = vecDist(cMine.pos, cStage.mines.get(i).pos);
            if(dist < cMine.explodeRad*cStage.tWidth){
                cStage.mines.remove(i);
            }
        }
    }
    int checkTankShells(tank cTank, stage cStage){
        /*
        Checks the stage for all shells fired by the given tank, and returns the number currently on screen for it
        This is used to limit the number of shells a tank can fire at once
        */
        int shellCounter = 0;
        for(int i=0; i<cStage.shells.size(); i++){
            if(cStage.shells.get(i).owner == cTank.ID){
                shellCounter++;
            }
        }
        return shellCounter;
    }
}