#!/usr/bin/perl
# The Solar Entrepreneur
# This script demonstrates the use of Perl to analyze data related to solar energy 
# usage and the creation of viable solar energy businesses. 

use strict;
use warnings;

# Include libraries
use LWP::UserAgent; 
use HTTP::Request::Common qw(POST); 
use CGI qw/:standard/; 
use JSON; 
use Data::Dumper;

# Declare constants
use constant APIKEY => 'your_api_key'; 

# Get the user input and search for solar data
my $latitude = param('latitude'); 
my $longitude = param('longitude'); 
my $radius = param('radius');
my $url = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&key=".APIKEY;
my $ua = LWP::UserAgent->new;
my $request = POST ($url); 
my $response = $ua->request($request); 

# Convert response into JSON format 
my $json = from_json($response->decoded_content); 
my $results = $json->{'results'}; 

# Extract the required data from results
my $solar_data; 
foreach my $val (@$results) { 
	if($val->{'types'}[0] eq 'solar_panel_supplier') {
		$solar_data->{$val->{'name'}} = $val->{'geometry'}{'location'};	
	}
}

# Establish the max distance varibable
my $max_distance; 

# Iterate over the solar data and calculate the distance between suppliers
foreach my $name (keys %$solar_data) { 
	my $distance = calculate_distance($latitude, $longitude, $solar_data->{$name}{'lat'}, $solar_data->{$name}{'lng'}); 
	if(!defined($max_distance) || $distance > $max_distance) {
		$max_distance = $distance; 
	}
}

# Calculate the maximum energy savings
my $energy_savings = calculate_energy_savings($max_distance);

# Print the output
print "The maximum energy savings for a solar energy business within a radius of $radius miles is $energy_savings kWh.\n";

# Function to calculate the distance between two points
sub calculate_distance { 
	my ($lat1, $lon1, $lat2, $lon2) = @_; 
	# Calculate the distance using the Haversine formula
	my $pi = 3.1415926535; 
	my $dlon = $lon2 - $lon1; 
	my $dlat = $lat2 - $lat1; 
	my $a = (sin($dlat/2))**2 + cos($lat1) * cos($lat2) * (sin($dlon/2))**2; 
	my $c = 2 * atan2(sqrt($a), sqrt(1-$a)); 
	my $d = 6371 * $c;
	return $d; 
}

# Function to calculate the energy savings
sub calculate_energy_savings { 
	my ($distance) = @_; 
	# Assume a reduction of 2% of energy for every 20 miles
	my $energy_savings = (1 - ($distance/20)*0.02)*100; 
	return $energy_savings; 
}