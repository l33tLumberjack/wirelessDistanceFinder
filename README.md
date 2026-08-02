wirelessDistanceFinder.pl
=========================

### NAME
        wirelessDistanceFinder.pl - Estimate distances to a WiFi access point based on received signal strength (RSSI)

### SYNOPSIS
        wirelessDistanceFinder.pl -d <decibels> -f <frequency>

        wirelessDistanceFinder.pl --decibels=<dbm> --frequency=<freq_mhz>

        wirelessDistanceFinder.pl --help

    Examples:
    
        # Calculate distance with signal strength of -60 dBm at 2.45 GHz
        wirelessDistanceFinder.pl -d -60 -f 2450
        
        # Using long options (same result)
        wirelessDistanceFinder.pl --decibels=-60 --frequency=2450
        
        # View help information
        wirelessDistanceFinder.pl --help

### DESCRIPTION
        Mandatory arguments to long options are mandatory for short options too.
        
        This tool estimates the approximate distance to a WiFi access point using 
        the free-space path loss model, based on received signal strength (RSSI) 
        and operating frequency.

        See Also: https://stackoverflow.com/questions/11217674/how-to-calculate-distance-from-wifi-router-using-signal-strength

### OPTIONS
        -d, --decibels=<integer>
                        Received signal strength indicator in decibels (dBm).
                        This value should be negative (e.g., -30, -60, -85).
                        
        -f, --frequency=<integer>
                        Operating frequency of the WiFi access point in MHz.
                        Common values: 2412-2472 MHz for 2.4 GHz band.

        -?, -h, --help
                        Display this help message and exit.

### EXAMPLES
    Calculate approximate distance to a router with -60 dBm signal at 2.45 GHz:
    
        wirelessDistanceFinder.pl -d -60 -f 2450
    
    Output will show distances calculated for:
    - 2.4 GHz band (lower bound)
    - 2.5 GHz band (upper bound) 
    - Average of the two
    - Exact frequency specified

### THEORY
        The free-space path loss model estimates distance using:
        
            distance = 10 ^ ((27.55 - (20 * log10(frequency)) + signalLevel) / 20)

        This is based on Friis transmission equation and assumes ideal 
        free-space conditions without obstacles or interference.

### LIMITATIONS
        ⚠️ This tool provides rough estimates only. Real-world factors include:
        
            - Multipath interference from reflections
            - Obstacles (walls, furniture, people) attenuating signals
            - Radio frequency noise and interference
            - Access point transmit power variations
            - Antenna gain differences
            - Environmental conditions

        For accurate positioning, combine RSSI with multiple access points 
        and use more advanced trilateration techniques.

### PREREQUISITES
        perl (with Getopt::Long module)

### SEE ALSO
        aircrack-ng(1), kismet(1), tcpdump(1) - WiFi monitoring tools

        https://en.wikipedia.org/wiki/RSSI
        https://en.wikipedia.org/wiki/Free-space_path_loss

