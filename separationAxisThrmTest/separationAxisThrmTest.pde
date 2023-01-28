objShape obj1;
objShape obj2;

void setup(){
    size(800,800);
    obj1 = new objShape( new PVector(1.0*width/4.0, height/2.0), new PVector(90,90), 0 );
    obj2 = new objShape( new PVector(3.0*width/4.0, height/2.0), new PVector(60,60), 0 );
}
void draw(){
    background(30,30,50);

    obj1.display();
    obj2.display();

    obj1.pos = new PVector(mouseX, mouseY);

    pushStyle();
    stroke(255);
    textSize(15);
    textAlign(LEFT, CENTER);
    text(frameRate, 20,20);
    popStyle();
}
void keyPressed(){
    if(key == '1'){
        obj1.rot -= PI/16.0;}
    if(key == '2'){
        obj1.rot += PI/16.0;}
    if(key == '3'){
        obj2.rot -= PI/16.0;}
    if(key == '4'){
        obj2.rot += PI/16.0;}
}


class objShape{
    PVector pos;
    PVector dim;
    float rot;

    objShape(PVector iPos, PVector iDim, float iRot){
        pos = iPos;
        dim = iDim;
        rot = iRot;
    }

    void display(){
        pushStyle();
        pushMatrix();

        stroke(255);
        if( checkBoxBoxCollision(obj1.pos, obj1.dim, obj1.rot, obj2.pos, obj2.dim, obj2.rot) ){
            stroke(255,0,0);}
        noFill();
        strokeWeight(2);
        translate(pos.x, pos.y);
        rotate(rot);
        rectMode(CENTER);
        rect(0,0, dim.x, dim.y);
        popMatrix();

        ArrayList<PVector> points = findBoxVertices(pos, dim, rot);
        for(int i=0; i<points.size(); i++){
            ellipse(points.get(i).x, points.get(i).y, 10,10);
        }

        popStyle();
    }
}

boolean checkBoxBoxCollision(PVector p1, PVector d1, float r1, PVector p2, PVector d2, float r2){
    /*
    BoxBox collision with separation axis thrm in use

    1. Locate all vertices of each box
    2. Find the normals to each side (not duplicated) for each box (=> 8 in total, 4 dupes => 4 in reality)
    3. Find projections onto each axis for each corner for each box, find min and max
    4. Compare min and max for cross over (depending on centre's projection to axis, determining a 'which side' perspective)
    5. If crossing, keep checking
    6. If NOT crossing, end here, no collision
    7. If ALL cross, is colliding
    */
    //1
    ArrayList<PVector> b1Verts = findBoxVertices(p1, d1, r1);
    ArrayList<PVector> b2Verts = findBoxVertices(p2, d2, r2);
    //2
    ArrayList<PVector> bNorms = new ArrayList<PVector>();
    PVector b1v1 = vecUnitDir(b1Verts.get(0), b1Verts.get(1));PVector ortho_b1v1 = new PVector(b1v1.y, -b1v1.x);
    PVector b1v2 = vecUnitDir(b1Verts.get(0), b1Verts.get(2));PVector ortho_b1v2 = new PVector(-b1v2.y, b1v2.x);
    bNorms.add(ortho_b1v1);bNorms.add(ortho_b1v2);//Find using 0->1 and 0->2
    PVector b2v1 = vecUnitDir(b2Verts.get(0), b2Verts.get(1));PVector ortho_b2v1 = new PVector(b2v1.y, -b2v1.x);
    PVector b2v2 = vecUnitDir(b2Verts.get(0), b2Verts.get(2));PVector ortho_b2v2 = new PVector(-b2v2.y, b2v2.x);
    bNorms.add(ortho_b2v1);bNorms.add(ortho_b2v2);//Find using 0->1 and 0->2
    //3
    //For all normals
    boolean isColliding = true;
    for(int i=0; i<bNorms.size(); i++){
        //Find projections for b1 -> min and max
        float b1Max = vecDot(bNorms.get(i), b1Verts.get(0) );
        float b1Min = vecDot(bNorms.get(i), b1Verts.get(0) );
        for(int j=0; j<b1Verts.size(); j++){
            float pProj = vecDot(bNorms.get(i), b1Verts.get(j));
            if(pProj > b1Max){
                b1Max = pProj;}
            if(pProj < b1Min){
                b1Min = pProj;}
        }
        //Find projections for b2 -> min and max#
        float b2Max = vecDot(bNorms.get(i), b2Verts.get(0) );
        float b2Min = vecDot(bNorms.get(i), b2Verts.get(0) );
        for(int j=0; j<b2Verts.size(); j++){
            float pProj = vecDot(bNorms.get(i), b2Verts.get(j));
            if(pProj > b2Max){
                b2Max = pProj;}
            if(pProj < b2Min){
                b2Min = pProj;}
        }
        //Compare max and mins
        boolean noOverlap = true;
        if( (b2Max < b1Min) || (b1Max < b2Min) ){
            noOverlap = false;}
        if(!noOverlap){
            //Then cannot possibly have collision => end sequence
            isColliding = false;
            break;
        }
        //If ARE overlaps, keep checking norms for rest
    }
    return isColliding;
}
ArrayList<PVector> findBoxVertices(PVector pos, PVector dim, float rot){
    /*
    Finds the vertices of a box as a list as follows;
    0 - 1
    |   |
    2 - 3
    */
    ArrayList<PVector> vertexList = new ArrayList<PVector>();
    //Go through all corners
    for(int j=-1; j<2; j+=2){
        for(int i=-1; i<2; i+=2){
            //Add rotated point to list as though about origin (using matrix, x=i*dim.x/2, y=j*dim.y/2)
            vertexList.add( new PVector(i*(dim.x/2.0)*cos(rot) -j*(dim.y/2.0)*sin(rot), i*(dim.x/2.0)*sin(rot) +j*(dim.y/2.0)*cos(rot)) );
        }
    }
    //Translate rotated point to be about pos, NOT origin
    for(int i=0; i<vertexList.size(); i++){
        vertexList.get(i).x += pos.x;
        vertexList.get(i).y += pos.y;
    }
    return vertexList;
}





float vecMag(PVector v){
    return sqrt( pow(v.x,2) + pow(v.y,2) + pow(v.z,2) );
}
PVector vecUnit(PVector v){
    float mag = vecMag(v);
    if(mag == 0){
        return new PVector(0,0,0);}
    else{
        return new PVector(v.x/mag, v.y/mag, v.z/mag);}
}
PVector vecDir(PVector v1, PVector v2){
    /*
    Vector pointing FROM v1 TO v2
    */
    return new PVector(v2.x -v1.x, v2.y -v1.y, v2.z -v1.z);
}
float vecDist(PVector v1, PVector v2){
    /*
    Distance between two vector points
    NOTE; 3D DISTANCE, NOT 2D
    */
    PVector dir = vecDir(v1, v2);
    return vecMag(dir);
}
PVector vecUnitDir(PVector v1, PVector v2){
    /*
    Unit vector pointing FROM v1 TO v2
    */
    PVector dir = vecDir(v1, v2);
    float mag = vecMag(dir);
    if(mag == 0){
        return new PVector(0,0,0);}
    else{
        return new PVector(dir.x/mag, dir.y/mag, dir.z/mag);}
}
float vecDot(PVector v1, PVector v2){
    return ( (v1.x*v2.x) + (v1.y*v2.y) );
}