page 50102 "Fire Alarm Dashboard"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Fire Alarm System Dashboard';
    
    layout
    {
        area(Content)
        {
            group(Overview)
            {
                Caption = 'System Overview';
                
                field(TotalSystems; GetTotalSystems())
                {
                    Caption = 'Total Systems';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(NormalSystems; GetNormalSystems())
                {
                    Caption = 'Normal Status';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Favorable;
                }
                field(AlarmSystems; GetAlarmSystems())
                {
                    Caption = 'Active Alarms';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(WarningSystems; GetWarningSystems())
                {
                    Caption = 'Warnings';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                }
                field(FaultSystems; GetFaultSystems())
                {
                    Caption = 'Faults';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Unfavorable;
                }
                field(OfflineSystems; GetOfflineSystems())
                {
                    Caption = 'Offline';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                }
            }
            
            group(RealTimeStatus)
            {
                Caption = 'Real-Time Status';
                
                part(FireAlarmList; "Fire Alarm System List")
                {
                    ApplicationArea = All;
                    Caption = 'Fire Alarm Systems';
                }
            }
            
            group(QuickActions)
            {
                Caption = 'Quick Actions';
                
                field(RefreshAll; 'Refresh All Systems')
                {
                    Caption = 'Refresh All Systems';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Click to refresh all fire alarm system data.';
                    
                    trigger OnDrillDown()
                    begin
                        RefreshAllSystems();
                    end;
                }
                field(InitializeData; 'Initialize Sample Data')
                {
                    Caption = 'Initialize Sample Data';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Click to initialize sample data for Ithaca York High School.';
                    
                    trigger OnDrillDown()
                    begin
                        InitializeSampleData();
                    end;
                }
                field(ViewAlarms; 'View Active Alarms')
                {
                    Caption = 'View Active Alarms';
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Click to view all currently active alarms.';
                    
                    trigger OnDrillDown()
                    begin
                        ShowActiveAlarms();
                    end;
                }
            }
            
            group(Statistics)
            {
                Caption = 'Statistics';
                
                field(AverageBattery; GetAverageBattery())
                {
                    Caption = 'Average Battery Level (%)';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = GetAverageBattery() < 50;
                }
                field(AverageSignal; GetAverageSignal())
                {
                    Caption = 'Average Signal Strength (%)';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = GetAverageSignal() < 70;
                }
                field(AverageTemp; GetAverageTemperature())
                {
                    Caption = 'Average Temperature (°C)';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(MaintenanceDue; GetMaintenanceDueCount())
                {
                    Caption = 'Systems Due for Maintenance';
                    ApplicationArea = All;
                    Editable = false;
                    Style = Attention;
                    StyleExpr = GetMaintenanceDueCount() > 0;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(RefreshDashboard)
            {
                ApplicationArea = All;
                Caption = 'Refresh Dashboard';
                Image = Refresh;
                ToolTip = 'Refresh the dashboard with latest data.';
                
                trigger OnAction()
                begin
                    RefreshAllSystems();
                    CurrPage.Update(false);
                end;
            }
            action(ExportReport)
            {
                ApplicationArea = All;
                Caption = 'Export Status Report';
                Image = Export;
                ToolTip = 'Export a comprehensive status report.';
                
                trigger OnAction()
                begin
                    ExportStatusReport();
                end;
            }
            action(Settings)
            {
                ApplicationArea = All;
                Caption = 'Dashboard Settings';
                Image = Setup;
                ToolTip = 'Configure dashboard settings.';
                
                trigger OnAction()
                begin
                    ShowDashboardSettings();
                end;
            }
        }
    }
    
    local procedure GetTotalSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetNormalSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Normal);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetAlarmSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Alarm);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetWarningSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Warning);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetFaultSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Fault);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetOfflineSystems(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Offline);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure GetAverageBattery(): Decimal
    var
        FireAlarmSystem: Record "Fire Alarm System";
        TotalBattery: Decimal;
        SystemCount: Integer;
    begin
        FireAlarmSystem.FindSet();
        TotalBattery := 0;
        SystemCount := 0;
        
        repeat
            TotalBattery += FireAlarmSystem."Battery Level";
            SystemCount += 1;
        until FireAlarmSystem.Next() = 0;
        
        if SystemCount > 0 then
            exit(Round(TotalBattery / SystemCount, 1))
        else
            exit(0);
    end;
    
    local procedure GetAverageSignal(): Decimal
    var
        FireAlarmSystem: Record "Fire Alarm System";
        TotalSignal: Decimal;
        SystemCount: Integer;
    begin
        FireAlarmSystem.FindSet();
        TotalSignal := 0;
        SystemCount := 0;
        
        repeat
            TotalSignal += FireAlarmSystem."Signal Strength";
            SystemCount += 1;
        until FireAlarmSystem.Next() = 0;
        
        if SystemCount > 0 then
            exit(Round(TotalSignal / SystemCount, 1))
        else
            exit(0);
    end;
    
    local procedure GetAverageTemperature(): Decimal
    var
        FireAlarmSystem: Record "Fire Alarm System";
        TotalTemp: Decimal;
        SystemCount: Integer;
    begin
        FireAlarmSystem.FindSet();
        TotalTemp := 0;
        SystemCount := 0;
        
        repeat
            TotalTemp += FireAlarmSystem."Temperature";
            SystemCount += 1;
        until FireAlarmSystem.Next() = 0;
        
        if SystemCount > 0 then
            exit(Round(TotalTemp / SystemCount, 1))
        else
            exit(0);
    end;
    
    local procedure GetMaintenanceDueCount(): Integer
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetFilter("Maintenance Due", '<=%1', Today);
        exit(FireAlarmSystem.Count);
    end;
    
    local procedure RefreshAllSystems()
    var
        FireAlarmDataService: Codeunit "Fire Alarm Data Service";
    begin
        FireAlarmDataService.RefreshAllSystems();
    end;
    
    local procedure InitializeSampleData()
    var
        FireAlarmDataService: Codeunit "Fire Alarm Data Service";
    begin
        if Confirm('This will clear existing data and initialize sample data for Ithaca York High School. Continue?') then begin
            FireAlarmDataService.InitializeSampleData();
            CurrPage.Update(false);
        end;
    end;
    
    local procedure ShowActiveAlarms()
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        FireAlarmSystem.SetRange("Alarm Triggered", true);
        FireAlarmSystem.SetRange("Status", FireAlarmSystem."Status"::Alarm);
        Page.Run(Page::"Fire Alarm System List", FireAlarmSystem);
    end;
    
    local procedure ExportStatusReport()
    begin
        // Export functionality would be implemented here
        Message('Status report export functionality will be implemented in a future version.');
    end;
    
    local procedure ShowDashboardSettings()
    begin
        // Settings functionality would be implemented here
        Message('Dashboard settings functionality will be implemented in a future version.');
    end;
}