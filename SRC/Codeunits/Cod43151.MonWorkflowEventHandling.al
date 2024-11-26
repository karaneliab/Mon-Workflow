codeunit 43171 MonWorkflowEventHandling
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Monday Approval Mgmt.", 'OnSendMondayWorkflowForApproval', '', false, false)]
    procedure RunOnSendMondayWorkflowForApproval(var Monday: Record "Monday Workflow")
    begin
        WorkflowMgmt.HandleEvent(RunOnSendMondayWorkflowForApprovalCode, Monday);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Monday Approval Mgmt.", 'OnCancelMondayWorkflowForApprovalRequest', '', false, false)]
    procedure RunOnCancelMondayWorkflowForApprovalRequest(var Monday: Record "Monday Workflow")
    begin
        WorkflowMgmt.HandleEvent(RunOnCancelMondayWorkflowForApprovalRequestCode, Monday);
    end;

    procedure RunOnSendMondayWorkflowForApprovalCode(): Code[128]
    begin
        Exit(UpperCase('RunOnSendMondayWorkflowForApproval'))
    end;

    procedure RunOnCancelMondayWorkflowForApprovalRequestCode(): Code[128]
    begin
        Exit(UpperCase('RunOnCancelMondayWorkflowForApprovalRequest'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventsToLibrary()
    begin
        WorkflowEventHandling.AddEventToLibrary(RunOnSendMondayWorkflowForApprovalCode, Database::"Monday Workflow",
        MondayOnSendWorkflowForApprovalEventDescTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunOnCancelMondayWorkflowForApprovalRequestCode, Database::"Monday Workflow",
        MondayOnCancelWorkflowForApprovalRequestEventDescTxt, 0, false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', false, false)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        case
            EventFunctionName of
            RunOnCancelMondayWorkflowForApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(RunOnCancelMondayWorkflowForApprovalRequestCode, RunOnSendMondayWorkflowForApprovalCode);
            RunOnSendMondayWorkflowForApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunOnCancelMondayWorkflowForApprovalRequestCode, RunOnSendMondayWorkflowForApprovalCode);
        end;
    end;



    var
        WorkflowMgmt: Codeunit "Workflow Management";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        MondayOnCancelWorkflowForApprovalRequestEventDescTxt: Label 'An Approval request for Monday Approval request is cancelled.';
        MondayOnSendWorkflowForApprovalEventDescTxt: Label 'An Approval request for Monday  Approval  is requested.';
}
