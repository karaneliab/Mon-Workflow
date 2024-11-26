tableextension 43170 "Purchase and Payables" extends "Purchases & Payables Setup"
{
    fields
    {
        field(43133; "Monday Workflows Nos.";code[20])
        {
            Caption = 'Monday Workflows Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
