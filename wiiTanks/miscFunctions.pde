float vecDist(PVector v1, PVector v2){
    return sqrt( pow(v2.x -v1.x, 2) + pow(v2.y -v1.y,2) );
}
float vecMag(PVector v){
    return sqrt( pow(v.x, 2) + pow(v.y,2) );
}
PVector vecDir(PVector v1, PVector v2){
    //FROM v1 TO v2
    return new PVector(v2.x-v1.x, v2.y-v1.y, v2.z-v1.z);
}
PVector vecUnitDir(PVector v1, PVector v2){
    //FROM v1 TO v2
    PVector dir = vecDir(v1, v2);
    float mag   = vecMag(dir);
    return new PVector(dir.x/mag, dir.y/mag, dir.z/mag);
}