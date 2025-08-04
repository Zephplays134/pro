table 50100 "Fire Alarm System"
{
    Caption = 'Fire Alarm System';
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; "System ID"; Code[20])
        {
            Caption = 'System ID';
            DataClassification = CustomerContent;
        }
        field(3; "Location"; Text[100])
        {
            Caption = 'Location';
            DataClassification = CustomerContent;
        }
        field(4; "Zone"; Code[10])
        {
            Caption = 'Zone';
            DataClassification = CustomerContent;
        }
        field(5; "Status"; Enum "Fire Alarm Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(6; "Last Updated"; DateTime)
        {
            Caption = 'Last Updated';
            DataClassification = CustomerContent;
        }
        field(7; "Battery Level"; Decimal)
        {
            Caption = 'Battery Level (%)';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
        }
        field(8; "Signal Strength"; Decimal)
        {
            Caption = 'Signal Strength (%)';
            DataClassification = CustomerContent;
            MinValue = 0;
            MaxValue = 100;
        }
        field(9; "Temperature"; Decimal)
        {
            Caption = 'Temperature (°C)';
            DataClassification = CustomerContent;
        }
        field(10; "Smoke Level"; Decimal)
        {
            Caption = 'Smoke Level (ppm)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(11; "Carbon Monoxide"; Decimal)
        {
            Caption = 'Carbon Monoxide (ppm)';
            DataClassification = CustomerContent;
            MinValue = 0;
        }
        field(12; "Alarm Triggered"; Boolean)
        {
            Caption = 'Alarm Triggered';
            DataClassification = CustomerContent;
        }
        field(13; "Alarm Time"; DateTime)
        {
            Caption = 'Alarm Time';
            DataClassification = CustomerContent;
        }
        field(14; "Acknowledged By"; Code[50])
        {
            Caption = 'Acknowledged By';
            DataClassification = CustomerContent;
        }
        field(15; "Acknowledged Time"; DateTime)
        {
            Caption = 'Acknowledged Time';
            DataClassification = CustomerContent;
        }
        field(16; "Notes"; Text[500])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
        }
        field(17; "Maintenance Due"; Date)
        {
            Caption = 'Maintenance Due';
            DataClassification = CustomerContent;
        }
        field(18; "Last Maintenance"; Date)
        {
            Caption = 'Last Maintenance';
            DataClassification = CustomerContent;
        }
        field(19; "System Type"; Enum "Fire Alarm System Type")
        {
            Caption = 'System Type';
            DataClassification = CustomerContent;
        }
        field(20; "Installation Date"; Date)
        {
            Caption = 'Installation Date';
            DataClassification = CustomerContent;
        }
    }
    
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "System ID", "Last Updated")
        {
        }
        key(Key3; "Status", "Alarm Triggered")
        {
        }
        key(Key4; "Location", "Zone")
        {
        }
    }
    
    fieldgroups
    {
        fieldgroup(DropDown; "System ID", "Location", "Zone", "Status")
        {
        }
        fieldgroup(Brick; "System ID", "Location", "Status", "Battery Level")
        {
        }
    }
}