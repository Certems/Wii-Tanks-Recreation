uniqueObject obj1;
uniqueObject obj2;
uniqueObject obj3;

void setup(){
    size(800,800,P2D);
    obj1 = new uniqueObject(new PVector(500,500), new PVector(30,30));
    obj2 = new uniqueObject(new PVector(600,600), new PVector(45,45));
    obj3 = new uniqueObject(new PVector(555,600), new PVector(45,45));
}
void draw(){
    background(30,30,30);
    obj1.display();
    obj2.display();
    //obj3.display();

    obj1.calc();

    calcCollisionDynamics(obj1, obj2);
    //calcCollisionDynamics(obj1, obj3);
}
void keyPressed(){
    if(key == '1'){
        obj1.moving = !obj1.moving;
    }
    if(key == 'w'){
        obj1.pos.y -= 5.0;}
    if(key == 's'){
        obj1.pos.y += 5.0;}
    if(key == 'a'){
        obj1.pos.x -= 5.0;}
    if(key == 'd'){
        obj1.pos.x += 5.0;}
}


boolean checkBoxCollision(uniqueObject cObj1, uniqueObject cObj2){
    /*
    Checks if 2 boxes intercept eachother
    */
    boolean withinX = abs(cObj1.pos.x -cObj2.pos.x) < (cObj1.cBounds.x +cObj2.cBounds.x)/2.0;
    boolean withinY = abs(cObj1.pos.y -cObj2.pos.y) < (cObj1.cBounds.y +cObj2.cBounds.y)/2.0;
    if(withinX && withinY){
        return true;}
    else{
        return false;}
}
void moveOutOfCollision(uniqueObject cObj1, uniqueObject cObj2){
    /*
    pushes 1 away from 2 by ... X AMOUNT ...
    */
    float mag = sqrt( pow(cObj1.pos.x -cObj2.pos.x,2) + pow(cObj1.pos.y -cObj2.pos.y,2) );
    PVector pushVec = new PVector((cObj2.pos.x -cObj1.pos.x)/mag, (cObj2.pos.y -cObj1.pos.y)/mag);
    float xOverlap = abs(cObj2.pos.x -cObj1.pos.x) - (cObj2.cBounds.x +cObj1.cBounds.x)/2.0;
    float yOverlap = abs(cObj2.pos.y -cObj1.pos.y) - (cObj2.cBounds.y +cObj1.cBounds.y)/2.0;
    float pushMag = min(xOverlap, yOverlap);
    println("xOver; ",xOverlap);
    println("yOver; ",yOverlap);
    println("pushMag; ",pushMag);
    cObj1.pos.x += pushMag*pushVec.x;
    cObj1.pos.y += pushMag*pushVec.y;
}
void calcCollisionDynamics(uniqueObject cObj1, uniqueObject cObj2){
    boolean isColliding = checkBoxCollision(cObj1, cObj2);
    if(isColliding){
        moveOutOfCollision(cObj1, cObj2);
    }
}


class uniqueObject{
    PVector pos;
    PVector cBounds;

    boolean moving = false;

    uniqueObject(PVector initPos, PVector collisionBounds){
        pos = initPos;
        cBounds = collisionBounds;
    }

    void display(){
        pushStyle();

        rectMode(CENTER);
        noFill();
        if( checkBoxCollision(this, obj2) ){
            stroke(100,255,100);}
        else{
            stroke(255);}
        strokeWeight(2);
        ellipse(pos.x, pos.y, 10,10);
        rect(pos.x, pos.y, cBounds.x, cBounds.y);

        popStyle();
    }
    void calc(){
        calcMoving();
    }
    void calcMoving(){
        if(moving){
            pos = new PVector(mouseX, mouseY);
        }
    }
}