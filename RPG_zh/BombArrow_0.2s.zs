//Expansive Bomb Arrows Header
//v0.2
//29-JAN-2016 : ZoriaRPG

const int BOMBARROW_USE_TRUE_ARROWS = 1; 
const int BOMBARROWS_CHECK_AMMO_COUNTER = 1;
const int BOMBARROWS_CHECK_BOMB_COUNTER = 1;

const int SPRITE_BOMBARROW = 0;
const int SPRITE_SBOMBARROW = 0;
const int BOMBARROE_STARTING_DIST = 8;
const int BOMBARROW_USE_MISC_INDEX = 7;

const float IS_BOMB_ARROW = I_BOMB;
const float IS_SBOMB_ARROW = I_SBOMB;

const int BOMBARROW_MINIMUM_COMBO_SOLIDITY_FOR_EXPLOSION = 2;

void BombArrows(){
	int bombtype;
	bool bombarrow;
	int pow;
	if ( IsArrow(BUTTON_A, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROW_USE_TRUE_ARROWS ) && int IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER) ) {
		bombtype = IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER);
		itemdata arr = Game->LoadItemData(Link->GetEquipmentA());
		pow = arr->Pow;
		if ( ( Link->PressB || Link->InputB ) && ( Link->PressA || Link->InputA ) ) bombarrow = true;
	}
		
	if ( IsArrow(BUTTON_B, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROW_USE_TRUE_ARROWS ) && int IsBomb(BUTTON_A, BOMBARROWS_CHECK_BOMB_COUNTER) ) {
		bombtype = IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER);
		itemdata arr = Game->LoadItemData(Link->GetEquipmentB());
		pow = arr->Pow;
		if ( ( Link->PressB || Link->InputB ) && ( Link->PressA || Link->InputA ) ) bombarrow = true;
	}
		
	if ( bombarrow ) LaunchBombArrow(BOMBARROW_USE_TRUE_ARROWS, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROWS_CHECK_BOMB_COUNTER, bombtype, BOMBARROE_STARTING_DIST, pow, BOMBARROW_USE_MISC_INDEX);
}

void LanchBombArrow(int usetruearrows, int checkcounter, int checkbombcounter, int bombtype, int dist, int power, int index) { 
	lweapon bombarr = lweapon arrow = NextToLink(LW_ARROW, dist);
	bombarr->Power = power;
	if ( bombtype == I_SBOMB ) {
		bombarr->UseSprite = SPRITE_SBOMBARROW;
		bombarr->Misc[index] = IS_SBOMB_ARROW;
	}
	else {
		bombarr->UseSprite = SPRITE_BOMBARROW;
		bombarr->Misc[index] = IS_BOMB_ARROW
	
	}//Find the arrow and mark its misc index with the bombtype.
	//Change its sprite to a bomb arrow sprite.
}	

//bool checkcombos checks for secret combos to explode. 
//int comboarr is an array to hold flags to cause explosions. 
void BombArrowCollision(int index, bool explodeOnScreenEdge, bool explodeOnSolidCombos, int minSolidity, bool checkCombos, int comboarr){
	int bombarrx;
	int bombarry;
	bool explodetype; //trigger this to cause the explosion. Saves making multiple codeblocks. 
	//Find all bomb arrows on the screen by checking their index. 
	for ( int q = 1; q < Screen->NumLWeapons(); q++ ) {
		lweapon l = Screen->LoadLWeapon(q);
		if ( l->ID != LW_ARROW ) continue;
		if ( l->Misc[index] == IS_SBOMBARROW || l->Misc[index] == IS_BOMBARROW ) {
			
			//If we explode on screen edges...
			if ( explodeOnScreenEdge ) {
			//Check if bomb arrow is at the opposite edge of the screen.
				if ( l->X < 0 || l->X > 249 || l->Y < 0 || l->Y > 173 ) {
					bombarrx = l->X;
					bombarry = l->Y;
					explodetype = l->Misc[index];
				}
			}
			
			//Check collision with combos. 
			if ( explodeOnSolidCombos ) {
				for ( int q = 0; 1 < 176; q++ ) {
					if ( ComboS[q] > minSolidity && Collision(l,q) ) {
						bombarrx = l->X;
						bombarry = l->Y;
						explodetype = l->Misc[index];
					}
				}
			}
			//check collision with enemies and objects.
			for ( int q = 1; q <= Screen->NumNPCs(); q++ ) {
				npc n = Screen->LoadNPC(q);
				if ( n->Type == NPCT_FAIRY || n->Type == NPCT_GUY ) continue; 
				if ( Collision(q,n) ) {
					bombarrx = l->X;
					bombarry = l->Y;
					explodetype = l->Misc[index];
				}
			}

			if ( checkCombos ) {
				
				for ( int q = 0; q < 176; q++ ) {
					if ( !l->IsValid() ) break;
					bool match;
					int cmb = ComboF[q];
					for ( int q = 0; q < SizeOfArray(comboarr); q++ ) {
						if ( cmb == comboarr[q] ) match = true;
						if ( match ) {
							bombarrx = l->X;
							bombarry = l->Y;
							explodetype = l->Misc[index];
							break;
						}
					}
				}
			}
				
			
			//Do explosions based on index value if the local var explodetype != 0. 
			if ( explodetype == I_BOMB ) {
				lweapon bomblast = Screen->CreateLWeapon(LW_BOMBLAST);
				bomblast->X = bombarrx;
				bomblast->Y = bomblasy;
				l->DeadState = WDS_DEAD;
				Remove(l);
			}
			if ( explodetype == I_SBOMB ){ 		
				lweapon sbomblast = Screen->CreateLWeapon(LW_SBOMBLAST);
				sbomblast->X = bombarrx;
				sbomblast->Y = bomblasy;
				l->DeadState = WDS_DEAD;
				Remove(l);
			}
		}
		
	//If they collide with anything, make them go boom with an explosion based on the bombtype in that index. 
	}
}
	
	
bool IsArrow(int btn){
	int arrowItems[]={I_ARROW1, I_ARROW2, I_ARROW3};
	bool arrow;
	if ( btn == BUTTON_A ) {
		for ( int q = 0; q < SizeOfArray(arrowItems); q++ ) {
			int itmA = Link->GetEquipmentA();
			if ( itmA == arrowItems[q] ) arrow = true;
		}
	}
	if ( btn == BUTTON_B ) {
		for ( int q = 0; q < SizeOfArray(arrowItems); q++ ) {
			int itmA = Link->GetEquipmentB();
			if ( itmA == arrowItems[q] ) arrow = true;
		}
	}
	return arrow;
}


bool IsArrow(int btn, int hasarrows, int truearrows){
	int arrowItems[]={I_ARROW1, I_ARROW2, I_ARROW3};
	bool arrow;
	if ( btn == BUTTON_A ) {
		for ( int q = 0; q < SizeOfArray(arrowItems); q++ ) {
			int itmA = Link->GetEquipmentA();
			if ( itmA == arrowItems[q] ) arrow = true;
		}
	}
	if ( btn == BUTTON_B ) {
		for ( int q = 0; q < SizeOfArray(arrowItems); q++ ) {
			int itmA = Link->GetEquipmentB();
			if ( itmA == arrowItems[q] ) arrow = true;
		}
	}
	if ( truearrows && arrow && Game->Counter[CR_ARROWS] ) return true;
	else if ( !truearrows && arrow && Game->Counter[CR_RUPEES] ) return true;
	else return false;
}

int IsBomb(int btn, int hasbombs){
	int bombItems[]={I_BOMB, I_SBOMB};
	bool bomb;
	bool sbomb;
	if ( btn == BUTTON_A && Link->GetEquipmentA() == I_BOMB ) bomb = true;
	if ( btn == BUTTON_A && Link->GetEquipmentA() == I_SBOMB ) sbomb = true;
	
	if ( btn == BUTTON_B && Link->GetEquipmentB() == I_BOMB ) bomb = true;
	if ( btn == BUTTON_B && Link->GetEquipmentB() == I_SBOMB ) sbomb = true;
	
	if ( hasbombs && bomb && Game->Counter[CR_BOMBS] ) return I_BOMB;
	else if ( hasbombs && sbomb && Game->Counter[CR_SBOMBS] return I_SBOMB:
	else if ( !hasbombs && bomb ) return I_BOMB;
	else if ( !hasbombs && sbomb ) return I_SBOMB;
	else return 0;
}
