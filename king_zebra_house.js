// Code for 'The Solar Entrepreneur'

//Declare variable
let solarCompany,
energySource,
solarPanels,
customers,
price,
energyOutput,
netWorth,
startYear;

// Initialize Variables 
solarCompany = "My Solar Company";
energySource = "solar";
solarPanels = [];
customers = 0;
price = 0;
energyOutput = 0;
netWorth = 0;
startYear = 2020;

// Create Functions

// calculatePrice() Function
function calculatePrice(num) {
  return num * customers * energyOutput;
}

// addCustomers() Function
function addCustomers(num) {
  customers += num;
}

// increasePrice() Function
function increasePrice(num) {
  price += num;
}

// installSolarPanels() Function
function installSolarPanels(panelType) {
  solarPanels.push(panelType);
}

// increaseEnergyOutput() Function
function increaseEnergyOutput(num) {
  energyOutput += num;
}

// calculateNetWorth() Function
function calculateNetWorth(num) {
  netWorth += num;
}

// addYear() Function
function addYear() {
 startYear++;
}

// Main Program 

//Create solar panels 
installSolarPanels("SolarCell");
installSolarPanels("SolarArray");

// Increse energy output
increaseEnergyOutput(50);

// Add 10 customers
addCustomers(10);

// Increase Price
increasePrice(10);

//Calculate net worth
calculateNetWorth(calculatePrice(price));

//Increase year
addYear();

//Output message to console
console.log("Welcome to " + solarCompany + ", your solar energy provider! We've been providing solar energy since " + startYear + " and we currently have " + customers + " customers who are satisfy with our " + energySource + " powered panels (" + solarPanels + ") with an energy output of " + energyOutput + ". We continue to strive to provide the best service and have increased our price to " + price + ", giving us a net worth of " + netWorth + "." );