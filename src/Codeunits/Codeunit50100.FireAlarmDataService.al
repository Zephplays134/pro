codeunit 50100 "Fire Alarm Data Service"
{
    // This codeunit handles real-time data operations for the fire alarm system
    // It simulates data retrieval from actual fire alarm systems
    
    procedure RefreshAllSystems()
    var
        FireAlarmSystem: Record "Fire Alarm System";
        SystemCount: Integer;
    begin
        FireAlarmSystem.FindSet();
        SystemCount := 0;
        
        repeat
            RefreshSystemData(FireAlarmSystem);
            SystemCount += 1;
        until FireAlarmSystem.Next() = 0;
        
        LogMessage(StrSubstNo('Refreshed data for %1 fire alarm systems', SystemCount), Verbosity::Normal);
    end;
    
    procedure RefreshSystem(SystemID: Code[20])
    var
        FireAlarmSystem: Record "Fire Alarm System";
    begin
        if FireAlarmSystem.Get(SystemID) then begin
            RefreshSystemData(FireAlarmSystem);
            LogMessage(StrSubstNo('Refreshed data for system %1', SystemID), Verbosity::Normal);
        end else
            LogMessage(StrSubstNo('System %1 not found', SystemID), Verbosity::Warning);
    end;
    
    local procedure RefreshSystemData(var FireAlarmSystem: Record "Fire Alarm System")
    var
        RandomGenerator: Random;
        RandomValue: Integer;
    begin
        // Simulate real-time data updates
        RandomGenerator.Init();
        
        // Update timestamp
        FireAlarmSystem."Last Updated" := CurrentDateTime;
        
        // Simulate battery level (decreasing over time)
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 10 = 0 then begin // 10% chance to decrease battery
            if FireAlarmSystem."Battery Level" > 0 then
                FireAlarmSystem."Battery Level" := FireAlarmSystem."Battery Level" - 1;
        end;
        
        // Simulate signal strength fluctuations
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 15 = 0 then begin // 15% chance to change signal strength
            RandomGenerator.Random(RandomValue);
            FireAlarmSystem."Signal Strength" := 50 + (RandomValue mod 50); // 50-100%
        end;
        
        // Simulate temperature readings
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 20 = 0 then begin // 20% chance to update temperature
            RandomGenerator.Random(RandomValue);
            FireAlarmSystem."Temperature" := 18 + (RandomValue mod 15); // 18-33°C
        end;
        
        // Simulate smoke level (usually 0, but occasionally spikes)
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 100 = 0 then begin // 1% chance of smoke detection
            RandomGenerator.Random(RandomValue);
            FireAlarmSystem."Smoke Level" := RandomValue mod 100; // 0-99 ppm
            if FireAlarmSystem."Smoke Level" > 50 then begin
                FireAlarmSystem."Status" := FireAlarmSystem."Status"::Alarm;
                FireAlarmSystem."Alarm Triggered" := true;
                FireAlarmSystem."Alarm Time" := CurrentDateTime;
                TriggerAlarmNotification(FireAlarmSystem);
            end;
        end else begin
            FireAlarmSystem."Smoke Level" := 0;
        end;
        
        // Simulate carbon monoxide levels
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 200 = 0 then begin // 0.5% chance of CO detection
            RandomGenerator.Random(RandomValue);
            FireAlarmSystem."Carbon Monoxide" := RandomValue mod 50; // 0-49 ppm
            if FireAlarmSystem."Carbon Monoxide" > 25 then begin
                FireAlarmSystem."Status" := FireAlarmSystem."Status"::Alarm;
                FireAlarmSystem."Alarm Triggered" := true;
                FireAlarmSystem."Alarm Time" := CurrentDateTime;
                TriggerAlarmNotification(FireAlarmSystem);
            end;
        end else begin
            FireAlarmSystem."Carbon Monoxide" := 0;
        end;
        
        // Check for low battery warning
        if FireAlarmSystem."Battery Level" < 20 then begin
            FireAlarmSystem."Status" := FireAlarmSystem."Status"::LowBattery;
        end;
        
        // Check for communication errors
        RandomGenerator.Random(RandomValue);
        if RandomValue mod 500 = 0 then begin // 0.2% chance of communication error
            FireAlarmSystem."Status" := FireAlarmSystem."Status"::CommunicationError;
        end;
        
        // Reset status to normal if no issues
        if (FireAlarmSystem."Smoke Level" = 0) and 
           (FireAlarmSystem."Carbon Monoxide" = 0) and 
           (FireAlarmSystem."Battery Level" >= 20) and
           (FireAlarmSystem."Status" <> FireAlarmSystem."Status"::CommunicationError) then begin
            FireAlarmSystem."Status" := FireAlarmSystem."Status"::Normal;
        end;
        
        FireAlarmSystem.Modify();
    end;
    
    local procedure TriggerAlarmNotification(FireAlarmSystem: Record "Fire Alarm System")
    var
        NotificationText: Text;
    begin
        NotificationText := StrSubstNo('FIRE ALARM TRIGGERED! System: %1, Location: %2, Zone: %3', 
            FireAlarmSystem."System ID", 
            FireAlarmSystem."Location", 
            FireAlarmSystem."Zone");
        
        // In a real implementation, this would send notifications via:
        // - Email
        // - SMS
        // - Push notifications
        // - Integration with emergency services
        
        LogMessage(NotificationText, Verbosity::Error);
        
        // For demo purposes, we'll just show a message
        Message(NotificationText);
    end;
    
    procedure InitializeSampleData()
    var
        FireAlarmSystem: Record "Fire Alarm System";
        SystemID: Code[20];
        Location: Text[100];
        Zone: Code[10];
        i: Integer;
    begin
        // Clear existing data
        FireAlarmSystem.DeleteAll();
        
        // Create sample data for Ithaca York High School
        for i := 1 to 15 do begin
            SystemID := StrSubstNo('ITHACA%1', Format(i, 0, '<Integer,2>'));
            
            case i of
                1..3: begin
                    Location := 'Main Building - First Floor';
                    Zone := 'A1';
                end;
                4..6: begin
                    Location := 'Main Building - Second Floor';
                    Zone := 'A2';
                end;
                7..9: begin
                    Location := 'Science Wing';
                    Zone := 'B1';
                end;
                10..12: begin
                    Location := 'Gymnasium';
                    Zone := 'C1';
                end;
                13..15: begin
                    Location := 'Administrative Offices';
                    Zone := 'D1';
                end;
            end;
            
            FireAlarmSystem.Init();
            FireAlarmSystem."System ID" := SystemID;
            FireAlarmSystem."Location" := Location;
            FireAlarmSystem."Zone" := Zone;
            FireAlarmSystem."Status" := FireAlarmSystem."Status"::Normal;
            FireAlarmSystem."Last Updated" := CurrentDateTime;
            FireAlarmSystem."Battery Level" := 85 + (i * 2); // Varying battery levels
            FireAlarmSystem."Signal Strength" := 90 + (i * 3); // Varying signal strength
            FireAlarmSystem."Temperature" := 22 + (i mod 5); // Varying temperatures
            FireAlarmSystem."Smoke Level" := 0;
            FireAlarmSystem."Carbon Monoxide" := 0;
            FireAlarmSystem."Alarm Triggered" := false;
            FireAlarmSystem."System Type" := FireAlarmSystem."System Type"::Addressable;
            FireAlarmSystem."Installation Date" := CalcDate('<-1Y>', Today);
            FireAlarmSystem."Last Maintenance" := CalcDate('<-3M>', Today);
            FireAlarmSystem."Maintenance Due" := CalcDate('<+3M>', Today);
            FireAlarmSystem.Insert();
        end;
        
        LogMessage('Sample data initialized for Ithaca York High School fire alarm systems', Verbosity::Normal);
    end;
    
    local procedure LogMessage(Message: Text; Verbosity: Verbosity)
    begin
        // In a real implementation, this would log to a proper logging system
        // For now, we'll just use the standard AL logging
        if Verbosity = Verbosity::Error then
            Error(Message)
        else if Verbosity = Verbosity::Warning then
            LogMessage(Message, Verbosity::Warning)
        else
            LogMessage(Message, Verbosity::Normal);
    end;
}