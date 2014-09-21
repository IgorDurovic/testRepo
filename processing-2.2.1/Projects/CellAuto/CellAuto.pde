int millis = 100;
int cellDim = 5;

int cells[][];
int savedCells[][];
int lastTime = 0;

void setup(){
  size(1280, 720);
  
  cells = new int[width/cellDim][height/cellDim];
  savedCells = new int[width/cellDim][height/cellDim];

  stroke(48);

  for(int a = 0; a < width/cellDim; a++){
    for(int b = 0; b < height/cellDim; b++){
      int state = int(random(100));
      if(state > 15){
        state = 0;
      }
      else{
        state = 1;
      }
      cells[a][b] = state;
    }
  }
  background(256, 256, 256);
}

void draw(){
  for(int a = 0; a < width/cellDim; a++){
    for(int b = 0; b < height/cellDim; b++){
      if(cells[a][b] == 1){
        fill(0);
      }
      else{
        fill(256, 256, 256);
      }
      rect(cellDim*a, cellDim*b, cellDim, cellDim);
    }
  }
  
  if(millis() - lastTime > millis){
    cycle();
    lastTime = millis();
  }
}

void keyPressed(){
  
}

void cycle(){
  for (int a=0; a<width/cellDim; a++) {
    for (int b=0; b<height/cellDim; b++) {
      savedCells[a][b] = cells[a][b];
    }
  }
  
  for(int a = 0; a < width/cellDim; a++){
    for(int b = 0; b < height/cellDim; b++){
      int neighbors = 0;
      for(int c = a-1; c <= a+1; c++){
        for(int d = b-1; d <= b+1; d++){
          if(((c>=0)&&(c<width/cellDim))&&((d>=0)&&(d<height/cellDim))) { // Make sure you are not out of bounds
            if(!((c==a)&&(d==b))) { // Make sure to to check against self
              if(savedCells[c][d]==1){
                neighbors++; // Check alive neighbours and count them
              }
            } // End of if
          }
        }
      }
      if(savedCells[a][b] == 1){
        if(neighbors<2||neighbors>3){
          cells[a][b] = 0;
        }
      }
      else{
        if(neighbors == 3){
          cells[a][b] = 1;
        }
      }
    }
  }
}
