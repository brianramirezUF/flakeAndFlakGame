//Brian Ramirez
//Version Alpha 1.0


//imports
import processing.video.*;
import processing.sound.*;


//initialization/declaration of everything p much
Movie myMovie;
Movie opening;
SoundFile theme;
SoundFile boss;
SoundFile flakAttack1Audio;
SoundFile pew;
SoundFile hit;
SoundFile enemyDead;
SoundFile playerHit;
SoundFile menuClick;
SoundFile sadmusic;
SoundFile vineboom;
SoundFile ay;
SoundFile sans;
SoundFile imTheKing;
SoundFile terraria;

boolean skipped = false;
boolean onMenu = false;
boolean onOptions = false;
boolean onGame = false;
boolean onScene1 = false;
boolean onScene2 = false;
boolean onScene3 = false;
boolean onScene4 = false;
boolean flakAttacked1 = false;
boolean stageClear = false;
boolean interact = false;
boolean norkInteractDone = false;
boolean norkAttacked1 = false;
boolean timeReset = false;
boolean kingDead = false;
boolean hardcore = true;


boolean test = false;

PImage currentImage;
PImage menu;
PImage options;
PImage scene1, scene2, scene3 , scene4;
PImage e;
PImage flaktext;
PImage flaktext2;
PImage norktext;
PImage lives;
PImage throne;
PImage flaketext;
PImage flaketext2;
PImage win;

int activeMsg = 0;


PImage nork;
float cutnorkX, cutnorkY, ayX, ayY;
boolean norkCutPos = false;
PImage ayAttack;

Player player;
Enemy enemy1;
Enemy enemy2;
Enemy enemy3;
Enemy enemy4;
Enemy enemy5;
Enemy enemy6;


float stage4Start = 0;

Enemy king;
Enemy enemy7, enemy8, enemy9;
Enemy enemy10, enemy11, enemy12;

float gravity = .5;
float ground = 500;
float score = 0;


//setup
//where i set stuff up
void setup(){
  
size(1280,720);
background(255);

myMovie = new Movie(this, "intro.mp4");
myMovie.play();
myMovie.speed(1);
myMovie.volume(0.1);

opening = new Movie(this, "theme.mp4");


theme = new SoundFile(this, "theme.wav");
boss = new SoundFile(this, "boss music.mp3");
flakAttack1Audio = new SoundFile(this, "flakattack1.wav");
pew = new SoundFile(this, "bullet.wav");
hit = new SoundFile(this, "hit.wav");
enemyDead = new SoundFile(this, "legodeath.wav");
playerHit = new SoundFile(this, "minecrafthit.wav");
menuClick = new SoundFile(this, "click.wav");
sadmusic = new SoundFile(this, "sadmusic.wav");
vineboom = new SoundFile(this, "vineboom.wav");
ay = new SoundFile(this, "ay.wav");
sans = new SoundFile(this, "sans.wav");
imTheKing = new SoundFile(this, "imtheking2.wav");
terraria = new SoundFile(this, "terraria.wav");

textAlign(CENTER);
textSize(80);
colorMode(HSB, 360, 100 ,100);
fill(0,86,86);

menu = loadImage("mainmenu.png");
options = loadImage("options.png");
scene1 = loadImage("scene1.png");
scene2 = loadImage("scene2.png");
scene3 = loadImage("scene3.png");
scene4 = loadImage("scene4.png");
currentImage = scene1;

lives = loadImage("lives3.png");
e = loadImage("presse.png");
flaktext = loadImage("flaktextbox.png");
flaktext2 = loadImage("flaktextbox2.png");
norktext = loadImage("norktextbox.png");
throne = loadImage("throne.png");
flaketext = loadImage("flaketextbox.png");
flaketext2 = loadImage("flaketextbox2.png");
win = loadImage("win.png");

nork = loadImage("nork.png");
cutnorkX = width;
cutnorkY = 500-200;
ayAttack = loadImage("ayflipped.png");


player = new Player(100, 15, 1);
king = new Enemy(1000,8,5,width - 200, 170, "king", 5);
enemy1 = new Enemy(100,8,5,width-50,500,"evilcatface", 1);
enemy2 = new Enemy(100,30,2,width-100,500,"evilcatfacegun", 2);
enemy3 = new Enemy(225,10,20,width-50,500,"evilangrycatface", 1);
enemy4 = new Enemy(100,8,5,width-300,500,"evilcatface", 1);
enemy5 = new Enemy(75,30,2,200,150,"evilcatfacegunflipped",3);
enemy6 = new Enemy(1000,20,500,width-50-200,500-200,"evilcatfacebrute",4);


enemy7 = new Enemy(0,30,2,-199,500,"evilcatfacegunflipped",3);
enemy8 = new Enemy(0,35,1,0,500,"evilcatfacegunflipped",3);
enemy9 = new Enemy(0,25,3,width-200,500,"evilcatfacegun",2);

enemy10 = new Enemy(0,10,12,width-100,500,"evilangrycatface", 1); 
enemy11 = new Enemy(0,12,12,width-25,500,"evilangrycatface", 1);
enemy12 = new Enemy(0,8,5,width-50,500,"evilcatface", 1);

enemy7.deathSoundPlayed = true;
enemy8.deathSoundPlayed = true;
enemy9.deathSoundPlayed = true;
enemy10.deathSoundPlayed = true;
enemy11.deathSoundPlayed = true;
enemy12.deathSoundPlayed = true;

}

//draw which loops game
void draw(){
  
  
  //play video if user hasnt skipped
  if(!skipped){
    image(myMovie,0,0, width, height);
  }
  
  //tell them they can skip until frame 75
  if(frameCount < 75){
    text("CLICK ANYWHERE TO SKIP", width/2, height /2);
  }
  
  //if they havent skipped but they press m1, it skips
  if(mousePressed && !skipped){
    
    //plays click sounds if it isnt playing
    if(!menuClick.isPlaying()){
       
        menuClick.play();
        
    }
    
    myMovie.stop();
    skipped = true;
    onMenu = true;
    
    
  }
  
  //if they dont skip and video ends, mark as skip so that we can go to menu
  if(myMovie.time() >= myMovie.duration()-3.4 && !skipped){
    myMovie.stop();
    skipped = true;
    onMenu = true;
  }
  
  //if skipped or video ended
  if(skipped){
    
    //and on the menu
    if(onMenu){
      
      //show the menu and loop video in corner
      background(menu);
      opening.loop();
      if(!(theme.isPlaying())){
        //theme.loop();
        //opening.loop();
      }
      
      image(opening, 15, 480, 384, 216);
    }
    
    //if user clicked the play button
    if((mouseX >= 456 && mouseX <= 850) && (mouseY >= 469 && mouseY <= 569) && mousePressed && onMenu){
      //play
      if(!menuClick.isPlaying()){
       
        //reset all values to default and start the game
        menuClick.play();
        
        onMenu = false;
        opening.stop();
        onGame = true;
        background(scene1);
        player.display();
        currentImage = loadImage("scene1.png");
        onScene1 = true;
        onScene2 = false;
        onScene3 = false;
        onScene4 = false;
        player.lives = 3;
        player.hp = 100;
        player.x = 100;
        player.y = 500;
        //player.damage = 200;
        player.speed = 15;
        enemy1.hp = 100;
        enemy1.x = width-50;
        enemy1.y = 500;
        enemy2.hp = 100;
        enemy2.x = width-100;
        enemy2.y = 500;
        enemy3.hp = 225;
        enemy3.x = width - 50;
        enemy3.y = 500;
        enemy4.hp = 100;
        enemy4.x = width-300;
        enemy4.y = 500;
        enemy5.hp = 75;
        enemy6.hp = 1000;
        enemy6.x = width-50-200;
        enemy6.y = 500-200;
        enemy6.spawnNork = false;
        norkCutPos = false;
        cutnorkX = width;
        cutnorkY = 500-200;
        ayX = width + 500;
        ayY = cutnorkY;
        lives = loadImage("lives3.png");
        player.mounted = false;
        ground = 500;
        norkInteractDone = false;
        interact = false;
        norkCutPos = false;
        kingDead = false;
        king.hp = 1000;
        enemy7.hp = 0;
        enemy8.hp = 0;
        enemy9.hp = 0;
        enemy10.hp = 0;
        enemy11.hp = 0;
        enemy12.hp = 0;
        
        enemy1.deathSoundPlayed = false;
        enemy2.deathSoundPlayed = false;
        enemy3.deathSoundPlayed = false;
        enemy4.deathSoundPlayed = false;
        enemy5.deathSoundPlayed = false;
        enemy6.deathSoundPlayed = false;
        king.deathSoundPlayed = false;
        enemy7.deathSoundPlayed = true;
        enemy8.deathSoundPlayed = true;
        enemy9.deathSoundPlayed = true;
        enemy10.deathSoundPlayed = true;
        enemy11.deathSoundPlayed = true;
        enemy12.deathSoundPlayed = true;
        
        score = 0;
        
      }
      
    }
    
    //if user clicks quit, close the game
    if((mouseX >= 456 && mouseX <= 851) && (mouseY >= 603 && mouseY <= 697) && (mousePressed) && onMenu){
      //quit
      if(!menuClick.isPlaying()){
       
        menuClick.play();
        
        exit();
      }
      
      
      
    }
    
    //if user clicks settings, go to settings
    if((mouseX >= 1180 && mouseX <= 1268) && (mouseY >= 626 && mouseY <= 706) && mousePressed && onMenu){
      //settings
      if(!menuClick.isPlaying()){
       
        menuClick.play();
      
        onMenu = false;
        onOptions = true;
        background(options);
        
      }
      
    }
    
    //if user clicks back from settings, go back to menu
    if((mouseX >= 8 && mouseX <= 235) && (mouseY >= 603 && mouseY <= 703) && mousePressed && onOptions){
      //settings back to menu
      
      if(!menuClick.isPlaying()){
       
        menuClick.play();
        
        onMenu = true;
        onOptions = false;
        background(options);
        
      }
      
    }
    
    //if options menu open, show text for difficulty
    if(onOptions){
      background(options);
      fill(0);
      textSize(40);
      if(hardcore){
       
        text("Hardcore", 700, 270);
        
        
      }
      else{
        
        text("ez", 660, 270); 
        
      }
    }
    
    
    //if on options and user presses ez mode, change difficulty
    if((mouseX >= 342 && mouseX <= 533) && (mouseY >= 298 && mouseY <= 376) && (mousePressed) && onOptions){
      
      if(!menuClick.isPlaying()){
       
        menuClick.play();
        
        hardcore = false;
        
        player.damage = 1.5;
      }
      
      
      
    }
    
    //if on options and user presses hard more, change difficulty
    if((mouseX >= 622 && mouseX <= 946) && (mouseY >= 288 && mouseY <= 371) && (mousePressed) && onOptions){
      
      if(!menuClick.isPlaying()){
       
        menuClick.play();
        
        hardcore = true;
        
        player.damage = 1;
      }
      
      
      
    }
    
    
    //if on the game (after clicked play)
    if(onGame){
      
      //display background,player,gui etc
      background(currentImage);
      player.display();
      
      image(lives,10,height-10-lives.height);
      
      fill(0);
      text("Score: " + score, width/2, 30);
      
      //if player hp goes down to 0, fill it back up and take a life away
      if(player.hp <= 0){
       
        player.lives -= 1;
        player.hp = 100;
        if(player.lives >= 0){
          lives = loadImage("lives"+player.lives+".png");
        }
        if(player.mounted){
          player.hp = 1000; 
        }
      }
      
      //if player runs out of lives, end game and go back to menu
      if(player.lives <= 0){
       
        onGame = false;
        onMenu = true;
        onScene1 = false;
        onScene2 = false;
        onScene3 = false;
        onScene4 = false;
        
      }
      
      
      //if player is not mounted
      //check what scene they are on and change it if they go to the sides
      if(!player.mounted){
        if(player.x > width-50 && stageClear){
          
          if(onScene1){
            player.x = -50;
            currentImage = loadImage("scene2.png");
            onScene1 = false;
            onScene2 = true;
          }
          else if(onScene2){
            player.x = -50;
            currentImage = loadImage("scene3.png");
            onScene2 = false;
            onScene3 = true;
          }
          else if(onScene3){
            player.x = -50;
            currentImage = loadImage("scene4.png");
            onScene3 = false;
            onScene4 = true;
            stage4Start = frameCount;
          }
          else if(onScene4){
            player.x = width-50;
          }
          
          stageClear = false;
          
        }
        else if(player.x > width-150 && !stageClear){
         
          player.x = width-150;
          
          
        }
        
        if(player.x < -50 && stageClear){
          if(onScene1){
            player.x = -50;
          }
          else if(onScene2){
            player.x = width-150;
            currentImage = loadImage("scene1.png");
            onScene1 = true;
            onScene2 = false;
          }
          else if(onScene3){
            player.x = width-150;
            currentImage = loadImage("scene2.png");
            onScene2 = true;
            onScene3 = false;
          }
          else if(onScene4){
            player.x = width-150;
            currentImage = loadImage("scene3.png");
            onScene3 = true;
            onScene4 = false;
          }
          
        }
        else if(player.x <-50 && !stageClear){
           player.x = -50;
        }
      }
      //if player is not mounted, do the same
      //the reason they are different is because when mounted the hitbox is different
      else{
        if(player.x > width-300 && stageClear){
          
          if(onScene1){
            player.x = -300;
            currentImage = loadImage("scene2.png");
            onScene1 = false;
            onScene2 = true;
            //println("1");
          }
          else if(onScene2){
            player.x = -300;
            currentImage = loadImage("scene3.png");
            onScene2 = false;
            onScene3 = true;
            //println("2");
          }
          else if(onScene3){
            player.x = -300;
            currentImage = loadImage("scene4.png");
            onScene3 = false;
            onScene4 = true;
            stage4Start = frameCount;
            //println("3");
          }
          else if(onScene4){
            player.x = width-300;
            //println("4");
          }
          
          stageClear = false;
          
        }
        else if(player.x > width-300 && !stageClear){
         
          player.x = width-300;
          
          
        }
        
        if(player.x + player.character.width < 250 && stageClear){
          if(onScene1){
            player.x = 250 - 500;
            //println("1");
          }
          else if(onScene2){
            player.x = width-300;
            currentImage = loadImage("scene1.png");
            onScene1 = true;
            onScene2 = false;
            //println("2");
          }
          else if(onScene3){
            player.x = width-300;
            currentImage = loadImage("scene2.png");
            onScene2 = true;
            onScene3 = false;
            //println("3");
          }
          else if(onScene4){
            player.x = width-300;
            currentImage = loadImage("scene3.png");
            onScene3 = true;
            onScene4 = false;
            //println("4");
          }
          
        }
        else if(player.x + player.character.width < 250 && !stageClear){
           player.x = 250 - 500;
        }
        
        
        
        
        
        
      }
    }
    
    //if currenlty on scene 1
    if(onScene1){
      //display scene 1 enemies
      enemy1.display();
      enemy2.display();
      
      //if enemies are dead, player can move stages
      if(enemy1.hp <= 0 && enemy2.hp <= 0){
       
        stageClear = true;
        
      }
      
    }
    
    //same as scene 1
    if(onScene2){
     
      enemy3.display();
      enemy4.display();
      enemy5.display();
      
      if(enemy3.hp <= 0 && enemy4.hp <= 0 && enemy5.hp <= 0){
       
        stageClear = true;
        
      }
      
    }
    
    //if enemies are dead, player can move stages
    if(onScene3){
      
      enemy6.display();
      
      //if enemy 6 is dead
      if(enemy6.hp <= 0){
       
        //and norks in his cutscene position
        if(norkCutPos){
           
          // and user is interacting
          if(interact){
            
            //depending on the current activeMsg, display text and textbox
            if(activeMsg == 1){
              image(flaktext, 0, 0);
              fill(0);
              text("Who are you?", width/2, 160);
            }
            
            if(activeMsg == 2){
              image(norktext, 0 ,0); 
              fill(0);
              text("I'm nork by the way", width/2, 160);
            }
            
            if(activeMsg == 3){
              image(flaktext, 0, 0);
              fill(0);
              text("That's literally what I just asked", width/2, 160);
            }
            
            if(activeMsg == 4){
              image(norktext, 0 ,0); 
              fill(0);
              text("They call it the flak eater", width/2, 160);
            }
            
            if(activeMsg == 5){
              image(flaktext, 0, 0);
              fill(0);
              text("HEY THATS MY LINE!", width/2, 160);
            }
            
            if(activeMsg == 6){
              image(norktext, 0 ,0); 
              fill(0);
              text("...", width/2, 160);
            }
            
            if(activeMsg == 7){
              image(flaktext, 0 ,0); 
              fill(0);
              text("Have you seen my flake by any chance?", width/2, 160);
            }
            
            if(activeMsg == 8){
              image(norktext, 0 ,0); 
              fill(0);
              text("What does he look like?", width/2, 160);
            }
            
            if(activeMsg == 9){
              image(flaktext2, 0 ,0); 
              fill(0);
              text("Kinda like this", width/2, 160);
            }
            
            if(activeMsg == 10){
              image(norktext, 0 ,0); 
              fill(0);
              text("I think I saw him like an hour ago", width/2, 160);
              //text("hour ago", width/2, 185);
            }
            
            if(activeMsg == 11){
              image(flaktext, 0 ,0); 
              fill(0);
              text("...", width/2, 160);
            }
            
            if(activeMsg == 12){
              image(norktext, 0 ,0); 
              fill(0);
              text("...", width/2, 160);
            }
            
            if(activeMsg == 13){
              image(flaktext, 0 ,0); 
              fill(0);
              text("Is that all...? Or..", width/2, 160);
            }
            
            if(activeMsg == 14){
              image(norktext, 0 ,0); 
              fill(0, 70, 85);
              text("We don't talk about Part 2.", width/2, 160);
            }
            
            if(activeMsg == 15){
              image(flaktext, 0 ,0); 
              fill(0);
              text("Can you help me out?", width/2, 160);
            }
            
            if(activeMsg == 16){
              image(norktext, 0 ,0); 
              fill(0);
              text("Ye ye, hop on by pressing: X", width/2, 150);
              text("I'll attack when you press: ", width/2, 180);
              text("Right Mouse Button", width/2, 210);
            }
            
            
            
          }
          //if you havent interacted with nork
          else{
            if(!norkInteractDone){
              //show "press e to interact"
              image(e, cutnorkX-215, cutnorkY);
            }
          }
          
        }
        
      }
      
      //if enemy6 can spawnNork and player is not mounted
      if(enemy6.spawnNork && !player.mounted){
        //spawn and show nork
        image(nork, cutnorkX, cutnorkY);
        
        //move him towards his final position
        if(cutnorkX > width-300-200){
          cutnorkX -= 5;
        }
        else if(!norkCutPos){
          norkCutPos = true;
          ay.play();
          ayX = cutnorkX - ayAttack.width;
          ayY = cutnorkY + 100;
        }
        
        //if in his final position
        if(norkCutPos && !player.mounted){
         
          //move his attack towards the enemy
          image(ayAttack, ayX, ayY);
          
          ayX -= 5;
          
        }
        
      }
      
      //if already interacted with nork and the enemy is dead you can move on
      if(enemy6.hp <= 0 && norkInteractDone){
       
        stageClear = true;
        
      }
      
    }
    
    //if on scene 4
    if(onScene4){
      
      //stageClear = true;
      
      //display king and enemies
      king.display();
      //image(throne,width-200, 120);
      enemy7.display();
      enemy8.display();
      enemy9.display();
      enemy10.display();
      enemy11.display();
      enemy12.display();
      
      //println(frameCount - stage4Start);
      
      //if all enemies are dead, but king is alive and time has not been reset
      if(enemy7.hp <= 0 && enemy8.hp <= 0 && enemy9.hp <= 0 && enemy10.hp <= 0 && enemy11.hp <= 0 && enemy12.hp <= 0 && !timeReset && king.hp > 0){
        //store current time and say that time has been reset
        stage4Start = frameCount;
        timeReset = true;
      }
      
      //if all enemies are dead, but king is alive, check if 300 seconds have passed since the last wipe out of enemies
      if(enemy7.hp <= 0 && enemy8.hp <= 0 && enemy9.hp <= 0 && enemy10.hp <= 0 && enemy11.hp <= 0 && enemy12.hp <= 0 && (frameCount - stage4Start + 1) % 300 == 0 && king.hp > 0){
        
        //restore all enemies and respawn them
        imTheKing.play();
        enemy7.deathSoundPlayed = false;
        enemy8.deathSoundPlayed = false;
        enemy9.deathSoundPlayed = false;
        enemy10.deathSoundPlayed = false;
        enemy11.deathSoundPlayed = false;
        enemy12.deathSoundPlayed = false;
        
        enemy7.hp = 75;
        enemy7.x = -200;
        enemy7.moving = true;
        enemy8.hp = 75;
        enemy8.x = -200;
        enemy8.moving = true;
        enemy9.hp = 75;
        enemy9.x = width;
        enemy9.moving = true;
        
        enemy10.hp = 125;
        enemy10.x = width;
        enemy11.hp = 125;
        enemy11.x = width;
        enemy12.hp = 100;
        enemy12. x = width;
        
        timeReset = false;
        
      }
      
      //when enemies 7, 8, and 9 spawn
      //move them to their location from the edge
      //and once in position they can attack
      
      if(enemy7.hp > 0 && enemy7.x < 0){
      
        enemy7.x += 2;
      
      }
      else if(enemy7.moving){
        
        enemy7.moving = false;
        enemy7.bulletX = enemy7.x - enemy7.bullet.width;
      }
      
      if(enemy8.hp > 0 && enemy8.x < -50){
      
        enemy8.x += 2;
      
      }
      else if(enemy8.moving){
        
        enemy8.moving = false;
        enemy8.bulletX = enemy8.x - enemy8.bullet.width;
      }
      
      if(enemy9.hp > 0 && enemy9.x > width - 200){
        
        enemy9.x -= 2;
      
      }
      else if(enemy9.moving){
        
        enemy9.moving = false;
        enemy9.bulletX = enemy9.x - enemy9.bullet.width;
      }
      
      //if the king is dead
      if(!kingDead && king.hp <= 0){
        //display the dead king
        kingDead = true;
        currentImage = loadImage("scene4noking.png");
        
      }
      
      //once all enemies and king are dead
      //display interaction menu
      if(kingDead && enemy7.hp <= 0 && enemy8.hp <= 0 && enemy9.hp <= 0 && enemy10.hp <= 0 && enemy11.hp <= 0 && enemy12.hp <= 0 && !interact){
       
        image(e, width/2 - 100, 50);
        
      }
      
      //if in interaction menu
      if(interact){
       
        //show dialogue depending on which msg is active
        if(activeMsg == 1){
          image(flaktext, 0, 0);
          fill(0);
          text("Flake???", width/2, 160);
          
        }
        
        if(activeMsg == 2){
          image(flaketext, 0, 0);
          fill(0);
          text("tik tik tik", width/2, 160);
          
        }
        
        if(activeMsg == 3){
          image(flaktext, 0, 0);
          fill(0);
          text("How u been holding up flake", width/2, 160);
          
        }
        
        if(activeMsg == 4){
          image(flaketext, 0, 0);
          fill(0);
          text("ur mum", width/2, 160);
          
        }
        
        if(activeMsg == 5){
          image(flaketext, 0, 0);
          fill(0);
          text("i didn't mean it", width/2, 160);
          
        }
        
        if(activeMsg == 6){
          image(flaketext2, 0, 0);
          fill(0);
          text("don't mind him, he's still stuck on Part 1", width/2, 160);
          
        }
        
        if(activeMsg == 7){
          image(flaktext, 0, 0);
          fill(0);
          text("Bamanos flake", width/2, 160);
          
        }
        
        if(activeMsg == 8){
          image(flaketext, 0, 0);
          fill(0);
          text("k", width/2, 160);
          
        }
        
        if(activeMsg == 9){
          image(win, 0, 0);
          
        }
        
        
        
      }
      
    }
    
    
    //depending on the scene, play music
    if(onScene1 || onScene2){
      if(!(terraria.isPlaying())){
        terraria.loop();
      }
    }
    else{
      if((terraria.isPlaying())){
        terraria.loop();
      }
    }
    
    if(onScene3){
      if(!(sadmusic.isPlaying())){
        sadmusic.loop();
      }
    }
    else{
      if((sadmusic.isPlaying())){
        sadmusic.loop();
      }
    }
    
    if(onScene4){
      if(!(boss.isPlaying())){
        boss.loop();
      } 
    }
    else{
      if((boss.isPlaying())){
        boss.loop();
      }
    }
        
    
    //println("X: " + mouseX + " Y: " + mouseY);
    //println("Player X: " + player.x + " Player Y: " + player.y);
    //println("Player Width: " + (player.x + player.character.width) + " Player Height: " + (player.y - player.character.height));
    
  }
  
}

//to play videos
void movieEvent(Movie m){
  m.read(); 
}

//when a key is pressed
void keyPressed()
{
  //check if in game
  if(onGame){
    //depending on key change direction value
    if(key == 'd' || key == 'D'){
       player.right = 1;
       player.direction = 1;
    }
      
    if(key == 'a' || key == 'A'){
       player.left = -1;
       player.direction = -1;
    }
    
    if(key == ' '){
       player.up = -1;
    }
    
    //was just test
    if(key == 'p'){
      test = true; 
    }
    
    //if in range of nork interaction and cutscene ended
    if(enemy6.hp <= 0 && norkCutPos && !norkInteractDone){
      if(player.x > cutnorkX-450 && player.x + player.character.width <= cutnorkX+250){
        
        if(key == 'e' && interact == false){
          //begin interaction
           interact = true;
           activeMsg = 1;
           sans.play();
        }
        
      }
      
    }
    
    //if interaction finished
    if(norkInteractDone){
      if(player.x > cutnorkX-200 && player.x + player.character.width <= width + 100){
        
        //and user presses x
        if(key == 'x' && !player.mounted){
          
          //mount nork
          player.mounted = true;
          player.x = cutnorkX;
          player.y = cutnorkY - 100;
          ground -= 300;
          player.speed *= 0.8;
          player.hp = 1000;
          
        }
        
      }
      
      
    }
    
    //if all scene 4 enemies are dead
    if(kingDead && enemy7.hp <= 0 && enemy8.hp <= 0 && enemy9.hp <= 0 && enemy10.hp <= 0 && enemy11.hp <= 0 && enemy12.hp <= 0){
     
      //and e is pressed on scene 4
      if(key == 'e' && onScene4){
        
        //begin interaction
        interact = true;
        activeMsg = 1;
        sans.play();
        
      }
    }
    
  }
  
}

//if keys are released
void keyReleased()
{
  //reset movement values
  if(onGame){
    if(key == 'd' || key == 'D'){
       player.right = 0;
    }
      
    if(key == 'a' || key == 'A'){
       player.left = 0;
    }
    
    if(key == ' '){
       player.up = 0;
    }
    
    if(key == 'p'){
      test = false; 
    }
    
    if(key == 'e'){
       
    }
    
  }
  
}

//if mouse is pressed
void mousePressed(){
  
  //if on game and NOT interacting, play sounds and attack in a direction
  if(onGame && !interact){
    //flak attack
    if(!flakAttacked1 && mouseButton == LEFT && !player.mounted){
      flakAttacked1 = true;
      flakAttack1Audio.play();
      player.flakAttack1Y = player.y;
      
      if(player.direction == 1){
        player.flakAttack1 = loadImage("flakattack1.png");
        player.flakAttack1X = player.x+player.character.width-15;
        player.flakAttack1Direction = 1;
      }
      else if(player.direction == -1){
        player.flakAttack1 = loadImage("flakattack1flipped.png");
        player.flakAttack1X = player.x-player.character.width+25;
        player.flakAttack1Direction = -1;
      }
      
    }
    
    //flak attack when mounted
    if(!flakAttacked1 && mouseButton == LEFT && player.mounted){
      flakAttacked1 = true;
      flakAttack1Audio.play();
      player.flakAttack1Y = player.y + 50;
      
      if(player.direction == 1){
        player.flakAttack1 = loadImage("flakattack1.png");
        player.flakAttack1X = player.x+player.character.width-160;
        player.flakAttack1Direction = 1;
      }
      else if(player.direction == -1){
        player.flakAttack1 = loadImage("flakattack1flipped.png");
        player.flakAttack1X = player.x-player.character.width+480;
        player.flakAttack1Direction = -1;
      }
      
    }
    
    //nork attack
    if(!norkAttacked1 && mouseButton == RIGHT && player.mounted){
      norkAttacked1 = true;
      ay.play();
      player.norkAttack1Y = player.y + 250;
      
      if(player.direction == 1){
        player.norkAttack1 = loadImage("ay.png");
        player.norkAttack1X = player.x+player.character.width - 20;
        player.norkAttack1Direction = 1;
      }
      else if(player.direction == -1){
        player.norkAttack1 = loadImage("ayflipped.png");
        player.norkAttack1X = player.x -player.character.width+340;
        player.norkAttack1Direction = -1;
      }
      
    }
    
  }
  
}

//when mouse is released
void mouseReleased(){
  
  //if on interact menu
  //make sound depending on which msg is active
  if(interact){
   
    menuClick.play();
    //16 12 11 6
    if(onScene3){
      if(activeMsg != 16 && activeMsg != 11 && activeMsg != 10 && activeMsg != 5){
        sans.play();
      }
    }
    
    if(onScene4){
      
      if(activeMsg != 8 && activeMsg != 9){
        sans.play();
      }
      
    }
  }
  
  //if on scene 4
  if(onScene4){
    
    //and final msg
    if(interact && activeMsg == 9){
      
      //end game
      activeMsg = 0;
      interact = false;
      player.lives = 0;
      
    }
  
  //change interact msg up 1 each time
  
    if(interact && activeMsg == 8){
        
        activeMsg = 9;
        
      }
    
    if(interact && activeMsg == 7){
      
      activeMsg = 8;
      
    }
    
    if(interact && activeMsg == 6){
      
      activeMsg = 7;
      
    }
    
    if(interact && activeMsg == 5){
      
      activeMsg = 6;
      
    }
    
    if(interact && activeMsg == 4){
      
      activeMsg = 5;
      
    }
    
    if(interact && activeMsg == 3){
      
      activeMsg = 4;
      
    }
    
    if(interact && activeMsg == 2){
      
      activeMsg = 3;
      
    }
    
    if(interact && activeMsg == 1){
      
      activeMsg = 2;
      
    }  
    
    
    
    
    
    
  }
  
  //if on scene3
  if(onScene3){
    //and final msg
    if(interact && activeMsg == 16){
      //end interaction
      activeMsg = 0;
      interact = false;
      norkInteractDone = true;
      
    }
    
    //activemsg goes up one each time
    if(interact && activeMsg == 15){
      
      activeMsg = 16;
      
    }
    
    if(interact && activeMsg == 14){
      
      activeMsg = 15;
      
    }
    
    if(interact && activeMsg == 13){
      
      activeMsg = 14;
      
    }
    
    if(interact && activeMsg == 12){
      
      activeMsg = 13;
      
    }
    
    if(interact && activeMsg == 11){
      
      activeMsg = 12;
      
    }
    
    if(interact && activeMsg == 10){
      
      activeMsg = 11;
      
    }
    
    if(interact && activeMsg == 9){
      
      activeMsg = 10;
      
    }
   
    if(interact && activeMsg == 8){
      
      activeMsg = 9;
      
    }
    
    if(interact && activeMsg == 7){
      
      activeMsg = 8;
      
    }
    
    if(interact && activeMsg == 6){
      
      activeMsg = 7;
      
    }
    
    if(interact && activeMsg == 5){
      
      activeMsg = 6;
      
    }
    
    if(interact && activeMsg == 4){
      
      activeMsg = 5;
      
    }
    
    if(interact && activeMsg == 3){
      
      activeMsg = 4;
      
    }
    
    if(interact && activeMsg == 2){
      
      activeMsg = 3;
      
    }
    
    if(interact && activeMsg == 1){
      
      activeMsg = 2;
      
    }
  }
  
  
}
