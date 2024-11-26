table 43170 "Monday Workflow"
{
    Caption = 'Monday Workflow';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    PurchSetup.Get();
                    PurchSetup.TestField("Monday Workflows Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; Descrition; Text[250])
        {
            Caption = 'Descrition';
        }
        field(3; Status; Enum "Approval Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(4; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(5; "Date"; Date)
        {
            Caption = 'Date';
        }
        field(6; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = Microsoft.Foundation.NoSeries."No. Series";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    begin
        PurchSetup.Get();
        PurchSetup.TestField("Monday Workflows Nos.");
        if "No." = '' then
            "No." := NoSeerie.GetNextNo(PurchSetup."Monday Workflows Nos.", Today);
    end;

    var
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeerie: Codeunit "No. Series";


}
