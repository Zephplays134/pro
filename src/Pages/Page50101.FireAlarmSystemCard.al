page 50101 "Fire Alarm System Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;
    SourceTable = "Fire Alarm System";
    Caption = 'Fire Alarm System Details';
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Information';
                
                field("System ID"; Rec."System ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the unique identifier for the fire alarm system.';
                }
                field("Location"; Rec."Location")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the location of the fire alarm system.';
                }
                field("Zone"; Rec."Zone")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the zone where the fire alarm system is located.';
                }
                field("System Type"; Rec."System Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of fire alarm system.';
                }
                field("Installation Date"; Rec."Installation Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the fire alarm system was installed.';
                }
            }
            
            group(Status)
            {
                Caption = 'Current Status';
                
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current status of the fire alarm system.';
                    Style = Strong;
                    StyleExpr = Rec."Status" = Rec."Status"::Alarm;
                }
                field("Last Updated"; Rec."Last Updated")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the system status was last updated.';
                }
                field("Battery Level"; Rec."Battery Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current battery level of the fire alarm system.';
                    Style = Attention;
                    StyleExpr = Rec."Battery Level" < 20;
                }
                field("Signal Strength"; Rec."Signal Strength")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the signal strength of the fire alarm system.';
                    Style = Attention;
                    StyleExpr = Rec."Signal Strength" < 50;
                }
            }
            
            group(Sensors)
            {
                Caption = 'Sensor Readings';
                
                field("Temperature"; Rec."Temperature")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current temperature at the fire alarm system location.';
                }
                field("Smoke Level"; Rec."Smoke Level")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current smoke level detected by the system.';
                    Style = Unfavorable;
                    StyleExpr = Rec."Smoke Level" > 0;
                }
                field("Carbon Monoxide"; Rec."Carbon Monoxide")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the current carbon monoxide level detected by the system.';
                    Style = Unfavorable;
                    StyleExpr = Rec."Carbon Monoxide" > 0;
                }
            }
            
            group(Alarm)
            {
                Caption = 'Alarm Information';
                
                field("Alarm Triggered"; Rec."Alarm Triggered")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies whether an alarm has been triggered.';
                    Style = Unfavorable;
                    StyleExpr = Rec."Alarm Triggered";
                }
                field("Alarm Time"; Rec."Alarm Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alarm was last triggered.';
                }
                field("Acknowledged By"; Rec."Acknowledged By")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who acknowledged the alarm.';
                }
                field("Acknowledged Time"; Rec."Acknowledged Time")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the alarm was acknowledged.';
                }
            }
            
            group(Maintenance)
            {
                Caption = 'Maintenance';
                
                field("Last Maintenance"; Rec."Last Maintenance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the system was last maintained.';
                }
                field("Maintenance Due"; Rec."Maintenance Due")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the next maintenance is due.';
                    Style = Attention;
                    StyleExpr = Rec."Maintenance Due" <= Today;
                }
            }
            
            group(Notes)
            {
                Caption = 'Notes';
                
                field("Notes"; Rec."Notes")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any additional notes about the fire alarm system.';
                    MultiLine = true;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RefreshStatus)
            {
                ApplicationArea = All;
                Caption = 'Refresh Status';
                Image = Refresh;
                ToolTip = 'Refresh the current status of this fire alarm system.';
                
                trigger OnAction()
                begin
                    RefreshSystemStatus();
                end;
            }
            action(AcknowledgeAlarm)
            {
                ApplicationArea = All;
                Caption = 'Acknowledge Alarm';
                Image = Check;
                ToolTip = 'Acknowledge the current alarm.';
                Visible = Rec."Alarm Triggered";
                
                trigger OnAction()
                begin
                    AcknowledgeCurrentAlarm();
                end;
            }
            action(TestSystem)
            {
                ApplicationArea = All;
                Caption = 'Test System';
                Image = Test;
                ToolTip = 'Initiate a test of the fire alarm system.';
                
                trigger OnAction()
                begin
                    TestFireAlarmSystem();
                end;
            }
            action(ViewHistory)
            {
                ApplicationArea = All;
                Caption = 'View History';
                Image = History;
                ToolTip = 'View the history of this fire alarm system.';
                
                trigger OnAction()
                begin
                    ViewSystemHistory();
                end;
            }
        }
    }
    
    local procedure RefreshSystemStatus()
    var
        FireAlarmDataService: Codeunit "Fire Alarm Data Service";
    begin
        FireAlarmDataService.RefreshSystem(Rec."System ID");
        CurrPage.Update(false);
    end;
    
    local procedure AcknowledgeCurrentAlarm()
    begin
        if Rec."Alarm Triggered" then begin
            Rec."Acknowledged By" := UserId;
            Rec."Acknowledged Time" := CurrentDateTime;
            Rec.Modify();
            Message('Alarm acknowledged successfully.');
        end;
    end;
    
    local procedure TestFireAlarmSystem()
    begin
        if Confirm('Are you sure you want to test the fire alarm system?') then begin
            // Test logic would be implemented here
            Message('Test initiated for system %1. Please check the system response.', Rec."System ID");
        end;
    end;
    
    local procedure ViewSystemHistory()
    begin
        // History view logic would be implemented here
        Message('System history functionality will be implemented in a future version.');
    end;
}