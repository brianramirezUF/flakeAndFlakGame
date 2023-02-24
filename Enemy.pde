class Enemy{
 //initalization
  float hp, speed, dmg, x, y;
  PImage character;
  String image;
  int type;
  boolean fire = false;
  PImage bullet = loadImage("bullet.png");
  float bulletX;
  boolean deathSoundPlayed = false;
  boolean spawnNork = false;
  boolean moving = false;
  
  
  //asign default values in constructor
  Enemy(float healthValue, float speedValue, float damageValue, float x, float y , String image, int type){
    hp = healthValue;
    speed = -speedValue;
    dmg = damageValue;
    this.x = x;
    this.y = y;
    this.type = type;
    
    bulletX = x - bullet.width;
    
    
    this.image = image;
    character = loadImage(this.image + ".png");
    
    if(type == 3){
      bulletX = x + character.width; 
    }
    
  }
  
  //never used surprisingly
  void moveLeft(){
   
    //move left
    
  }
  
  void moveRight(){
    
    //move right
    
  }
  
  //how enemies take damage
  void takeDamage(float amount){
   
    //if hit
    hp -= amount;
    
  }
  
  //display the enemy
  void display(){
    
    //if alive
    if(hp > 0){
      
      //display
      image(character, x, y);
      fill(hp, 74 ,94);
      textSize(30);
      text(hp, x+character.width/2, y);
    
    //flip enemy depending on which side they walk off
      if(x + character.width < 0){
     
        character = loadImage(image+"flipped.png");
        speed *= -1;
      
      }
    
      if(x > width){
     
        character = loadImage(image+".png");
        speed*= -1;
    
      }
      
      //if enemy type 1
      //they move left to right and attack player when touched
      if(type == 1){
        x+=speed;
        
        if(player.x+player.character.width - 50 >= x && player.x + 50 <= x+character.width && (player.y >= y - 50 && player.y+player.character.height <= y + character.height + 160) && hp > 0 && !player.mounted){
       
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        
        }
        
        
        
        if(player.x+player.character.width - 18 >= x && player.x - 75 <= x+character.width && (player.y + 45 >= y - 50 && player.y + 484 <= y + character.height + 160 ) && hp > 0 && player.mounted){
          
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        }
        
        if(player.x + 500 - 95 > x && player.x + 90 < x + 200 && (player.y + 500 - 80 > y && player.y + 50 < y + 200)&& hp > 0 && player.mounted){
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        }
        
        
        
        
      }
      
      //if type 2 or 3
      //enemy attacks player by shooting 
      if(type == 2 || type == 3){
        
        if(player.x+player.character.width - 50 >= x && player.x + 50 <= x+character.width && (player.y >= y - 50 && player.y+player.character.height <= y + character.height + 160) && hp > 0 && !player.mounted){
       
            player.takeDamage(dmg);
            if(!playerHit.isPlaying()){
            
              playerHit.play();
            
            }
        
        }
        
        if(player.x + 500 - 95 > x && player.x + 90 < x + 200 && (player.y + 500 - 80 > y && player.y + 50 < y + 200)&& hp > 0 && player.mounted){
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        }
        
        //if fire is on cooldown
        if(fire){
          //show bullet moving
          image(bullet,bulletX,y);
          
          if(type == 2){
            bulletX += speed;
          }
          else{
            bulletX -= speed; 
          }
          
          
          
          if(player.x+player.character.width - 50 >= bulletX && player.x + 50 <= bulletX+bullet.width && (player.y >= y - 50 && player.y+player.character.height <= y + character.height+122) && hp > 0 && !player.mounted){
       
            player.takeDamage(dmg);
            if(!playerHit.isPlaying()){
            
              playerHit.play();
            
            }
        
          }
          
          if(player.x + 500 - 95 > bulletX + 50 && player.x + 90 < bulletX + 200 - 50 && (player.y + 500 - 160 > y && player.y + 50 < y + 200 - 120) && hp > 0 && player.mounted){
            player.takeDamage(dmg);
            if(!playerHit.isPlaying()){
              
              playerHit.play();
              
            }
          }
        
        }
        
        
         //if on 50th frame and on cooldown while not moving
         if(frameCount % 50 == 0 && !fire && !moving){
           //sound and shoot
           pew.play();
           fire = true;
           
         }
         
         //where bullet spawns
         if(bulletX < 0 - bullet.width - 500){
           bulletX = x - bullet.width;
           fire = false;
         }
         
         if(bulletX > width + 1000){
           bulletX = x + character.width;
           fire = false;
         }
         
      }
      
      //if type 4
      if(type == 4){
        
        //spawn nork once you pass x 250
        if(x < 250 && !spawnNork){
         
          spawnNork = true;
          
        }
        
        if(player.x+player.character.width - 50 >= x && player.x + 50 <= x+character.width && (player.y >= y - 150 && player.y+player.character.height <= y + character.height + 179) && hp > 0){
       
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        
        }
        
        //every 65 frames move forward
        if(frameCount % 65 == 0){
           x+=speed;
           vineboom.play();
        }
        
      }
      /*
      if(type == 5){
        //x+=speed;
        
        if(player.x+player.character.width - 50 >= x && player.x + 50 <= x+character.width && (player.y >= y - 50 && player.y+player.character.height <= y + character.height + 160) && hp > 0 && !player.mounted){
       
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            
          }
        
        }
        
        
        
        //if(player.x+player.character.width - 18 >= x && player.x - 75 <= x+character.width && (player.y + 45 >= y - 50 && player.y + 484 <= y + character.height + 160 ) && hp > 0 && player.mounted){
          
          //player.takeDamage(dmg);
          //if(!playerHit.isPlaying()){
            
            //playerHit.play();
            //println("1");
            
          //}
        //}
        
        if(player.x + 500 - 95 > x && player.x + 90 < x + 200 && (player.y + 500 - 80 > y && player.y + 50 < y + 200)&& hp > 0 && player.mounted){
          player.takeDamage(dmg);
          if(!playerHit.isPlaying()){
            
            playerHit.play();
            //println("2");
            
          }
        }
        
        
        
        
      }
      */
    
    //check hitbox of player and deal damage to enemies
     if(player.flakAttack1X+player.flakAttack1.width - 50 > x && player.flakAttack1X + 50 < x + character.width && (player.flakAttack1Y > y-92 && player.flakAttack1Y+player.flakAttack1.height < y+character.height+162) && flakAttacked1){
       
        if(type == 4){
          hp-=player.damage/20;
          score+=player.damage/20;
        }
        else{
          hp-=player.damage;
          score+=player.damage;
        }
        
        if(!hit.isPlaying()){
          hit.play();
        }
      }
      
      //nork attack
      if(ayX+ayAttack.width - 50 > x && ayX + 50 < x + character.width && (ayY > y-92 && ayY+ayAttack.height < y+character.height+162)){
       
        
        hp-=35;
        
        
        if(!hit.isPlaying()){
          hit.play();
        }
      }
      
      if(player.norkAttack1X+player.norkAttack1.width - 50 > x && player.norkAttack1X + 50 < x + character.width && (player.norkAttack1Y > y-92 && player.norkAttack1Y+player.norkAttack1.height < y+character.height+162) && norkAttacked1){
       
        if(type == 4){
          hp-=2*player.damage;
        }
        else{
          hp-= 2*player.damage;
          score+= 2*player.damage;
        }
        
        if(!hit.isPlaying()){
          hit.play();
        }
      }
    
    }
    //if they are dead
    else{
       if(!deathSoundPlayed){
         //play sound
         enemyDead.play();
         deathSoundPlayed = true;
         
         
       }
       
       
       
    }
    
  }
  
}
