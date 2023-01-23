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
                    cStage.player_tanks.get(0).fireShell(cStage);}
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


    boolean checkBoxBoxCollision(PVector p1, PVector d1, PVector p2, PVector d2){
        /*
        Checks if 2 boxes, specified each by a centre point and dimension, are 
        colliding with eachother
        p = pos
        d = dimension
        */
        boolean withinX = abs(p1.x-p2.x) < (d1.x/2.0) + (d2.x/2.0);
        boolean withinY = abs(p1.y-p2.y) < (d1.y/2.0) + (d2.y/2.0);
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
    void moveEntityOutBoxCollision(entity cEntity, PVector p, PVector d){
        /*
        Moves an entity backwards out of a box
        Centre = p
        Dim = d
        Then sets velocity of entity to 0
        */
        float scale = 0.20;         //**Resolution of backwards moving (relative to frames)
        int countermeasure = 0;     //**Safety against infinite loops
        PVector nVel = new PVector(scale*cEntity.vel.x, scale*cEntity.vel.y, scale*cEntity.vel.z);   //New velocity
        while(countermeasure < 300){
            cEntity.pos.x -= nVel.x;
            cEntity.pos.y -= nVel.y;
            cEntity.pos.z -= nVel.z;
            boolean stillColliding = checkBoxBoxCollision(cEntity.pos, cEntity.dim, p, d);
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
        checkCollision_mineWall(cStage);
        checkCollision_mineTank(cStage);
        checkCollision_mineShell(cStage);
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
                PVector wallDim = new PVector(cStage.tWidth, cStage.tWidth);
                boolean isColliding = checkBoxBoxCollision(cStage.player_tanks.get(i).pos, cStage.player_tanks.get(i).dim, wallPos, wallDim);
                if(isColliding){
                    //4
                    moveEntityOutBoxCollision(cStage.player_tanks.get(i), wallPos, wallDim);
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
                boolean isColliding = checkBoxBoxCollision(cStage.ai_tanks.get(i).pos, cStage.ai_tanks.get(i).dim, wallPos, wallDim);
                if(isColliding){
                    //4
                    moveEntityOutBoxCollision(cStage.ai_tanks.get(i), wallPos, wallDim);
                }
            }
        }
    }
    void checkCollision_tankTank(stage cStage){
        //pass
    }
    void checkCollision_shellWall(stage cStage){
        //pass
    }
    void checkCollision_shellTank(stage cStage){
        //pass
    }
    void checkCollision_mineWall(stage cStage){
        //pass
    }
    void checkCollision_mineTank(stage cStage){
        //pass
    }
    void checkCollision_mineShell(stage cStage){
        //pass
    }
}