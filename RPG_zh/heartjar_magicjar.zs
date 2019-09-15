float ReserveCounters[256]; //Holds values of dropped items that can't be used when the player picks them up.
int OwnsItems[512];  //Stores what items the player actually owns.

//Array indices.
const int RESERVE_HEARTS    = 1;
const int RESERVE_MAGIC     = 2;

//item constants.
const int I_HEARTJAR = 100; //The item ID for the Heart Jar.
const int I_MAGICJAR = 101; //The item ID for the Magic Jar

//Assign as the pick-up script on all heart items.
//D0: Number of hearts to give when Link picks it up.
//D1 Divisor, for how many hearts it will store in the heart jar.
item script heartdrop{
    void run(int numhearts, int divisor){
        if ( Link->HP == Link->MaxHP && OwnsItems[I_HEARTJAR] ) {
            ReserveCounters[RESERVE_HEARTS] += numhearts / divisor;
        }
    }
}


//Assign as the pick-up script on all magic drop items.
//D0: Amount of magic to give when Link picks it up.
//D1 Divisor, for how many magic points it will store in the magic jar.
item script magicdrop{
    void run(int num_mp, int divisor){
        if ( Link->MP == Link->MaxMP && OwnsItems[I_MAGICJAR] ) {
            ReserveCounters[RESERVE_MAGIC] += num_mp / divisor;
        }
    }
}

//Assign as pickup script for heart jar item.
item script HeartJarPickup{
    void run(int msg){
        if ( msg ) Screen->message(msg);
        OwnsItems[I_HEARTJAR] = 1;
    }
}


//Assign as pickup script for magic jar item.
item script MagicJarPickup{
    void run(int msg){
        if ( msg ) Screen->message(msg);
        OwnsItems[I_MAGICJAR] = 1;
    }
}


//Assign as running script for Heart Jar.
item script heartjar{
    void run(int msg, int sfx, imt errsfx){
        if ( Link->HP < Link->MaxHP ) {
            if ( ReserveCounters[RESERVE_HEARTS] > ( Ceiling((Link->MaxHP - Link->HP) / 16) ) ) {
                ReserveCounters[RESERVE_HEARTS] -= ( Ceiling((Link->MaxHP - Link->HP) / 16) );
                Link->HP = Link->MaxHP;
                Game->PlaySound(sfx);
            }
            if ( ReserveCounters[RESERVE_HEARTS] < ( Ceiling((Link->MaxHP - Link->HP) / 16) ) && ReserveCounters[RESERVE_HEARTS] ){
                Link->HP += ReserveCounters[RESERVE_HEARTS] * 16;
                Link->HP += ReserveCounters[RESERVE_HEARTS] = 0;
                Game->PlaySound(sfx);
            }
            if ( !(ReserveCounters[RESERVE_HEARTS]) ) Game->PlaySound(errsrfx);
        }
        else game->PlaySound(errsfx);
    }
}
            
                

//Assign as running script for Magic Jar.
item script magicjar{
    void run(int msg, int sfx, imt errsfx){
        if ( Link->MP < Link->MaxMP ) {
            if ( ReserveCounters[RESERVE_MAGIC] > ( Ceiling((Link->MaxMP - Link->MP) / 32) ) ) {
                ReserveCounters[RESERVE_MAGIC] -= ( Ceiling((Link->MaxMP - Link->MP) / 32) );
                Link->MP = Link->MaxMP;
                Game->PlaySound(sfx);
            }
            if ( ReserveCounters[RESERVE_MAGIC] < ( Ceiling((Link->MaxMP - Link->MP) / 32) ) && ReserveCounters[RESERVE_MAGIC] ){
                Link->MP += ReserveCounters[RESERVE_MAGIC] * 32;
                Link->MP += ReserveCounters[RESERVE_MAGIC] = 0;
                Game->PlaySound(sfx);
            }
            if ( !(ReserveCounters[RESERVE_MAGIC]) ) Game->PlaySound(errsrfx);
        }
        else game->PlaySound(errsfx);
    }
}
            
                