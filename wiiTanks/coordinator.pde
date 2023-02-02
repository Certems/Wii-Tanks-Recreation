class coordinator{
    /*
    Times specific events, labelled as;
    0 = Ending round, moving into next, starting next round
    1 = ...
    ...
    */
    int eType;
    boolean eventComplete = false;

    int cTime = 0;              //Current time
    int nSeq  = 0;              //Which point in the sequence you currently are at
    ArrayList<Integer> timings; //Timings for each point in event sequence

    coordinator(int eventType, ArrayList<Integer> eventTimings){
        eType   = eventType;
        timings = eventTimings;
    }

    void progressEvent(){
        /*
        Continues the coordination event
        */
        if(eType == 0){
            event_NewRound(cManager.cGraphics, timings);
        }
        if(eType == 1){
            //pass
        }
        //...
    }


    void event_NewRound(graphics cGraphics, ArrayList<Integer> timings){
        /*
        The 'newRound' events consists of;
        0. Display "Mission Complete!" for x0 time
        1. Transition to transition screen within x1 time
        2. Displays transition screen for x2 for time
            2.1. Load new stage
        3. Transition back to stage within x3 time
        4. Wait for x4 time on stage screen
        5. Display "Start!" for x5 time
        6. Then remove this coordination event
        */
        if(nSeq == 0){
            cGraphics.display_missionComplete();}
        else if(nSeq == 1){
            cGraphics.display_fadeToBlack(timings.get(nSeq), cTime);}
        else if(nSeq == 2){
            removeGameScreen();
            if(cTime == 0){   //Do just ONCE
                updateMissionVariables();
                loadCorrectMission();
                cManager.cInfo.roundOver = false;
            }
            cGraphics.display_transitionScreen();}
        else if(nSeq == 3){
            addGameScreen();
            cGraphics.display_fadeOutBlack(timings.get(nSeq), cTime);}
        else if(nSeq == 4){
            //pass
        }
        else if(nSeq == 5){
            cGraphics.display_start();}
        else if(nSeq == 6){
            eventComplete = true;}
        cTime++;
        if(!eventComplete){
            if(cTime > timings.get(nSeq)*60){
                cTime = 0;
                nSeq++;
            }
        }
    }
    void removeGameScreen(){
        int gameScreenInd = -1;
        for(int i=0; i<cManager.gameState.size(); i++){
            if(cManager.gameState.get(i) == 0){
                gameScreenInd = i;
                break;
            }
        }
        if(gameScreenInd != -1){
            cManager.gameState.remove( gameScreenInd );
        }
    }
    void addGameScreen(){
        boolean existsGameScreen = false;
        for(int i=0; i<cManager.gameState.size(); i++){
            if(cManager.gameState.get(i) == 0){
                existsGameScreen = true;
                break;
            }
        }
        if(!existsGameScreen){
            cManager.gameState.add(0,0);
        }
    }
    void updateMissionVariables(){
        cManager.cInfo.nMission++;
    }
    void loadCorrectMission(){
        cManager.loadStagePreset( cManager.cInfo.nMission );
    }
}