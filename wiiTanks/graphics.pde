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
        for(int j=0; j<cStage.tiles.size(); j++){
            for(int i=0; i<cStage.tiles.get(j).size(); i++){
                pushMatrix();
                translate(i*cStage.tWidth, j*cStage.tWidth);
                fill(255);
                if(cStage.tiles.get(j).get(i).name == "tile_crate"){
                    fill(255,0,0);}
                if(cStage.tiles.get(j).get(i).name == "tile_cork"){
                    fill(0,255,0);}
                if(cStage.tiles.get(j).get(i).name == "tile_hole"){
                    fill(0,0,255);}
                box(cStage.tWidth);
                popMatrix();
            }
        }

        popMatrix();
        popStyle();
    }
    void displayTank(tank cTank, stage cStage){
        pushStyle();
        pushMatrix();

        translate(cStage.startPos.x, cStage.startPos.y, cStage.startPos.z);

        fill(0,0,0);
        translate(cTank.pos.x, cTank.pos.y, cTank.pos.z);
        box(cTank.dim.x*cStage.tWidth);
        println("HERE -> ",cTank.pos);

        popMatrix();
        popStyle();
    }
    void displayShell(shell cShell, stage cStage){
        pushStyle();
        pushMatrix();

        translate(cStage.startPos.x, cStage.startPos.y, cStage.startPos.z);

        fill(255,0,0);
        translate(cShell.pos.x, cShell.pos.y, cShell.pos.z);
        sphere(cShell.dim.x*cStage.tWidth);

        popMatrix();
        popStyle();
    }
    void displayMine(mine cMine, stage cStage){
        pushStyle();
        pushMatrix();

        translate(cStage.startPos.x, cStage.startPos.y, cStage.startPos.z);

        fill(255,0,0);
        translate(cMine.pos.x, cMine.pos.y, cMine.pos.z);
        box(cMine.dim.x*cStage.tWidth);

        popMatrix();
        popStyle();
    }
}