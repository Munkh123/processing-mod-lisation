/*
Classe pour créer les murs, le plafond, les fenetres et les chauffages
*/
class Salle{
  PShape creerSalle() {
    PShape murs = createShape();
    PShape sol = createShape();
    PShape plafond = createShape();
    PShape groupe = createShape(GROUP);    
    float coordonnees = 150;
    
    murs.beginShape(QUADS);
    murs.shininess(5);
    murs.emissive(0, 0, 0);
    murs.fill(color(#787565));
    murs.vertex(-coordonnees*3, -coordonnees, coordonnees);
    murs.vertex( coordonnees, -coordonnees, coordonnees, 0, 1);
    murs.vertex( coordonnees, coordonnees, coordonnees, 1, 1 );
    murs.vertex(-coordonnees*3, coordonnees, coordonnees, 1, 0);
    murs.fill(color( #787565));
    murs.vertex(coordonnees, coordonnees, coordonnees, 1, 0);
    murs.vertex(coordonnees, coordonnees, -coordonnees*5, 1, 1);
    murs.vertex(coordonnees, -coordonnees, -coordonnees*5, 0, 1);
    murs.vertex(coordonnees, -coordonnees, coordonnees, 0, 0);
    murs.fill(color(#787565));
    murs.vertex(coordonnees, -coordonnees, -coordonnees*5, 0, 0);
    murs.vertex(-coordonnees*3, -coordonnees, -coordonnees*5, 0, 1);
    murs.vertex(-coordonnees*3, coordonnees, -coordonnees*5, 1, 1);
    murs.vertex(coordonnees, coordonnees, -coordonnees*5, 1, 0);
    murs.fill(color(#787565));
    murs.vertex(-coordonnees*3, -coordonnees, -coordonnees*5, 0, 0);
    murs.vertex(-coordonnees*3, -coordonnees, coordonnees, 0, 1);
    murs.vertex(-coordonnees*3, coordonnees, coordonnees, 1, 1);
    murs.vertex(-coordonnees*3, coordonnees, -coordonnees*5, 1, 0);
    murs.fill(color(#787565));
    murs.vertex(-coordonnees*3, -coordonnees-1, -coordonnees*5, 0, 0);
    murs.vertex(coordonnees, -coordonnees-1, -coordonnees*5, 0, 1);
    murs.vertex(coordonnees, -coordonnees-1, coordonnees, 1, 1);
    murs.vertex(-coordonnees*3, -coordonnees-1, coordonnees, 1, 0);
    murs.endShape();
    
    sol.beginShape(QUADS);
    sol.shininess(5);
    sol.emissive(0, 0, 0);
    sol.fill(color(#382211));
    sol.vertex(-coordonnees*3, coordonnees, coordonnees, 0, 0);
    sol.vertex(coordonnees, coordonnees, coordonnees, 0, 1);
    sol.vertex(coordonnees, coordonnees, -coordonnees*5, 1, 1);
    sol.vertex(-coordonnees*3, coordonnees, -coordonnees*5, 1, 0);
    sol.endShape();

    PImage image = loadImage("data/plafond.png");
    plafond.beginShape(QUADS); 
    plafond.textureMode(NORMAL);
    plafond.texture(image);
    plafond.shininess(5);
    plafond.emissive(0, 0, 0);
    plafond.vertex(-coordonnees*3, -coordonnees, -coordonnees*5, 0, 0);
    plafond.vertex(coordonnees, -coordonnees, -coordonnees*5, 0, 1);
    plafond.vertex(coordonnees, -coordonnees, coordonnees, 1, 1);
    plafond.vertex(-coordonnees*3, -coordonnees, coordonnees, 1, 0);
    plafond.endShape();
    
    groupe.addChild(sol);
    groupe.addChild(murs);
    groupe.addChild(plafond);
    return groupe;
  }

  PShape fenetres() {
    PShape groupe = createShape(GROUP);
    PImage image = loadImage("data/fenetre.png");
    PImage image2 = loadImage("data/rideau.jpg");

    PShape fenetre = createShape();
    float coordonnees = 100;
    //fenetre
    fenetre.beginShape(QUADS);
    fenetre.textureMode(NORMAL);
    fenetre.texture(image);
    fenetre.shininess(30);
    fenetre.emissive(0, 0, 0);
    fenetre.vertex(coordonnees-2, -coordonnees*3/4, -coordonnees*7.5, 0, 0);
    fenetre.vertex(coordonnees-2, -coordonnees*3/4, coordonnees, 1, 0);
    fenetre.vertex(coordonnees-2, coordonnees*3/4, coordonnees, 1, 1);
    fenetre.vertex(coordonnees-2, coordonnees*3/4, -coordonnees*7.5, 0, 1);
    fenetre.endShape();
    fenetre.translate(50.5, -40, 30);
    groupe.addChild(fenetre);
    
    PShape barreRideau = createShape(BOX, 2,2,860);
    PShape mancheRideau1 = createShape(BOX, 10,2,2);
    PShape mancheRideau2 = createShape(BOX, 10,2,2);
    groupe.addChild(barreRideau);
    groupe.addChild(mancheRideau1);
    groupe.addChild(mancheRideau2);
    barreRideau.translate(135,-120,-295);
    mancheRideau1.translate(135,-120,-715);
    mancheRideau2.translate(135,-120,125);
    
    barreRideau.setFill(color(0)); 
    mancheRideau1.setFill(color(0));    
    mancheRideau2.setFill(color(0)); 
    //rideaux
    int valeur = 0;
    for(int i=1;i<4;i++){
      PShape textureRideau = createShape();
      textureRideau.beginShape(QUADS);
      textureRideau.textureMode(NORMAL);
      textureRideau.texture(image2);
      textureRideau.shininess(30);
      textureRideau.emissive(0, 0, 0);
      textureRideau.vertex(coordonnees/10, -coordonnees/1.3, -coordonnees/2.48, 0, 0);
      textureRideau.vertex(coordonnees/10, -coordonnees/1.3, coordonnees/2.44, 1, 0);
      textureRideau.vertex(coordonnees/10, coordonnees/1.3, coordonnees/2.44, 1, 1);
      textureRideau.vertex(coordonnees/10, coordonnees/1.3, -coordonnees/2.48, 0, 1);
      textureRideau.endShape();
      textureRideau.translate(123,-48,valeur*i);
      groupe.addChild(textureRideau);
      valeur= valeur-110;
    }
    PShape division = createShape(BOX, 10,299,45);
    groupe.addChild(division);
    division.translate(143,0,-454);
    division.setFill(color(#787565));    
    return groupe;
  }
  
  //CHAUFFAGE
  PShape chauffages() {
    PShape groupe = createShape(GROUP);
    float coord = 400;
    PShape chauffage1 = createShape(BOX, 10, 90, 250);
    PShape chauffage2 = createShape(BOX, 10, 90, 148);
    PImage image = loadImage("data/radiateur.png");
    PShape chauffageImage= createShape();
    PShape chauffageImage2 = createShape();
     
    chauffageImage.beginShape(QUADS);
    chauffageImage.textureMode(NORMAL);
    chauffageImage.texture(image);
    chauffageImage.shininess(30);
    chauffageImage.emissive(0, 0, 0);
    chauffageImage.vertex(coord/7, -coord/8.7, -coord/2.22, 0, 0);
    chauffageImage.vertex(coord/7, -coord/8.7, coord/5.7, 1, 0);
    chauffageImage.vertex(coord/7, coord/8.7, coord/5.7, 1, 1);
    chauffageImage.vertex(coord/7, coord/8.7, -coord/2.22, 0, 1);
    chauffageImage.endShape();
    chauffageImage.translate(81.6, 100.5, -45);

    chauffageImage2.beginShape(QUADS);
    chauffageImage2.textureMode(NORMAL);
    chauffageImage2.texture(image);
    chauffageImage2.shininess(30);
    chauffageImage2.emissive(0, 0, 0);
    chauffageImage2.vertex(coord/7, -coord/8.7, -coord/5.10, 0, 0);
    chauffageImage2.vertex(coord/7, -coord/8.7, coord/5.7, 1, 0);
    chauffageImage2.vertex(coord/7, coord/8.7, coord/5.7, 1, 1);
    chauffageImage2.vertex(coord/7, coord/8.7, -coord/5.10, 0, 1);
    chauffageImage2.endShape();
    chauffageImage2.translate(81.6, 100.5, -596);
    
    chauffage1.translate(144, 100, -100);  
    chauffage2.translate(144, 100, -600); 

    groupe.addChild(chauffageImage);
    groupe.addChild(chauffageImage2);
    groupe.addChild(chauffage1);
    groupe.addChild(chauffage2);
    groupe.setFill(color(#9c9c9c));

    return groupe;
  }
  
  PShape portes() {
    PShape groupe = createShape(GROUP);
    PShape porte1 = getPorte();
    PShape porte2 = getPorte();
    porte2.translate(0, 0, -900);
    groupe.addChild(porte1);
    groupe.addChild(porte2);
    return groupe;
  }
  
  //PORTE
  PShape getPorte() {
    PImage image = loadImage( "data/faceInterieur.png");
    PImage image2 = loadImage("data/faceExterieur.png");
    PShape groupe = createShape(GROUP);
    
    PShape face = createShape();
    PShape dos = createShape();
    int x= -75;
    int y = 4;
    float coordonnees = 100;
    
    face.beginShape(QUADS);
    face.textureMode(NORMAL);
    face.texture(image);
    face.fill(color(0));
    face.shininess(30);
    face.emissive(0, 0, 0);
    face.vertex(-coordonnees/x, -coordonnees, -coordonnees+y, 0, 0);
    face.vertex( coordonnees, -coordonnees, -coordonnees+y, 1, 0);
    face.vertex( coordonnees, coordonnees, -coordonnees+y, 1, 1);
    face.vertex(-coordonnees/x, coordonnees, -coordonnees+y, 0, 1);
    face.endShape();
    dos.beginShape(QUADS);
    dos.textureMode(NORMAL);
    dos.texture(image2);
    dos.shininess(30);
    dos.emissive(0, 0, 0);
    dos.vertex(coordonnees, -coordonnees, -coordonnees, 0, 0);
    dos.vertex(-coordonnees/x, -coordonnees, -coordonnees, 1, 0);
    dos.vertex(-coordonnees/x, coordonnees, -coordonnees, 1, 1);
    dos.vertex(coordonnees, coordonnees, -coordonnees, 0, 1);
    dos.endShape();

    groupe.addChild(face);
    groupe.addChild(dos);
    groupe.translate(20, 50, 248);
    return groupe;
  }
  
  PShape porteEntree() {
    PShape porteEntree = getPorte();
    porteEntree.translate(-145.5, 0, -600);
    porteEntree.rotateY(PI/2);
    return porteEntree;
  }
}
