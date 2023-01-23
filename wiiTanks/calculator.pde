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
}