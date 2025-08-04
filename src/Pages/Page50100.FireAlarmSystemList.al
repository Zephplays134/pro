page 50100 "Fire Alarm System List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Fire Alarm System";
    Caption = 'Fire Alarm System Status';
    CardPageId = "Fire Alarm System Card";
    
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                    Visible = false;
                }
                field("System Type"; Rec."System Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of fire alarm system.';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RefreshData)
            {
                ApplicationArea = All;
                Caption = 'Refresh Data';
                Image = Refresh;
                ToolTip = 'Refresh the fire alarm system data from the monitoring system.';
                
                trigger OnAction()
                begin
                    RefreshFireAlarmData();
                end;
            }
            action(ViewAlarms)
            {
                ApplicationArea = All;
                Caption = 'View Active Alarms';
                Image = Alert;
                ToolTip = 'View all currently active fire alarms.';
                
                trigger OnAction()
                begin
                    ShowActiveAlarms();
                end;
            }
            action(ExportData)
            {
                ApplicationArea = All;
                Caption = 'Export Data';
                Image = Export;
                ToolTip = 'Export fire alarm system data to Excel.';
                
                trigger OnAction()
                begin
                    ExportFireAlarmData();
                end;
            }
        }
    }
    
    local procedure RefreshFireAlarmData()
    var
        FireAlarmDataService: Codeunit "Fire Alarm Data Service";
    begin
        FireAlarmDataService.RefreshAllSystems();
        CurrPage.Update(false);
    end;
    
    local procedure ShowActiveAlarms()
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Alarm Triggered", true);
        FireAlarmSystem.SetRange("Status", FireAlarmSystem.Status::Alarm);
        Page.Run(Page::"Fire Alarm System List", FireAlarmSystem);
    end;
    
    local procedure ExportFireAlarmData()
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.FindSet();
        // Export logic would be implemented here
        Message('Export functionality will be implemented in a future version.');
    end;
}