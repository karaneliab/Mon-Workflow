codeunit 43170 "Monday Approval Mgmt."
{
    procedure CheckWworkflowEnabled(Var Monday: Record "Monday Workflow"): Boolean

    begin
        if not IsWorkflowEnabled(Monday) then
            Error(NoWorkflowEnabledErr);
        exit(true);
    end;

    procedure IsWorkflowEnabled(Var Monday: Record "Monday Workflow"): Boolean
    begin
       exit(WorkflowMgmt.CanExecuteWorkflow(Monday, WorkflowEventHandling.RunOnSendMondayWorkflowForApprovalCode));
    end;

    [IntegrationEvent(false, false)]
    procedure OnSendMondayWorkflowForApproval(Var Monday: Record "Monday Workflow")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelMondayWorkflowForApprovalRequest(Var Monday: Record "Monday Workflow")
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', false, false)]
    local procedure OnPopulateApprovalEntryArgument(var ApprovalEntryArgument: Record "Approval Entry"; var RecRef: RecordRef; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        Monday: Record "Monday Workflow";
    begin
        if RecRef.Number = Database::"Monday Workflow" then begin
            RecRef.SetTable(Monday);
            ApprovalEntryArgument."Document No." := Monday."No.";
            ApprovalEntryArgument."Table ID" := RecRef.Number;
            ApprovalEntryArgument.Insert();
        end
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    local procedure OnRejectApprovalRequest(var ApprovalEntry: Record "Approval Entry")
    var
        Recref: RecordRef;
        Monday: Record "Monday Workflow";
    begin
        Recref.Get(ApprovalEntry."Record ID to Approve");
        case
            Recref.Number of
            Database::"Monday Workflow":
                begin
                    Recref.SetTable(Monday);
                    Monday.Status := Monday.Status::Rejected;
                    Monday.Modify(true)

                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', false, false)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var IsHandled: Boolean; var Variant: Variant)
    var

        Monday: Record "Monday Workflow";
    begin
        case
            RecRef.Number of
            Database::"Monday Workflow":
                begin
                    RecRef.SetTable(Monday);
                    Monday.Status := Monday.Status::"Pending Approvaals";
                    Variant := Monday;
                    IsHandled := true;
                    Monday.Modify(true)
                end;
        end;
    end;

    var
        WorkflowEventHandling: Codeunit "MonWorkflowEventHandling";
        WorkflowMgmt: Codeunit "Workflow Management";
        NoWorkflowEnabledErr: Label 'No Approval Workflow for this record type is enabled';
}
