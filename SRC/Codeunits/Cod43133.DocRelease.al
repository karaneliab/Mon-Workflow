codeunit 43174 "Doc. Release"
{
    [IntegrationEvent(false, false)]
    local procedure OnBeforeReopenNext(var Monday: Record "Monday Workflow")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterReopenNext(var Monday: Record "Monday Workflow")
    begin
    end;

    procedure NextReopen(var Monday: Record "Monday Workflow")
    begin
        OnBeforeReopenNext(Monday);
        if Monday.Status = Monday.Status::Created then
            exit;
        Monday.Status := Monday.Status::Created;
        Monday.modify(true);
        OnAfterReopenNext(Monday);

    end;

      procedure MondayRelease(var Monday: Record "Monday Workflow")
    begin
        Monday.Status := Monday.Status::Approved;
        Monday.Validate(Status,Monday.Status::Approved);
        Monday.Modify(True)
    end;
}
