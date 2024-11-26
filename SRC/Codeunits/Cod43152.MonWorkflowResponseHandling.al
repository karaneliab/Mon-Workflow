codeunit 43172 MonWorkflowResponseHandling
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', false, false)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Monday: Record "Monday Workflow";
        VarVariant: Variant;
        ReleaseDoc: Codeunit "Doc. Release";
    begin
         VarVariant := RecRef;
        case
         Recref.Number of
            Database::"Monday Workflow":
                begin
                    Monday.SetView(RecRef.GetView());
                    // Monday.Status := Monday.Status::Approved;
                    // // RecRef.SetTable(Monday);
                    // Monday.validate(Status, Monday.Status::Approved);
                    Handled := true;
                    ReleaseDoc.MondayRelease(VarVariant);
                    Monday.Modify(true)
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', false, false)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Monday: Record "Monday Workflow";
        ReleaseDoc: Codeunit "Doc. Release";
    begin
        case
            Recref.Number of
            Database::"Monday Workflow":
                begin
                    Monday.SetView(RecRef.GetView());
                    Handled := true;
                    ReleaseDoc.NextReopen(Monday);
                end;
        end;
    end;
}
