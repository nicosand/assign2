PImage bg1Img, bg2Img, treasureImg, fighterImg, enemyImg, hpImg;
PImage start1Img, start2Img, end1Img, end2Img;

int x_bg1 = 0, x_bg2 = -640;
int x_treasure, y_treasure, x_hp;
float x_enemy, y_enemy;
float x_fighter, y_fighter, speed = 5;

int gameState;
final int GAME_START = 1, GAME_RUN = 2, GAME_OVER = 3;

boolean upPressed, downPressed, leftPressed, rightPressed = false;

void setup () {
  size(640, 480) ;
  bg1Img = loadImage("img/bg1.png");
  bg2Img = loadImage("img/bg2.png");
  treasureImg = loadImage("img/treasure.png");
  fighterImg = loadImage("img/fighter.png");
  enemyImg = loadImage("img/enemy.png");
  hpImg = loadImage("img/hp.png");
  start1Img = loadImage("img/start1.png");
  start2Img = loadImage("img/start2.png");
  end1Img = loadImage("img/end1.png");
  end2Img = loadImage("img/end2.png");
  
  gameState = GAME_START;
}

void draw() {
  
  switch(gameState){    
    
    case GAME_START:
      image(start2Img, 0, 0);
      x_fighter = 590;
      y_fighter = 215;
      x_treasure = floor(random(600));
      y_treasure = floor(random(440));
      x_enemy = 0;
      y_enemy = floor(random(420));
      x_hp = 200*1/5;
      
      //mouse action
      if(mouseX > 203 && mouseX < 458){
        if(mousePressed){
          gameState = GAME_RUN;
        }else{
          image(start1Img, 0, 0);
        }
      }
      if(mouseY < 379 || mouseY > 413){
        if(mousePressed){
          gameState = GAME_START;
        }else{
          image(start2Img, 0, 0);
        }
      }
      break;
      
    case GAME_RUN:
      //bg
      image(bg1Img, x_bg1, 0);
      x_bg1 += 3;
      if(x_bg1 >= width){
        x_bg1 = -640;
      }
      image(bg2Img, x_bg2, 0);
      x_bg2 += 3;
      if(x_bg2 >= width){
        x_bg2 = -640;
      }
      
      //treasure
      image(treasureImg, x_treasure, y_treasure);
      if(x_treasure >= (x_fighter+50) || x_treasure+40 <= x_fighter){
        x_hp += 0;
      }
      else if((y_treasure+40) < y_fighter || y_treasure > (y_fighter+50)){
        x_hp += 0;
      }else{
        x_treasure = floor(random(600));
        y_treasure = floor(random(440));
        if(x_hp == 200){
          x_hp += 0;
        }else{
        x_hp += 200*1/10;
        }
      }
   
      //fighter
      image(fighterImg, x_fighter, y_fighter);
      if(x_fighter >= 590){
        x_fighter = 590;
      }
      if(x_fighter <= 0){
        x_fighter = 0;
      }
      if(y_fighter >= 430){
        y_fighter = 430;
      }
      if(y_fighter <= 0){
        y_fighter = 0;
      }
      
      //fighter action
      if(upPressed){
        y_fighter -= speed;
      }
      if(downPressed){
        y_fighter += speed;
      }
      if(leftPressed){
        x_fighter -= speed;
      }
      if(rightPressed){
        x_fighter += speed;
      }
      
      //enemy
      image(enemyImg, x_enemy, y_enemy);
      x_enemy += 5;
      x_enemy %= width;
      if(y_enemy >= 420){
        y_fighter = 420;
      }
      if(y_enemy <= 0){
        y_fighter = 0;
      }
      
      if(x_enemy+50 < x_fighter){
        if(y_enemy < (y_fighter-5)){
          y_enemy += 3;
        }
        else if((y_enemy+30) > (y_fighter+25)){
          y_enemy -= 3;
          }else{
            y_enemy += 0;
          }
        }
      if(x_enemy > (x_fighter+50)){
        if(y_enemy < (y_fighter-5)){
          y_enemy -= 3;
        }
        else if((y_enemy+30) > (y_fighter+25)){
          y_enemy += 3;
          }else{
            y_enemy += 0;
          }
      }


      //hp
      fill(#ff0000);
      rect(20, 12, x_hp, 20, 12);
      image(hpImg, 10, 10);

      //lose
      if((y_enemy+60) < y_fighter || y_enemy > (y_fighter+50)){
        gameState = GAME_RUN;
      }
      else if(x_enemy > (x_fighter+50) || (x_enemy+50) < x_fighter){
        gameState = GAME_RUN;
      }else{
        x_enemy = 0;
        y_enemy = floor(random(420));
        x_hp -= 200*1/5;
      }
      
      //game over
      if(x_hp <= 0){
        gameState = GAME_OVER;
      }
        
      break;
      
    case GAME_OVER:
      image(end2Img, 0, 0);
      //mouse action
      if(mouseX > 203 && mouseX < 458){
        if(mousePressed){
          //click
          gameState = GAME_START;
        }else{
          image(end1Img, 0, 0);
        }
      }
      if(mouseY < 312 || mouseY > 345){
        if(mousePressed){
          gameState = GAME_OVER;
        }else{
          image(end2Img, 0 , 0);
        }
      }
      break;
  }
}

void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  } 
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
