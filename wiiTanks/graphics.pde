class graphics{
    /*
    Actually draws given objects parsed to it, or draws specific 
    requests from within the functions themselves
    */
    //pass

    graphics(){
        //pass
    }

    void displayState(int nState){
        /*
        Displays everything required for the state number, nState
        */
        if(nState == 0){
            displayMap();}
        if(nState == 1){
            //pass
        }
        //...
    }
    

    void displayMap(){
        displayWoodBackground();
        //displayTiles(cEnviro.cMap.startPos, cEnviro.cMap.tWidth, cEnviro.cMap.tiles); //Mainly a bug fixing tool now
        
        displayMines(cEnviro.cMap);
        displayShells(cEnviro.cMap);
        displayTanks(cEnviro.cMap);
        
        displayTerrain(cEnviro.cMap.startPos, cEnviro.cMap.tWidth, cEnviro.cMap.tiles);
        displayMapOverlay();
    }
    void displayWoodBackground(){
        background(0);
        pushStyle();
        imageMode(CORNER);
        image(background_wood, 0.0, 0.0, height, height);
        popStyle();
    }
    void displayTiles(PVector startPos, float tWidth, ArrayList<ArrayList<tile>> tiles){
        fill(255);
        for(int j=0; j<tiles.size(); j++){
            for(int i=0; i<tiles.get(j).size(); i++){
                pushMatrix();
                translate(startPos.x +i*tWidth, startPos.y +j*tWidth, startPos.z);
                box(tWidth);
                popMatrix();
            }
        }
    }
    void displayMines(map cMap){
        for(int i=0; i<cMap.mines.size(); i++){
            displayMine(cMap.mines.get(i), cMap);
        }
    }
    void displayShells(map cMap){
        for(int i=0; i<cMap.shells.size(); i++){
            displayShell(cMap.shells.get(i), cMap);
        }
    }
    void displayTanks(map cMap){
        for(int i=0; i<cMap.AI_tanks.size(); i++){
            displayTank(cMap.AI_tanks.get(i), cMap);}
        for(int i=0; i<cMap.player_tanks.size(); i++){
            displayTank(cMap.player_tanks.get(i), cMap);}
    }
    void displayMine(mine cMine, map cMap){
        pushStyle();
        pushMatrix();

        fill(200,120,40);
        translate(cMap.startPos.x +cMine.pos.x, cMap.startPos.y +cMine.pos.y, cMap.startPos.z +cMine.pos.z);
        box(cMap.tWidth*0.7);

        popMatrix();
        popStyle();
    }
    void displayShell(shell cShell, map cMap){
        pushStyle();
        pushMatrix();

        translate(cMap.startPos.x +cShell.pos.x, cMap.startPos.y +cShell.pos.y, cMap.startPos.z +cShell.pos.z);
        //box(cMap.tWidth*0.3);
        shape(cShell.casing, 0.0, 0.0, cMap.tWidth*0.3, cMap.tWidth*0.3);

        popMatrix();
        popStyle();
    }
    void displayTank(tank cTank, map cMap){
        /*
        Displays a single tank specified
        */
        pushStyle();

        //Chassis
        pushMatrix();
        translate(cMap.startPos.x +cTank.pos.x, cMap.startPos.y +cTank.pos.y, cMap.startPos.z +cTank.pos.z);
        rotate(cTank.chassisRot);
        //box(cMap.tWidth*cTank.sRel, cMap.tWidth*cTank.sRel, cMap.tWidth*cTank.sRel*0.5);
        shape(cTank.chassis, 0.0, 0.0);
        popMatrix();

        //Turret
        pushMatrix();
        translate(cMap.startPos.x +cTank.pos.x, cMap.startPos.y +cTank.pos.y, cMap.startPos.z +cTank.pos.z);
        rotate(cTank.turretRot);
        //box(cMap.tWidth*cTank.sRel*0.5);
        shape(cTank.turret, 0.0, 0.0);
        popMatrix();

        popStyle();
    }
    void displayTerrain(PVector startPos, float tWidth, ArrayList<ArrayList<tile>> tiles){
        for(int j=0; j<tiles.size(); j++){
            for(int i=0; i<tiles.get(j).size(); i++){
                for(int z=0; z<tiles.get(j).get(i).terrainSet.size(); z++){
                    pushMatrix();
                    float tHeight = 0;
                    for(int p=0; p<=z; p++){
                        tHeight += tWidth*tiles.get(j).get(i).terrainSet.get(p).hRatio;}
                    translate(startPos.x +i*tWidth, startPos.y +j*tWidth, startPos.z +tHeight);
                    box(tWidth, tWidth, tWidth*tiles.get(j).get(i).terrainSet.get(z).hRatio);
                    //## NEED TO ADD BIT TO SQUISH OR STRETCH DIFFERENT HEIGHT TERRAIN ##
                    //## BUGGED BECAUSE TEXTURE IS AN IMAGE, NOT A FLAT COLOUR ##
                    //shape(tiles.get(j).get(i).terrainSet.get(z).geometry, 0.0, 0.0, tWidth, tWidth);
                    popMatrix();
                }
            }
        }
    }
    void displayMapOverlay(){
        pushStyle();
        pushMatrix();

        fill(255);
        textSize(20);
        text(frameRate, mouseX,mouseY,0);
        text("nShells; "+cEnviro.cMap.shells.size(), mouseX,mouseY+20,0);
        text("ChassisRot; "+cEnviro.cMap.player_tanks.get(0).chassisRot, mouseX,mouseY+40,0);

        popMatrix();
        popStyle();
    }
}