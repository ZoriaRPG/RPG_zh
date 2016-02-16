//Global array, and constants used by Shield script

Array to hold shield values.
int GB_Shield[256]; //Array at arbitrarily large size.

//Shield Array Indices
const int SHIELD_ITEM = 0;
const int SHIELD_BUTTON = 1;
const int SHIELD_ENABLED = 2;

//Shield Sound Effects
`const int SFX_GBSHIELD = 17; //Shield active SFX


//Global setter/getter functions for shield script. 

//Returns if shield is enabled.
bool ShieldOn(){
    return ( GB_Shield[SHIELD_ENABLED] != 0 );
}

//Sets if shield is enabled.
bool ShieldOn(bool state){
    if ( state ) GB_Shield[SHIELD_ENABLED] = 1;
    else GB_Shield[SHIELD_ENABLED] = 0;
}

//Returns if shield is on Button-A
bool ShieldButton(){
    return ( GB_Shield[SHIELD_BUTTON] != 0 );
}

//Sets if shield is on Button-A
bool ShieldButton(bool buttonA){
    if ( buttonA ) GB_Shield[SHIELD_BUTTON] = 1;
    else GB_Shield[SHIELD_BUTTON] = 0;
}

//Returns the item used as the shield in inventory.
int ShieldItem(){
    return GB_Shield[SHIELD_ITEM];
}

//Sets the inventory item to use as a shield.
void ShieldItem(int itm){
    GB_Shield[SHIELD_ITEM] = itm;
}



void GameboyShield(){
    if( !ShieldOn() && ShieldItem() ){ //Enable shield when using dummy
        ShieldOn(true); //Set shield state to on
        if ( !Link->Item[ ShieldItem() ] )  Link->Item[ ShieldItem() ] = true; //Give the shield
        Game->PlaySound(SFX_GBSHIELD); //Play the sound
    }
    else if( ( ( ShieldButton() && !Link->InputA )||(!ShieldButton() && !Link->InputB)) //When button is released
            && ShieldOn() ){ //And shield is still on
        Link->Item[ ShieldItem() ]=false; //Remove shield
        ShieldItem(0); //Reset shield item variable
        ShieldOn(false); //Set shield state to off
    }
}

//D0: "Real" shield item to give
item script gbshield{
    void run ( int shield ){
        ShieldItem(shield);
        if ( Link->PressB ) ShieldButton(false);
        else if ( Link->PressA ) ShieldButton(true);
    }
}