pageextension 43170 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    layout
    {
        addafter("Order Nos.")
        {
            field("Testing Workflows Nos."; Rec."Monday Workflows Nos.")
            {
                Caption = 'Testing Workflows Nos.';
                ApplicationArea = All;

            }
        }
    }
}
