enum 50101 "Fire Alarm System Type"
{
    Extensible = true;
    
    value(0; Conventional)
    {
        Caption = 'Conventional';
    }
    value(1; Addressable)
    {
        Caption = 'Addressable';
    }
    value(2; Wireless)
    {
        Caption = 'Wireless';
    }
    value(3; Hybrid)
    {
        Caption = 'Hybrid';
    }
    value(4; VoiceEvacuation)
    {
        Caption = 'Voice Evacuation';
    }
    value(5; Aspirating)
    {
        Caption = 'Aspirating';
    }
    value(6; BeamDetector)
    {
        Caption = 'Beam Detector';
    }
    value(7; FlameDetector)
    {
        Caption = 'Flame Detector';
    }
    value(8; HeatDetector)
    {
        Caption = 'Heat Detector';
    }
    value(9; SmokeDetector)
    {
        Caption = 'Smoke Detector';
    }
}