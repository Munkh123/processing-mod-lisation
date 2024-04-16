/*
Classe pour créer les objets(tableau, écran de présentation, ordinateurs, tables et chaises de la salle
*/
class Objets {
  int taille=3;
  Objets() {}
  
  //TABLE
  PShape table(int largeur, int hauteur, int longueur, int x, int y, int z, boolean tableEtudiant){
      PShape groupe = createShape(GROUP);
      PShape table = getBox(largeur, hauteur, longueur);
      table.translate(x,y,z); 
      table.rotateY(PI/2);
      table.setFill(color(29, 122, 145));
      
      if(tableEtudiant){
        PShape tableDevant = getBox((int)(largeur*0.03), (int)(hauteur*5), longueur+1);
        tableDevant.translate(x-(largeur/2),y+3,z); 
        tableDevant.rotateY(PI/2);
        tableDevant.setFill(color(240, 240, 230));
        groupe.addChild(tableDevant);
      }
      PShape groupePieds = createShape(GROUP);
      PShape pied = getBox(2, 65, 2);
      pied.translate(x-35, y+32, z+61); 
      pied.rotateY(PI/2);
      pied.setFill(color(0,0,0));
      groupePieds.addChild(pied);
      
      PShape pied2 = getBox(2, 65, 2);
      pied2.translate(x-35, y+32, z-61); 
      pied2.rotateY(PI/2);
      pied2.setFill(color(0,0,0));
      groupePieds.addChild(pied2);
      
      PShape pied3 = getBox(2, 65, 2);
      pied3.translate(x+35, y+32, z+61); 
      pied3.rotateY(PI/2);
      pied3.setFill(color(0,0,0));
      groupePieds.addChild(pied3);
      
      PShape pied4 = getBox(2, 65, 2);
      pied4.translate(x+35, y+32, z-61); 
      pied4.rotateY(PI/2);
      pied4.setFill(color(0,0,0));
      groupePieds.addChild(pied4);
      
      groupe.addChild(table);
      groupe.addChild(groupePieds);
      return groupe;
  }
    
    //TABLES ETUDIANTS
    PShape getTableEtudiants(int largeur, int hauteur, int longueur, int x, int y, int z){
      PShape groupe = createShape(GROUP);
      int posZTable =z;
      int posXTable =x;
      int posXChaise=120;
      int posYChaise = -10;
      int posXOrdi = -10;
      int posYOrdi = -120;
      
      //rang des tables
      for(int i=0;i<3;i++){
        //nombre de  tables par rang
        for(int j=0;j<3;j++){
          PShape table = table(largeur, hauteur, longueur, posXTable,y,posZTable,true);
          //2 chaises et 2 pc par table
          for(int c=0;c<2;c++){
             if(j==0 && c==0){
              
            //ordinateur
             }else{
            PShape ordi = getOrdinateur();
            ordi.rotateY(PI/2);
            ordi.translate(posXOrdi, 83,posYOrdi);
            groupe.addChild(ordi);
             }
            //chaise
            PShape chaise = chaise();
            chaise.translate(posXChaise, 83,posYChaise);
            chaise.rotateY(PI/2);
            groupe.addChild(chaise);
            posYChaise = posYChaise-50;
            posXOrdi = posXOrdi-60;
          }
          posXOrdi = posXOrdi-40;
          posYChaise = posYChaise-55;
          posZTable = posZTable-longueur;
          groupe.addChild(table);
        }
        posYOrdi = posYOrdi-longueur-40;
        posXOrdi = -10;
        posYChaise =-10;
        posXChaise = posXChaise+longueur+40;
        posZTable=z;
        posXTable =posXTable+longueur+40;
      }
      return groupe;
  }
  
  //TABLEAU
  PShape tableau() {
    PShape tableau = getBox(400, 150, 3);
    tableau.translate(-215, 0, 148);
    tableau.setFill(color(66, 85, 58));
    return tableau;
  }
  
  //ECRAN PRESENTATION
  PShape ecranPresentation() {
    PShape groupe = createShape(GROUP);
    PShape ecran = getBox(5, 90, 150);
    PShape pied = getBox(2, 140, 10);
    PShape baseEcran = getBox(40, 10, 80);
    PImage img = loadImage("data/ecranPre.jpg");
    PShape ecranTexture = createShape();
    float coordonnees = 390;
    
    ecranTexture.beginShape(QUADS);
    ecranTexture.textureMode(NORMAL);
    ecranTexture.texture(img);
    ecranTexture.shininess(20);
    ecranTexture.emissive(0, 0, 0);
    ecranTexture.vertex(coordonnees/5, -coordonnees/8.7, -coordonnees/5.7, 0, 0);
    ecranTexture.vertex(coordonnees/5, -coordonnees/8.7, coordonnees/5.7, 1, 0);
    ecranTexture.vertex(coordonnees/5, coordonnees/8.7, coordonnees/5.7, 1, 1);
    ecranTexture.vertex(coordonnees/5, coordonnees/8.7, -coordonnees/5.7, 0, 1);
    ecranTexture.endShape();
    
    groupe.addChild(ecran);
    groupe.addChild(pied);
    groupe.addChild(baseEcran);
    groupe.translate(-30, 0, 50); 
    groupe.rotateY(PI/1.5);
    groupe.addChild(ecranTexture);
    pied.translate(0,78,0);
    baseEcran.translate(0,144,0);
    ecranTexture.rotateY(PI/1);
    ecranTexture.translate(81,0,0);
    groupe.setFill(color(0, 0, 0));
    
    return groupe;
  }

  //COMPTEUR ELECTRICITE
  PShape electricite() {
    PShape groupeCompteur = createShape(GROUP);
    PShape compteur = getBox(10, 80, 40);
    PShape porteCompteur = getBox(2, 80, 40);
    
    groupeCompteur.addChild(compteur);
    groupeCompteur.addChild(porteCompteur);
    groupeCompteur.translate(-444, 0, -80);
    groupeCompteur.setFill(color(70));
    porteCompteur.translate(6, 0, 0);
    
    return groupeCompteur;
  }
  
  //PROJECTEUR
  PShape projecteurEtEnceintesMicro() {
    PShape groupe = createShape(GROUP);
    PShape projecteurPartie1 = getBox(150, 10, 8);
    projecteurPartie1.translate(-100, -87, 144);
    projecteurPartie1.setFill(color(199, 207, 214));
    PShape projecteurPartie2 = getBox(130, 8, 2);
    projecteurPartie2.translate(-100, -78, 144);
    projecteurPartie2.setFill(color(255));
    
    PShape enceinte = getBox(30, 20, 10);
    enceinte.translate(0, -130, 144);
    enceinte.setFill(color(255));
    PShape enceinte2 = getBox(30, 20, 10);
    enceinte2.translate(-430, -130, 144);
    enceinte2.setFill(color(255));
    
    PShape groupeMicro = createShape(GROUP);
    PShape micro = getBox(10, 15, 8);
    groupeMicro.addChild(micro);
    PShape rond = createShape(SPHERE, 5);
    rond.translate(0, -10, 0);
    
    groupeMicro.translate(-444, -28, -244);
    groupeMicro.setFill(color(0));
    rond.setFill(color(55));
    groupeMicro.addChild(rond);
    
    groupe.addChild(groupeMicro);
    groupe.addChild(enceinte);
    groupe.addChild(enceinte2);
    groupe.addChild(projecteurPartie1);
    groupe.addChild(projecteurPartie2);
    return groupe;
  }


  //OBJET
   PShape getBox(int longFace, int hauteur, int Larg) {
    PShape box = createShape(BOX, longFace, hauteur, Larg);
    return box;
  }

  //ORDINATEUR
  PShape getOrdinateur() {
    PShape groupeOrdinateur = createShape(GROUP);
    PShape tour = getBox(60/taille, 60/taille, 20/taille);
    PShape monitor = getBox(6/taille, 70/taille, 110/taille);
    PShape clavier = getBox(30/taille, 5/taille, 90/taille);
    PShape souris = getBox(16/taille, 12/taille, 14/taille);
    PShape manche = getBox(20/taille, 10/taille, 10/taille);
    PShape barre = getBox(6/taille, 70/taille, 15/taille);
    PShape baseBarre = getBox(35/taille, 5/taille, 35/taille);
    PShape groupeEcran = createShape(GROUP);
    PImage image = loadImage("data/ecran.png");
    PShape formeEcran = createShape();
    float coordonnees = 100;
    
    formeEcran.beginShape(QUADS);
    formeEcran.textureMode(NORMAL);
    formeEcran.texture(image);
    formeEcran.shininess(5);
    formeEcran.emissive(0, 0, 0);
    formeEcran.vertex(coordonnees/5, -coordonnees/8.7, -coordonnees/5.7, 0, 0);
    formeEcran.vertex(coordonnees/5, -coordonnees/8.7, coordonnees/5.7, 1, 0);
    formeEcran.vertex(coordonnees/5, coordonnees/8.7, coordonnees/5.7, 1, 1);
    formeEcran.vertex(coordonnees/5, coordonnees/8.7, -coordonnees/5.7, 0, 1);
    formeEcran.endShape();
    groupeEcran.addChild(formeEcran);
    groupeEcran.translate(-20.1, -21, 20);
    groupeEcran.rotateY(PI);

    tour.translate(-5/taille, -33/taille, -150/taille);
    monitor.translate(-5/taille, -63/taille, -60/taille);
    clavier.translate(40/taille, -6/taille, -60/taille);
    souris.translate(42/taille, -6/taille, -130/taille);
    manche.translate(-12/taille, -60/taille, -60/taille);
    barre.translate(-20/taille, -34/taille, -60/taille);
    baseBarre.translate(-20/taille, -6/taille, -60/taille);
    
    tour.setFill(color(0));
    monitor.setFill(color(0));
    clavier.setFill(color(0));
    souris.setFill(color(0));
    manche.setFill(color(2));
    barre.setFill(color(2));
    baseBarre.setFill(color(2));

    groupeOrdinateur.addChild(tour);
    groupeOrdinateur.addChild(monitor);
    groupeOrdinateur.addChild(clavier);
    groupeOrdinateur.addChild(souris);
    groupeOrdinateur.addChild(manche);
    groupeOrdinateur.addChild(barre);
    groupeOrdinateur.addChild(baseBarre);
    groupeOrdinateur.addChild(groupeEcran);
    return groupeOrdinateur;
  }
  
  PShape chaiseProfetDivers(){
    PShape groupe = createShape(GROUP);
    //chaise prof
    PShape chaiseProf = chaise();
    chaiseProf.rotateY(-1.6);
    chaiseProf.translate(-190,83,-50);
    groupe.addChild(chaiseProf);
    
    //petite table à côté du prof
    PShape petiteTable = createShape(GROUP);
    PShape table = getBox(30,2, 30);
    petiteTable.addChild(table);
    PShape pied =getBox(2,65, 2);
    petiteTable.addChild(pied);
    PShape basePied = getBox(10,2, 10);
    petiteTable.addChild(basePied);
    groupe.addChild(petiteTable);
    petiteTable.translate(-70,83,-60);
    pied.translate(0,33,0);
    basePied.translate(0,65,0);
    petiteTable.setFill(color(70));
    
    return groupe;
  }

  //PIEDS CHAISE
  PShape piedsChaise(int x, int y, int z, int xtranslation, int ytranslation, int ztranslation) {
    PShape groupePieds= createShape(GROUP);
    PShape pied1 = getBox(x, y, z);
    PShape pied2 = getBox(x, y, z);
    PShape pied3 = getBox(x, y, z);
    PShape pied4 = getBox(x, y, z);
    
    pied1.translate(xtranslation+x, ytranslation, ztranslation);
    pied2.translate(xtranslation+xtranslation+x, ytranslation, ztranslation);
    pied3.translate(xtranslation+x, ytranslation, ztranslation-ztranslation*2);
    pied4.translate(xtranslation+xtranslation+x, ytranslation, ztranslation-ztranslation*2);
    pied1.setFill(color(#ebc634));
    pied2.setFill(color(#ebc634));
    pied3.setFill(color(#ebc634));
    pied4.setFill(color(#ebc634));
    
    groupePieds.addChild(pied1);
    groupePieds.addChild(pied2);
    groupePieds.addChild(pied3);
    groupePieds.addChild(pied4);
    return groupePieds;
  }

  //CHAISE
  PShape chaise() {
    PShape chaise= createShape(GROUP);
    PShape surface =  getBox(90/taille, 5/taille, 120/taille);
    PShape dos =  getBox(5/taille, 130/taille, 120/taille);

    surface.translate(100/taille, -25/taille, 0);
    dos.translate(145/taille, -90/taille, 0);
    surface.setFill(color(#b39029));
    dos.setFill(color(#b39029));
    chaise.addChild(surface);
    chaise.addChild(dos);
    chaise.addChild(piedsChaise(10/taille, 125/taille, 10/taille, 60/taille, 40/taille, -45/taille));
    chaise.translate(10/taille, 100/taille, -90/taille);
    return chaise;
  }
}


 
