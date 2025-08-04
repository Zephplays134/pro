# Ithaca York High School Fire Alarm System Monitor

A real-time monitoring addon for Dynamics 365 Business Central that provides comprehensive fire alarm system status tracking for Ithaca York High School.

## Overview

This addon enables real-time monitoring of fire alarm systems throughout the school campus, providing instant alerts, status tracking, and maintenance management capabilities. It's designed to enhance safety and provide peace of mind for school administrators and facility managers.

## Features

### 🔥 Real-Time Monitoring
- Live status updates from all fire alarm systems
- Real-time sensor readings (temperature, smoke, carbon monoxide)
- Battery level and signal strength monitoring
- Automatic status updates and alerts

### 🚨 Alarm Management
- Instant alarm notifications
- Alarm acknowledgment tracking
- Historical alarm data
- Zone-based alarm identification

### 📊 Dashboard & Analytics
- Comprehensive dashboard with system overview
- Statistical analysis of system performance
- Maintenance scheduling and tracking
- Export capabilities for reporting

### 🏫 Ithaca York High School Specific
- Pre-configured zones and locations
- Campus-specific system mapping
- School building layout integration
- Emergency response coordination

## System Requirements

- Dynamics 365 Business Central (version 22.0 or later)
- AL Development Environment
- Minimum 2GB RAM
- Network connectivity for real-time updates

## Installation

1. **Download the Addon**
   ```bash
   git clone https://github.com/zephplays134/ithaca-york-fire-alarm-monitor.git
   ```

2. **Open in AL Development Environment**
   - Open the project in Visual Studio Code with AL extension
   - Or use the Business Central AL Development Environment

3. **Publish the Addon**
   - Build the project
   - Publish to your Business Central environment

4. **Initialize Sample Data**
   - Navigate to the Fire Alarm Dashboard
   - Click "Initialize Sample Data" to set up Ithaca York High School systems

## Usage

### Dashboard Overview
The main dashboard provides:
- **System Overview**: Total systems, normal status, active alarms, warnings, faults, and offline systems
- **Real-Time Status**: Live list of all fire alarm systems with current status
- **Quick Actions**: Refresh data, initialize sample data, view active alarms
- **Statistics**: Average battery levels, signal strength, temperature, and maintenance due

### Monitoring Fire Alarm Systems
1. **View All Systems**: Navigate to "Fire Alarm System List" to see all systems
2. **Individual Details**: Click on any system to view detailed information
3. **Real-Time Updates**: Use the "Refresh Data" action to get latest status
4. **Alarm Management**: Acknowledge alarms and track response times

### Key Locations at Ithaca York High School
- **Main Building - First Floor** (Zone A1): Systems ITHACA01-ITHACA03
- **Main Building - Second Floor** (Zone A2): Systems ITHACA04-ITHACA06
- **Science Wing** (Zone B1): Systems ITHACA07-ITHACA09
- **Gymnasium** (Zone C1): Systems ITHACA10-ITHACA12
- **Administrative Offices** (Zone D1): Systems ITHACA13-ITHACA15

## System Status Types

| Status | Description | Action Required |
|--------|-------------|-----------------|
| **Normal** | System operating normally | None |
| **Warning** | Minor issue detected | Monitor closely |
| **Alarm** | Fire alarm triggered | Immediate response required |
| **Fault** | System malfunction | Technical support needed |
| **Maintenance** | System under maintenance | Scheduled maintenance |
| **Offline** | System not responding | Check connectivity |
| **Test** | System in test mode | Normal during testing |
| **Disabled** | System temporarily disabled | Re-enable when needed |
| **Low Battery** | Battery level below 20% | Replace battery |
| **Communication Error** | Communication issues | Check network |

## Sensor Readings

### Temperature
- **Normal Range**: 18-33°C
- **Warning**: Above 30°C
- **Alarm**: Above 35°C

### Smoke Level
- **Normal**: 0 ppm
- **Warning**: 1-50 ppm
- **Alarm**: Above 50 ppm

### Carbon Monoxide
- **Normal**: 0 ppm
- **Warning**: 1-25 ppm
- **Alarm**: Above 25 ppm

### Battery Level
- **Good**: 80-100%
- **Warning**: 20-79%
- **Critical**: Below 20%

### Signal Strength
- **Excellent**: 90-100%
- **Good**: 70-89%
- **Poor**: Below 70%

## Emergency Procedures

### When an Alarm is Triggered
1. **Immediate Response**
   - System automatically sends notifications
   - Check the dashboard for alarm details
   - Verify location and zone information

2. **Acknowledgment**
   - Click "Acknowledge Alarm" in the system details
   - Record response time and actions taken
   - Update notes with emergency response details

3. **Follow-up**
   - Investigate the cause of the alarm
   - Reset system after resolution
   - Document incident in system notes

## Maintenance

### Scheduled Maintenance
- **Monthly**: Visual inspection and basic testing
- **Quarterly**: Comprehensive system testing
- **Annually**: Full system inspection and calibration

### Maintenance Tracking
- Monitor "Maintenance Due" dates in the dashboard
- Update "Last Maintenance" after completion
- Record maintenance activities in system notes

## Configuration

### Customizing for Your School
1. **Update Locations**: Modify location names in the data service
2. **Adjust Zones**: Update zone codes to match your building layout
3. **System Types**: Configure appropriate fire alarm system types
4. **Thresholds**: Adjust sensor thresholds based on your requirements

### Integration Options
- **Email Notifications**: Configure email alerts for alarms
- **SMS Alerts**: Set up SMS notifications for critical events
- **Emergency Services**: Integrate with local fire department systems
- **Building Management**: Connect with building automation systems

## Troubleshooting

### Common Issues

**System Shows Offline**
- Check network connectivity
- Verify system power supply
- Review communication settings

**False Alarms**
- Check sensor calibration
- Review environmental conditions
- Verify system sensitivity settings

**Battery Issues**
- Replace batteries when level drops below 20%
- Check battery connections
- Verify backup power systems

### Support
For technical support or questions:
- Check the system logs for error messages
- Review the troubleshooting guide
- Contact the development team

## Development

### Project Structure
```
src/
├── Tables/
│   └── Table50100.FireAlarmSystem.al
├── Pages/
│   ├── Page50100.FireAlarmSystemList.al
│   ├── Page50101.FireAlarmSystemCard.al
│   └── Page50102.FireAlarmDashboard.al
├── Codeunits/
│   └── Codeunit50100.FireAlarmDataService.al
└── Enums/
    ├── Enum50100.FireAlarmStatus.al
    └── Enum50101.FireAlarmSystemType.al
```

### Extending the Addon
- Add new sensor types in the table structure
- Create additional status types in the enum
- Implement new notification methods
- Add reporting and analytics features

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Version History

- **v1.0.0**: Initial release with basic monitoring capabilities
- Future versions will include enhanced reporting, mobile app integration, and advanced analytics

---

**Important**: This addon is designed for educational and demonstration purposes. For production use in actual fire alarm systems, ensure compliance with local fire safety regulations and consult with qualified fire safety professionals.