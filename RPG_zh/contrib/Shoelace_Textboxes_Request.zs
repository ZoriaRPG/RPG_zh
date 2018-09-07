****
 
ffc script NPC
{
    void run(int message, int typeOf, int xPos)
    {
        while(true)
        {
            if(StartTalking(this))
            {
                if(typeOf == 0)
                {
                // Display the assigned message
                int slot=ShowMessage(message, TANGO_SLOT_NORMAL, STYLE_PLAIN, 32, 32);
               
                // If the message was displayed successfully...
                if(slot!=TANGO_INVALID)
                {
                    // Wait for it to be closed
                    while(Tango_SlotIsActive(slot))
                        {UnpressButtons();
                        Waitframe();}
                }
               
                StopTalking();
                }
           
            else if (typeOf == 1)
            {
   
                // Display the assigned message
                int slot = ShowMovingMessage(message, TANGO_SLOT_CLOUDPOPUP, STYLE_CLOUDPOPUP, xPos);
 
            // If the message was displayed successfully...
                if(slot!=TANGO_INVALID)
                {
                    // Wait for it to be closed
                    while(Tango_SlotIsActive(slot))
                        {
                        Waitframe();}
                }
               
                StopTalking();
              }
            }
            Waitframe();
        }
    }
   
    // Unpress directional inputs
    void UnpressButtons()
    {
        Link->InputUp = false;
        Link->InputDown = false;
        Link->InputLeft = false;
        Link->InputRight = false;
        Link->PressUp = false;
        Link->PressDown = false;
        Link->PressLeft = false;
        Link->PressRight = false;
    }
}
 
 
 
void SetUpCloudPopupStyle()
{
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_BACKDROP_TYPE, TANGO_BACKDROP_COMBO_TRANS);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_BACKDROP_COMBO, 13532);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_BACKDROP_WIDTH, 6);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_BACKDROP_HEIGHT, 2);
   
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_FONT, TANGO_FONT_SMALL_EXTENDED);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_X, 8);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_Y, 6);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_WIDTH, 92);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_HEIGHT, 16);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_COLOR, 110);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_SPEED, 0);
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_TEXT_SFX, 0);
   
    Tango_SetStyleAttribute(STYLE_CLOUDPOPUP, TANGO_STYLE_FLAGS,
        TANGO_FLAG_CARRY_OVER);
}
 
 
int ShowMovingMessage(int message, int type, int style, float x) // No need for a Y argument
{
    int slot=Tango_GetFreeSlot(type);
    if(slot==TANGO_INVALID)
        return TANGO_INVALID;
   
    int movement[]="@while(@greater(@y 130) @inc(@y -3))@delay(240)@while(@less(@y 168) @inc(@y 3))";
    Tango_ClearSlot(slot);
    Tango_LoadMessage(slot, message);
    Tango_AppendString(slot, movement);
    Tango_SetSlotStyle(slot, style);
    Tango_SetSlotPosition(slot, x, 168);
    Tango_ActivateSlot(slot);
   
    return slot;
}