boolean lumiere = false;
PVector camera;
PVector centre;
float vitesseCam = 4;
float vitesseAngleCamera = 0.2;
float angleHorizontale;
float angleVerticale;
boolean devant, derriere, droite, gauche, haut, bas;
Objets objets = new Objets();
Salle salle = new Salle();
PShader shader;

PVector[] lumieresPosition = {new PVector(100, 250, -690),new PVector(360, 250, -690),//lumière fond de la salle
                              new PVector(100, 250, -20),new PVector(360, 250, -20), // lumière devant de la salle
                              new PVector(100, 250, -320),new PVector(360, 250, -320)//Lumieres milieu de la salle
};

PVector[] lumieresCouleur = {new PVector(52,50,52),new PVector(52,50,52),
                             new PVector(52,50,52),new PVector(52,50,52),
                             new PVector(52,50,52),new PVector(52,50,52)
};
PShape groupe;

//CREATION DE LA SALLE
void setup() {
    fullScreen(P3D,1);
    noCursor();
    smooth();
    shader = loadShader("LightShaderTexFrag.glsl", "LightShaderTexVert.glsl");
    groupe = createShape(GROUP);
    groupe.addChild(salle.creerSalle());
    groupe.addChild(salle.fenetres());
    groupe.addChild(salle.porteEntree());
    groupe.addChild(salle.portes());
    groupe.addChild(salle.chauffages());
    groupe.addChild(objets.tableau());
    groupe.addChild(objets.electricite());
    groupe.addChild(objets.ecranPresentation());
    groupe.addChild(objets.table(80,2,150,40, 83, -161, false));
    groupe.addChild(objets.table(80,2,150,708, 83, -291, false));
    groupe.addChild(objets.chaiseProfetDivers());
    groupe.addChild(objets.table(80,2,150,708, 83, -121, false));
    groupe.addChild(objets.getTableEtudiants(80,2,150,120, 83, -70));
    groupe.addChild(objets.projecteurEtEnceintesMicro());
    groupe.rotateZ(PI);
    camera = new PVector(200, 0, -600);
    centre = new PVector(0, 0, 0);
}

void draw() {
    background(0);
    noStroke();
    if (lumiere)  getLumiere();
    shape(groupe);
    setCamera();
}

//LUMIERES
void getLumiere() {
     ambientLight(10, 10, 10);
    for (int i=0; i<lumieresPosition.length; i++) {
        lightSpecular(lumieresCouleur[i].x, lumieresCouleur[i].y, lumieresCouleur[i].z);
        pointLight(lumieresCouleur[i].x, lumieresCouleur[i].y, lumieresCouleur[i].z, lumieresPosition[i].x, lumieresPosition[i].y, lumieresPosition[i].z);
    }
  
    for (int i=0; i<lumieresPosition.length; i++) {
        pushMatrix();
        noStroke();
        emissive(lumieresCouleur[i].x, lumieresCouleur[i].y, lumieresCouleur[i].z);
        translate(lumieresPosition[i].x, lumieresPosition[i].y, lumieresPosition[i].z);
        popMatrix();
    }
    emissive(0, 0, 0);
    specular(18,18,20);
    shader(shader);
}



void keyPressed() {
    deplacer(keyCode, true);
    if (keyCode =='L')
      lumiere = !lumiere;
}

void keyReleased() {
    deplacer(keyCode, false);
}

void deplacer(int key_code, boolean b) {
    switch(key_code) {
      case 'W':
        devant   = b; break;
      case 'A':
        gauche   = b; break;
      case 'S':
        derriere = b; break;
      case 'D':
        droite   = b; break;
      case ' ':
        haut     = b; break;
      case CONTROL:
        bas      = b; break;
    }
}

void setCamera() {
    PVector vecteurCam = new PVector(0,0,0);
    SensDeplacement sens = getSens();
    if (sens != SensDeplacement.AUCUN) {
        float angleHDeplacement = angleHorizontale + getAngle(sens);
        angleHDeplacement = degresVersRadians(angleHDeplacement);
        vecteurCam.x = (float) Math.sin(angleHDeplacement) * vitesseCam;
        vecteurCam.z = (float) Math.cos(angleHDeplacement) * vitesseCam;
    }
    if (haut) vecteurCam.y += vitesseCam;
    if (bas)  vecteurCam.y -= vitesseCam;
    camera.add(vecteurCam);
    float angleHorizontalRad = degresVersRadians(angleHorizontale);
    float angleVerticalRad = degresVersRadians(-angleVerticale);
    PVector deltaCen = new PVector( (float) Math.sin(angleHorizontalRad) * (float) Math.cos(angleVerticalRad), (float) Math.sin(angleVerticalRad), (float) Math.cos(angleHorizontalRad) * (float) Math.cos(angleVerticalRad) );
    centre = camera.copy().add(deltaCen);
    camera(camera.x, camera.y, camera.z, centre.x, centre.y, centre.z, 0, -1, 0);
}

void mouseMoved() {
    angleVerticale += vitesseAngleCamera * (mouseY - pmouseY);
    angleVerticale = constrain(angleVerticale,  -80,  80);
    angleHorizontale += vitesseAngleCamera * (mouseX - pmouseX);
    while(angleHorizontale >  180) angleHorizontale -= 360;
    while(angleHorizontale < -180) angleHorizontale += 360;
}


SensDeplacement getSens() {
    if (devant && !derriere) {
      if (gauche && !droite)
        return SensDeplacement.DEVANT_GAUCHE;
      else if (droite)
        return SensDeplacement.DEVANT_DROITE;
      else
        return SensDeplacement.DEVANT;
    }
    else if (derriere) {
      if (gauche && !droite)
        return SensDeplacement.DERRIERE_GAUCHE;
      else if (droite)
        return SensDeplacement.DERRIERE_DROITE;
      else
        return SensDeplacement.DERRIERE;
    }
    else {
      if (gauche && !droite)
        return SensDeplacement.GAUCHE;
      else if (droite)
        return SensDeplacement.DROITE;
      else
        return SensDeplacement.AUCUN;
    }
}

float getAngle(SensDeplacement sd) {
    switch(sd) {
      case DEVANT:
        return 0;
      case DEVANT_DROITE:
        return 45;
      case DROITE:
        return 90;
      case DERRIERE_DROITE:
        return 135;
      case DERRIERE:
        return 180;
      case DERRIERE_GAUCHE:
        return 225;
      case GAUCHE:
        return 270;
      case DEVANT_GAUCHE:
        return 315;
      default:
        return Float.NaN;
    }
}

float degresVersRadians(float degres) {
    return degres * PI / 180;
}

enum SensDeplacement {
    AUCUN,
    DEVANT,
    DEVANT_DROITE,
    DROITE,
    DERRIERE_DROITE,
    DERRIERE,
    DERRIERE_GAUCHE,
    GAUCHE,
    DEVANT_GAUCHE
}
