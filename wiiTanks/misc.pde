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