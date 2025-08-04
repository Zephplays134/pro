enum 50100 "Fire Alarm Status"
{
    Extensible = true;
    
    value(0; Normal)
    {
        Caption = 'Normal';
    }
    value(1; Warning)
    {
        Caption = 'Warning';
    }
    value(2; Alarm)
    {
        Caption = 'Alarm';
    }
    value(3; Fault)
    {
        Caption = 'Fault';
    }
    value(4; Maintenance)
    {
        Caption = 'Maintenance';
    }
    value(5; Offline)
    {
        Caption = 'Offline';
    }
    value(6; Test)
    {
        Caption = 'Test';
    }
    value(7; Disabled)
    {
        Caption = 'Disabled';
    }
    value(8; LowBattery)
    {
        Caption = 'Low Battery';
    }
    value(9; CommunicationError)
    {
        Caption = 'Communication Error';
    }
}