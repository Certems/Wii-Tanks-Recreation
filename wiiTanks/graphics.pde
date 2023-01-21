class graphics{
    /*
    Manages all displaying of assets
    */
    //pass

    graphics(){
        //pass
    }

    void displayState(int state){
        if(state == 0){
            displayInMatch(cManager.cStage);
        }
        //...
    }


    void displayInMatch(stage cStage){
        displayBackground();
        displayTanks(cStage);
        displayTiles(cStage);
    }
    void displayBackground(){
        background(30,30,60);
    }
    void displayTanks(stage cStage){
        displayAiTanks(cStage);
        displayPlayerTanks(cStage);
    }
    void displayAiTanks(stage cStage){
        for(int i=0; i<cStage.ai_tanks.size(); i++){
            displayTank(cStage.ai_tanks.get(i), cStage);
        }
    }
    void displayPlayerTanks(stage cStage){
        for(int i=0; i<cStage.player_tanks.size(); i++){
            displayTank(cStage.player_tanks.get(i), cStage);
        }
    }
    void displayTiles(stage cStage){
        pushStyle();
        pushMatrix();

        translate(cStage.startPos.x, cStage.startPos.y, cStage.startPos.z);

        fill(255);
        stroke(0);
        strokeWeight(1);
        pushMatrix();
        for(int j=0; j<cStage.tiles.size(); j++){
            for(int i=0; i<cStage.tiles.get(j).size(); i++){
                translate(i*cStage.tWidth, j*cStage.tWidth);
                box(cStage.tWidth);
            }
        }
        popMatrix();

        popMatrix();
        popStyle();
    }
    void displayTank(tank cTank, stage cStage){
        pushStyle();
        pushMatrix();

        translate(cStage.startPos.x, cStage.startPos.y, cStage.startPos.z);

        fill(255,0,0);
        rect(cTank.pos.x, cTank.pos.y, cTank.dim.x, cTank.dim.y);

        popMatrix();
        popStyle();
    }
}