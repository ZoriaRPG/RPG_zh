const int BOMBARROW_USE_TRUE_ARROWS = 1; 
const int BOMBARROWS_CHECK_AMMO_COUNTER = 1;
const int BOMBARROWS_CHECK_BOMB_COUNTER = 1;

const int SPRITE_BOMBARROW = 0;
const int SPRITE_SBOMBARROW = 0;

void BombArrows(){
	int bombtype;
	bool bombarrow;
	if ( IsArrow(BUTTON_A, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROW_USE_TRUE_ARROWS ) && int IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER) ) {
		bombtype = IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER);
		if ( ( Link->PressB || Link->InputB ) && ( Link->PressA || Link->InputA ) ) bombarrow = true;
	}
		
	if ( IsArrow(BUTTON_B, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROW_USE_TRUE_ARROWS ) && int IsBomb(BUTTON_A, BOMBARROWS_CHECK_BOMB_COUNTER) ) {
		bombtype = IsBomb(BUTTON_B, BOMBARROWS_CHECK_BOMB_COUNTER);
		if ( ( Link->PressB || Link->InputB ) && ( Link->PressA || Link->InputA ) ) bombarrow = true;
	}
		
	if ( bombarrow ) LaunchBombArrow(BOMBARROW_USE_TRUE_ARROWS, BOMBARROWS_CHECK_AMMO_COUNTER, BOMBARROWS_CHECK_BOMB_COUNTER, bombtype);
}

void LanchBombArrow(int usetruearrows, int checkcounter, int checkbombcounter, int bombtype) { 
	lweapon bombarr;
	//Find the arrow and mark its misc index with the bombtype.
	//Change its sprite to a bomb arrow sprite.
}	

void BombArrowCollision(){
	//Find all bomb arrows on the screen by checking their index. 
	//If they collide with anything, make them go boom with an explosion based on the bombtype in that index. 
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
